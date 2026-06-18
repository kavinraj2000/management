// lib/presentation/pages/discovery/discovery_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tvkapp/src/core/theme/app_theme.dart';
import 'package:tvkapp/src/core/widget/filter_bottom_sheet.dart';
import 'package:tvkapp/src/core/widget/profile_card.dart';
import 'package:tvkapp/src/core/widget/shimmer_loader.dart';
import 'package:tvkapp/src/feature/screens/discovery/bloc/dicovery_bloc.dart';


class DiscoveryPage extends StatelessWidget {
  const DiscoveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _DiscoveryContent();
  }
}

class _DiscoveryContent extends StatefulWidget {
  const _DiscoveryContent();

  @override
  State<_DiscoveryContent> createState() => _DiscoveryContentState();
}

class _DiscoveryContentState extends State<_DiscoveryContent> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<DiscoveryBloc>().add(const DiscoveryLoadProfiles());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<DiscoveryBloc>().add(const DiscoveryLoadMore());
    }
  }

  void _onSearch(String query) {
    if (query.length >= 2 || query.isEmpty) {
      context.read<DiscoveryBloc>().add(DiscoverySearchProfiles(query));
    }
  }

  void _showFilterSheet() {
    final state = context.read<DiscoveryBloc>().state;
    String? currentGender;
    int? minAge;
    int? maxAge;

    if (state.status==DiscoveryStatus.success) {
      currentGender = state.genderFilter;
      minAge = state.minAge;
      maxAge = state.maxAge;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => FilterBottomSheet(
        currentGender: currentGender,
        currentMinAge: minAge,
        currentMaxAge: maxAge,
        onApply: (gender, min, max) {
          context.read<DiscoveryBloc>().add(
                DiscoveryFilterProfiles(
                  gender: gender,
                  minAge: min,
                  maxAge: max,
                ),
              );
        },
        onReset: () {
          context.read<DiscoveryBloc>().add(
                const DiscoveryFilterProfiles(),
              );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),

            // Search + Filter bar
            _buildSearchBar(),

            // Content
            Expanded(
              child: BlocBuilder<DiscoveryBloc, DiscoveryState>(
                builder: (context, state) {
                  if (state.status==DiscoveryStatus.loading) {
                    return const ShimmerProfileLoader();
                  }

                  if (state.status==DiscoveryStatus.failure) {
                    return AppErrorWidget(
                      message: state.errorMessage!,
                      onRetry: () => context
                          .read<DiscoveryBloc>()
                          .add(const DiscoveryLoadProfiles()),
                    );
                  }

                  if (state.status==DiscoveryStatus.success) {
                    if (state.profiles.isEmpty) {
                      return EmptyStateWidget(
                        icon: Icons.search_off_rounded,
                        title: 'No Profiles Found',
                        subtitle: state.searchQuery.isNotEmpty
                            ? 'Try different search terms'
                            : 'Pull down to refresh',
                        actionLabel: 'Refresh',
                        onAction: () => context
                            .read<DiscoveryBloc>()
                            .add(const DiscoveryRefresh()),
                      );
                    }

                    return RefreshIndicator(
                      color: AppTheme.primaryColor,
                      onRefresh: () async {
                        context
                            .read<DiscoveryBloc>()
                            .add(const DiscoveryRefresh());
                      },
                      child: GridView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.72,
                        ),
                        itemCount: state.profiles.length +
                            (state.status==DiscoveryStatus.loadingMore ? 2 : 0),
                        itemBuilder: (context, index) {
                          if (index >= state.profiles.length) {
                            return const ShimmerCard();
                          }
                          final profile = state.profiles[index];
                          return ProfileCard(
                            profile: profile,
                            onTap: () =>
                                context.push('/profile-detail/${profile.id}'),
                            onFavorite: () {
                              context.read<DiscoveryBloc>().add(
                                    DiscoveryToggleFavorite(profile.id),
                                  );
                            },
                          );
                        },
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 16.h, 20.w, 8.h),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Discover',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              Text(
                'Find interesting people',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
              ),
            ],
          ),
          const Spacer(),
          BlocBuilder<DiscoveryBloc, DiscoveryState>(
            builder: (context, state) {
              final hasFilter = state.status==DiscoveryStatus.success &&
                  (state.genderFilter != null ||
                      state.minAge != null ||
                      state.maxAge != null);

              return Stack(
                children: [
                  IconButton(
                    onPressed: _showFilterSheet,
                    icon: const Icon(Icons.tune_rounded),
                    style: IconButton.styleFrom(
                      backgroundColor: hasFilter
                          ? AppTheme.primaryColor.withOpacity(0.1)
                          : null,
                      foregroundColor: hasFilter
                          ? AppTheme.primaryColor
                          : null,
                    ),
                  ),
                  if (hasFilter)
                    Positioned(
                      top: 6,
                      right: 6,
                      child: Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: const BoxDecoration(
                          color: AppTheme.primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 8.h),
      child: BlocBuilder<DiscoveryBloc, DiscoveryState>(
        buildWhen: (previous, current) =>
            previous.searchQuery != current.searchQuery,
        builder: (context, state) {
          return TextField(
            controller: _searchController,
            onChanged: _onSearch,
            decoration: InputDecoration(
              hintText: 'Search by name, job, location...',
              prefixIcon: const Icon(Icons.search_rounded),
              suffixIcon: state.searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear_rounded),
                      onPressed: () {
                        _searchController.clear();
                        _onSearch('');
                      },
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}