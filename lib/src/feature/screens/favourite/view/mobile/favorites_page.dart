// lib/presentation/pages/discovery/favorites_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tvkapp/src/core/theme/app_theme.dart';
import 'package:tvkapp/src/core/widget/profile_card.dart';
import 'package:tvkapp/src/core/widget/shimmer_loader.dart';
import 'package:tvkapp/src/feature/screens/favourite/bloc/favourite_bloc.dart';


class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Profiles')),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading || state is FavoritesInitial) {
            return const ShimmerProfileLoader();
          }

          if (state is FavoritesError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline_rounded,
                      size: 64, color: AppTheme.errorColor),
                  SizedBox(height: 16.h),
                  Text(state.message),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () => context
                        .read<FavoritesBloc>()
                        .add(const FavoritesLoadRequested()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is FavoritesLoaded) {
            if (state.profiles.isEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(32.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_outline_rounded,
                        size: 80,
                        color: AppTheme.primaryColor.withOpacity(0.3),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'No Saved Profiles',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Tap the heart icon on any profile to save it here',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24.h),
                      ElevatedButton.icon(
                        onPressed: () => context.go('/discovery'),
                        icon: const Icon(Icons.explore_rounded),
                        label: const Text('Browse Profiles'),
                      ),
                    ],
                  ),
                ),
              );
            }

            return GridView.builder(
              padding: EdgeInsets.all(16.w),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12.h,
                crossAxisSpacing: 12.w,
                childAspectRatio: 0.72,
              ),
              itemCount: state.profiles.length,
              itemBuilder: (context, index) {
                final profile = state.profiles[index];
                return ProfileCard(
                  profile: profile,
                  onTap: () =>
                      context.push('/profile-detail/${profile.id}'),
                  onFavorite: () => context
                      .read<FavoritesBloc>()
                      .add(FavoritesRemoveProfile(profile.id)),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
