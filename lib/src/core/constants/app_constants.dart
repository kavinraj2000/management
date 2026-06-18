
class AppConstants {
  AppConstants();

  final String appName = 'ProfileHub';
  final String appVersion = '1.0.0';

  final String keyIsLoggedIn = 'is_logged_in';
  final String keyUserId = 'user_id';
  final String keyUserEmail = 'user_email';
  final String keyUserName = 'user_name';
  final String keyIsDarkMode = 'is_dark_mode';
  final String keyAuthToken = 'auth_token';
  final String keyOnboardingComplete = 'onboarding_complete';

  final String dbName = 'profile_discovery.db';
  final int dbVersion = 1;

  final String tableUsers = 'users';
  final String tableProfiles = 'profiles';
  final String tableFavorites = 'favorites';

  final int profilesPerPage = 10;

  final int maxImageSizeBytes = 5 * 1024 * 1024;

  final int minPasswordLength = 6;
  final int maxBioLength = 300;
}
