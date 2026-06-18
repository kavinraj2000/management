// lib/presentation/pages/settings/settings_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tvkapp/src/core/theme/app_theme.dart';
import 'package:tvkapp/src/feature/auth/bloc/auth_bloc.dart';
import 'package:tvkapp/src/feature/screens/settings/bloc/setting_bloc.dart';


class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status==AuthStatus.authenticated) {
            context.go('/auth/login');
          }
        },
        builder: (context, authState) {
          return ListView(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            children: [
              // Account section
              _SectionHeader(label: 'Account'),
              _SettingsTile(
                icon: Icons.person_outline_rounded,
                title: 'Edit Profile',
                subtitle: 'Update your personal information',
                onTap: () => context.push('/edit-profile'),
              ),
              _SettingsTile(
                icon: Icons.lock_outline_rounded,
                title: 'Change Password',
                subtitle: 'Update your account password',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Feature coming soon'),
                        behavior: SnackBarBehavior.floating),
                  );
                },
              ),

              SizedBox(height: 8.h),
              // Appearance
              _SectionHeader(label: 'Appearance'),
              BlocBuilder<SettingsBloc, SettingsState>(
                builder: (context, state) {
                  return _SwitchTile(
                    icon: state.isDarkMode
                        ? Icons.dark_mode_rounded
                        : Icons.light_mode_rounded,
                    title: 'Dark Mode',
                    subtitle: state.isDarkMode ? 'Dark theme enabled' : 'Light theme enabled',
                    value: state.isDarkMode,
                    onChanged: (_) =>
                        context.read<SettingsBloc>().add(const SettingsToggleDarkMode()),
                  );
                },
              ),

              SizedBox(height: 8.h),
              // Notifications
              _SectionHeader(label: 'Notifications'),
              _SwitchTile(
                icon: Icons.notifications_outlined,
                title: 'Push Notifications',
                subtitle: 'Get notified about new matches',
                value: true,
                onChanged: (_) {},
              ),

              SizedBox(height: 8.h),
              // Support
              _SectionHeader(label: 'Support'),
              _SettingsTile(
                icon: Icons.help_outline_rounded,
                title: 'Help & FAQ',
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.description_outlined,
                title: 'Terms of Service',
                onTap: () {},
              ),
              _SettingsTile(
                icon: Icons.info_outline_rounded,
                title: 'App Version',
                subtitle: 'v1.0.0',
                onTap: null,
                showArrow: false,
              ),

              SizedBox(height: 16.h),
              // Logout
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.errorColor,
                    side: const BorderSide(color: AppTheme.errorColor),
                    minimumSize: Size(double.infinity, 52.h),
                  ),
                  onPressed: () => _showLogoutDialog(context),
                  icon: const Icon(Icons.logout_rounded),
                  label: const Text('Sign Out'),
                ),
              ),
              SizedBox(height: 24.h),
            ],
          );
        },
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.errorColor),
            onPressed: () {
              Navigator.pop(ctx);
              context.read<AuthBloc>().add(const AuthLogoutRequested());
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String label;
  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: AppTheme.primaryColor,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool showArrow;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(icon, color: AppTheme.primaryColor, size: 20),
      ),
      title: Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      subtitle: subtitle != null
          ? Text(subtitle!,
              style: TextStyle(fontSize: 12, color: AppTheme.textSecondary))
          : null,
      trailing: showArrow
          ? Icon(Icons.arrow_forward_ios_rounded,
              size: 14, color: AppTheme.textSecondary)
          : null,
      onTap: onTap,
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(icon, color: AppTheme.primaryColor, size: 20),
      ),
      title: Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      subtitle: subtitle != null
          ? Text(subtitle!,
              style: TextStyle(fontSize: 12, color: AppTheme.textSecondary))
          : null,
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppTheme.primaryColor,
      ),
    );
  }
}
