// lib/core/utils/app_router.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:profilediscovery/src/core/services/service_locator.dart';
import 'package:profilediscovery/src/core/widget/home_shell.dart';
import 'package:profilediscovery/src/core/widget/splash_screen.dart';
import 'package:profilediscovery/src/data/repo/prefernces_repo.dart';
import 'package:profilediscovery/src/feature/presentation/forgot/forgot_mobile_view.dart';
import 'package:profilediscovery/src/feature/presentation/login/login_mobile_view.dart';
import 'package:profilediscovery/src/feature/presentation/register/register_mobile_view.dart';
import 'package:profilediscovery/src/feature/screens/discovery/view/mobile/discovery_mobile_view.dart';


final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

class AppRouter {
  final _prefs = sl<PreferencesService>();

  // ✅ Correct type (GoRouter, not GoRoute) and initialized in a getter
  late final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    redirect: (context, state) {
      final isLoggedIn = _prefs.isLoggedIn;
      final isOnAuth = state.matchedLocation.startsWith('/auth');
      final isSplash = state.matchedLocation == '/splash';

      if (isSplash) return null;
      if (!isLoggedIn && !isOnAuth) return '/auth/login';
      if (isLoggedIn && isOnAuth) return '/discovery';

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/auth/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/auth/register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/auth/forgot-password',
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => HomeShell(child: child),
        routes: [
          GoRoute(
            path: '/discovery',
            parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) => const DiscoveryPage(),
          ),
          GoRoute(
            path: '/favorites',
            parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) => const FavoritesPage(),
          ),
          GoRoute(
            path: '/profile',
            parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) => const MyProfilePage(),
          ),
          GoRoute(
            path: '/settings',
            parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) => const SettingsPage(),
          ),
        ],
      ),
      GoRoute(
        path: '/profile-detail/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ProfileDetailPage(profileId: id);
        },
      ),
      GoRoute(
        path: '/edit-profile',
        builder: (context, state) => const EditProfilePage(),
      ),
    ],
  );
}