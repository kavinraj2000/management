// lib/presentation/pages/profile/my_profile_page.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profilediscovery/src/core/theme/app_theme.dart';
import 'package:profilediscovery/src/data/domain/user_entity.dart';
import 'package:profilediscovery/src/feature/screens/profile/bloc/profile_bloc.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state.status==ProfileStatus.loading || state.status==ProfileStatus.initial) {
          return const Scaffold(
            body: Center(
                child: CircularProgressIndicator(
                    color: AppTheme.primaryColor)),
          );
        }
        if (state.status==ProfileStatus.success) {
          return _ProfileContent(user: state.user!);
        }
        return const Scaffold(
          body: Center(child: Text('Unable to load profile')),
        );
      },
    );
  }
}

class _ProfileContent extends StatelessWidget {
  final UserEntity user;
  const _ProfileContent({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.h,
            pinned: true,
            title: const Text('My Profile'),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_rounded),
                onPressed: () => context.push('/edit-profile'),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: _buildProfileHeader(context),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoCard(context),
                  SizedBox(height: 16.h),
                  if (user.aboutMe != null && user.aboutMe!.isNotEmpty) ...[
                    _buildAboutCard(context),
                    SizedBox(height: 16.h),
                  ],
                  _buildStatsCard(context),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppTheme.primaryColor, AppTheme.primaryDark],
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => _pickImage(context),
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 40.r,
                      backgroundColor: Colors.white,
                      backgroundImage: user.profilePicture != null &&
                              user.profilePicture!.isNotEmpty &&
                              File(user.profilePicture!).existsSync()
                          ? FileImage(File(user.profilePicture!))
                          : null,
                      child: user.profilePicture == null ||
                              !File(user.profilePicture ?? '').existsSync()
                          ? Icon(Icons.person_rounded,
                              size: 40, color: AppTheme.primaryColor)
                          : null,
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppTheme.primaryColor, width: 1.5),
                        ),
                        child: Icon(Icons.camera_alt_rounded,
                            size: 12, color: AppTheme.primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InfoRow(
                icon: Icons.person_outline,
                label: 'Full Name',
                value: user.fullName),
            _divider(),
            _InfoRow(
                icon: Icons.email_outlined,
                label: 'Email',
                value: user.email),
            if (user.phone != null && user.phone!.isNotEmpty) ...[
              _divider(),
              _InfoRow(
                  icon: Icons.phone_outlined,
                  label: 'Phone',
                  value: user.phone!),
            ],
            if (user.age != null) ...[
              _divider(),
              _InfoRow(
                  icon: Icons.cake_outlined,
                  label: 'Age',
                  value: '${user.age} years'),
            ],
            if (user.occupation != null &&
                user.occupation!.isNotEmpty) ...[
              _divider(),
              _InfoRow(
                  icon: Icons.work_outline,
                  label: 'Occupation',
                  value: user.occupation!),
            ],
            if (user.location != null && user.location!.isNotEmpty) ...[
              _divider(),
              _InfoRow(
                  icon: Icons.location_on_outlined,
                  label: 'Location',
                  value: user.location!),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAboutCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('About Me',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600)),
            SizedBox(height: 8.h),
            Text(user.aboutMe!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.6,
                      color: AppTheme.textSecondary,
                    )),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _StatItem(label: 'Profile\nViews', value: '142'),
            Container(
                height: 40.h,
                width: 1,
                color: AppTheme.dividerColor),
            _StatItem(label: 'Saved\nProfiles', value: '8'),
            Container(
                height: 40.h,
                width: 1,
                color: AppTheme.dividerColor),
            _StatItem(label: 'Days\nActive', value: '12'),
          ],
        ),
      ),
    );
  }

  Widget _divider() => Divider(height: 16.h, color: AppTheme.dividerColor);

  void _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
        source: ImageSource.gallery, imageQuality: 70);
    if (picked != null) {
      context
          .read<ProfileBloc>()
          .add(ProfilePictureUpdateRequested(picked.path));
    }
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow(
      {required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppTheme.primaryColor),
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

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppTheme.primaryColor)),
        SizedBox(height: 4.h),
        Text(label,
            style: TextStyle(
                fontSize: 11,
                color: AppTheme.textSecondary),
            textAlign: TextAlign.center),
      ],
    );
  }
}
