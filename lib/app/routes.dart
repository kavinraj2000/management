// lib/core/utils/app_router.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:profilediscovery/app/route_name.dart';
import 'package:profilediscovery/src/core/services/service_locator.dart';
import 'package:profilediscovery/src/core/widget/homeshell.dart';
import 'package:profilediscovery/src/data/repo/prefernces_repo.dart';
import 'package:profilediscovery/src/feature/presentation/forgot/forgot_view.dart';
import 'package:profilediscovery/src/feature/presentation/login/login_view.dart';
import 'package:profilediscovery/src/feature/presentation/register/register_view.dart';
import 'package:profilediscovery/src/feature/screens/discovery/view/discovery_view.dart';
import 'package:profilediscovery/src/feature/screens/favourite/view/favourite_view.dart';
import 'package:profilediscovery/src/feature/screens/discovery/view/mobile/profile_detail_page.dart';
import 'package:profilediscovery/src/feature/screens/profile/view/mobile/edit_profile_page.dart';
import 'package:profilediscovery/src/feature/screens/profile/view/profile_view.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

class AppRouter {
  final _prefs = sl<PreferencesService>();

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
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => HomeShell(child: child),
        routes: [
          GoRoute(
            path: '/discovery',
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
        ],
      ),
      GoRoute(
        path: '/profile-detail/:id',
        name: RouteName.profileDetail,

        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ProfileDetailPage(profileId: id);
        },
      ),
      GoRoute(
        path: '/edit-profile',
        name: RouteName.editProfile,

        builder: (context, state) => const EditProfilePage(),
      ),
    ],
  );
}
