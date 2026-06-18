// lib/core/utils/app_router.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
<<<<<<< HEAD
import 'package:tvkapp/app/route_name.dart';
import 'package:tvkapp/src/core/services/service_locator.dart';
import 'package:tvkapp/src/core/widget/homeshell.dart';
import 'package:tvkapp/src/data/repo/prefernces_repo.dart';
import 'package:tvkapp/src/feature/presentation/forgot/forgot_view.dart';
import 'package:tvkapp/src/feature/presentation/login/login_view.dart';
import 'package:tvkapp/src/feature/presentation/register/register_view.dart';
import 'package:tvkapp/src/feature/screens/discovery/view/discovery_view.dart';
import 'package:tvkapp/src/feature/screens/favourite/view/favourite_view.dart';
import 'package:tvkapp/src/feature/screens/discovery/view/mobile/profile_detail_page.dart';
import 'package:tvkapp/src/feature/screens/profile/view/mobile/edit_profile_page.dart';
import 'package:tvkapp/src/feature/screens/profile/view/profile_view.dart';
=======
import 'package:profilediscovery/src/core/services/service_locator.dart';
import 'package:profilediscovery/src/core/widget/home_shell.dart';
import 'package:profilediscovery/src/core/widget/splash_screen.dart';
import 'package:profilediscovery/src/data/repo/prefernces_repo.dart';
import 'package:profilediscovery/src/feature/presentation/forgot/forgot_mobile_view.dart';
import 'package:profilediscovery/src/feature/presentation/login/login_mobile_view.dart';
import 'package:profilediscovery/src/feature/presentation/register/register_mobile_view.dart';
import 'package:profilediscovery/src/feature/screens/discovery/view/mobile/discovery_mobile_view.dart';

>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

class AppRouter {
  final _prefs = sl<PreferencesService>();

<<<<<<< HEAD
  late final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteName.login,
    // redirect: (context, state) {
    //   final isLoggedIn = _prefs.isLoggedIn;
    //   final isOnAuth = state.matchedLocation.startsWith('/auth');
    //   final isSplash = state.matchedLocation == '/splash';

    //   if (isSplash) return null;
    //   if (!isLoggedIn && !isOnAuth) return '/auth/login';
    //   if (isLoggedIn && isOnAuth) return '/discovery';

    //   return null;
    // },
    routes: [
      // GoRoute(
      //   path: '/splash',
      //   builder: (context, state) => const SplashPage(),
      // ),
      GoRoute(
        path: '/auth/login',
        name: RouteName.login,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: '/auth/register',
        name: RouteName.register,

        builder: (context, state) => const RegisterView(),
      ),
      GoRoute(
        path: '/auth/forgot-password',
        name: RouteName.forgotPassword,

        builder: (context, state) => const ForgotView(),
=======
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
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => HomeShell(child: child),
        routes: [
          GoRoute(
            path: '/discovery',
<<<<<<< HEAD
            name: RouteName.discovery,

            parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) => const DiscoveryView(),
          ),
          GoRoute(
            path: '/favorites',
            name: RouteName.favorites,

            parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) => const FavouriteView(),
          ),
          GoRoute(
            path: '/profile',
            name: RouteName.profile,

            parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) => const ProfileView(),
          ),
          // GoRoute(
          //   path: '/settings',
          //   parentNavigatorKey: _shellNavigatorKey,
          //   builder: (context, state) => const SettingsPage(),
          // ),
=======
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
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
        ],
      ),
      GoRoute(
        path: '/profile-detail/:id',
<<<<<<< HEAD
        name: RouteName.profileDetail,

=======
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ProfileDetailPage(profileId: id);
        },
      ),
      GoRoute(
        path: '/edit-profile',
<<<<<<< HEAD
        name: RouteName.editProfile,

=======
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
        builder: (context, state) => const EditProfilePage(),
      ),
    ],
  );
<<<<<<< HEAD
}
=======
}
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
