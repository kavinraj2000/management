// lib/presentation/pages/discovery/profile_detail_page.dart

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tvkapp/src/core/theme/app_theme.dart';
import 'package:tvkapp/src/data/domain/user_entity.dart';
import 'package:tvkapp/src/feature/screens/discovery/bloc/dicovery_bloc.dart';
import 'package:tvkapp/src/feature/screens/profile/repo/profile_repo.dart';


class ProfileDetailPage extends StatefulWidget {
  final String profileId;
  const ProfileDetailPage({super.key, required this.profileId});

  @override
  State<ProfileDetailPage> createState() => _ProfileDetailPageState();
}

class _ProfileDetailPageState extends State<ProfileDetailPage> {
  ProfileEntity? _profile;
  bool _isLoading = true;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final repo = context.read<ProfileRepository>();
      final profile = await repo.getProfileById(widget.profileId);
      if (mounted) {
        setState(() {
          _profile = profile;
          _isFavorite = profile?.isFavorite ?? false;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _toggleFavorite() async {
    if (_profile == null) return;
    final repo = context.read<ProfileRepository>();
    await repo.toggleFavorite(_profile!.id);
    setState(() => _isFavorite = !_isFavorite);
    // Also update the discovery list
    context.read<DiscoveryBloc>().add(DiscoveryToggleFavorite(_profile!.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppTheme.primaryColor))
          : _profile == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_off_rounded,
                          size: 64, color: AppTheme.textSecondary),
                      SizedBox(height: 16.h),
                      Text('Profile not found',
                          style: Theme.of(context).textTheme.headlineSmall),
                      SizedBox(height: 16.h),
                      ElevatedButton(
                          onPressed: () => context.pop(),
                          child: const Text('Go Back')),
                    ],
                  ),
                )
              : _buildContent(),
    );
  }

  Widget _buildContent() {
    final p = _profile!;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 320.h,
          pinned: true,
          leading: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.black38,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white, size: 18),
            ),
            onPressed: () => context.pop(),
          ),
          actions: [
            IconButton(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.black38,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _isFavorite
                      ? Icons.favorite_rounded
                      : Icons.favorite_outline_rounded,
                  color: _isFavorite ? Colors.red : Colors.white,
                  size: 18,
                ),
              ),
              onPressed: _toggleFavorite,
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: p.profilePicture != null &&
                    p.profilePicture!.startsWith('http')
                ? CachedNetworkImage(
                    imageUrl: p.profilePicture!,
                    fit: BoxFit.cover,
                    errorWidget: (_, __, ___) => _buildPlaceholderBg(),
                  )
                : _buildPlaceholderBg(),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name + gender
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        p.fullName,
                        style:
                            Theme.of(context).textTheme.headlineLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                    ),
                    if (p.age != null)
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          '${p.age} yrs',
                          style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                  ],
                ),
                if (p.occupation != null) ...[
                  SizedBox(height: 4.h),
                  Text(
                    p.occupation!,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
                SizedBox(height: 16.h),

                // Info chips
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: [
                    if (p.location != null)
                      _InfoChip(
                          icon: Icons.location_on_rounded,
                          label: p.location!),
                    if (p.gender != null)
                      _InfoChip(
                          icon: Icons.person_rounded,
                          label: p.gender!.capitalize()),
                  ],
                ),
                SizedBox(height: 24.h),

                // About
                if (p.aboutMe != null) ...[
                  _SectionTitle('About Me'),
                  SizedBox(height: 8.h),
                  Text(
                    p.aboutMe!,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          height: 1.6,
                          color: AppTheme.textSecondary,
                        ),
                  ),
                  SizedBox(height: 24.h),
                ],

                // Contact Info
                _SectionTitle('Contact Information'),
                SizedBox(height: 12.h),
                if (p.email != null && p.email!.isNotEmpty)
                  _ContactRow(
                      icon: Icons.email_outlined, label: 'Email', value: p.email!),
                if (p.phone != null && p.phone!.isNotEmpty) ...[
                  SizedBox(height: 12.h),
                  _ContactRow(
                      icon: Icons.phone_outlined,
                      label: 'Phone',
                      value: p.phone!),
                ],
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholderBg() {
    return Container(
      color: AppTheme.primaryColor,
      child: Center(
        child: Icon(Icons.person_rounded, size: 80, color: Colors.white30),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppTheme.dividerColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppTheme.primaryColor),
          SizedBox(width: 6.w),
          Text(label,
              style: TextStyle(
                  fontSize: 13, color: AppTheme.textSecondary)),
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _ContactRow(
      {required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, color: AppTheme.primaryColor, size: 20),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(
                    fontSize: 11, color: AppTheme.textSecondary)),
            Text(value,
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w500)),
          ],
        ),
      ],
    );
  }
}

extension StringExtension on String {
  String capitalize() =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}
