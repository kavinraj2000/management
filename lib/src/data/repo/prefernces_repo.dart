// lib/data/datasources/local/preferences_service.dart

import 'package:profilediscovery/src/core/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static final PreferencesService _instance = PreferencesService._internal();
  factory PreferencesService() => _instance;
  PreferencesService._internal();

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ─── AUTH ─────────────────────────────────────────────────

  Future<void> setLoggedIn(bool value) async =>
      await _prefs.setBool(Constants.APP.keyIsLoggedIn, value);

  bool get isLoggedIn => _prefs.getBool(Constants.APP.keyIsLoggedIn) ?? false;

  Future<void> saveUserSession({
    required String userId,
    required String email,
    required String name,
    String? token,
  }) async {
    await _prefs.setString(Constants.APP.keyUserId, userId);
    await _prefs.setString(Constants.APP.keyUserEmail, email);
    await _prefs.setString(Constants.APP.keyUserName, name);
    if (token != null) {
      await _prefs.setString(Constants.APP.keyAuthToken, token);
    }
    await setLoggedIn(true);
  }

  Future<void> clearSession() async {
    await _prefs.remove(Constants.APP.keyUserId);
    await _prefs.remove(Constants.APP.keyUserEmail);
    await _prefs.remove(Constants.APP.keyUserName);
    await _prefs.remove(Constants.APP.keyAuthToken);
    await setLoggedIn(false);
  }

  String? get userId => _prefs.getString(Constants.APP.keyUserId);
  String? get userEmail => _prefs.getString(Constants.APP.keyUserEmail);
  String? get userName => _prefs.getString(Constants.APP.keyUserName);
  String? get authToken => _prefs.getString(Constants.APP.keyAuthToken);


  Future<void> setDarkMode(bool value) async =>
      await _prefs.setBool(Constants.APP.keyIsDarkMode, value);

  bool get isDarkMode => _prefs.getBool(Constants.APP.keyIsDarkMode) ?? false;

  Future<void> setOnboardingComplete(bool value) async =>
      await _prefs.setBool(Constants.APP.keyOnboardingComplete, value);

  bool get isOnboardingComplete =>
      _prefs.getBool(Constants.APP.keyOnboardingComplete) ?? false;

  // ─── GENERIC ──────────────────────────────────────────────

  Future<void> setString(String key, String value) async =>
      await _prefs.setString(key, value);

  String? getString(String key) => _prefs.getString(key);

  Future<void> setBool(String key, bool value) async =>
      await _prefs.setBool(key, value);

  bool? getBool(String key) => _prefs.getBool(key);

  Future<void> remove(String key) async => await _prefs.remove(key);

  Future<void> clearAll() async => await _prefs.clear();
}