

import 'package:tvkapp/src/core/storage/data_base_helper.dart';
import 'package:tvkapp/src/data/datasource/remote/profile_data_source.dart';
import 'package:tvkapp/src/data/domain/user_entity.dart';
import 'package:tvkapp/src/data/model/profile_model.dart';
import 'package:tvkapp/src/data/repo/prefernces_repo.dart';

class ProfileRepository {
  final ProfileRemoteDataSource _remote;
  final DatabaseHelper _db;
  final PreferencesService _prefs;

  ProfileRepository(this._remote, this._db, this._prefs);

  Future<List<ProfileEntity>> getProfiles({
    int page = 1,
    String? query,
    String? gender,
    int? minAge,
    int? maxAge,
  }) async {
    try {
      final remoteProfiles = await _remote.fetchProfiles(
        page: page,
        results: 10,
        gender: gender,
      );

      await _db.cacheProfiles(remoteProfiles);

      final userId = _prefs.userId ?? '';
      final List<ProfileEntity> profiles = [];

      for (final profileMap in remoteProfiles) {
        final isFav = await _db.isFavorite(userId, profileMap['id'] as String);
        final profile = ProfileModel.fromMap({...profileMap, 'is_favorite': isFav ? 1 : 0});

        // Apply local filters
        if (_matchesFilters(profile, query: query, minAge: minAge, maxAge: maxAge)) {
          profiles.add(profile);
        }
      }

      return profiles;
    } catch (e) {
      // Fallback to cache
      return await getCachedProfiles(
        query: query,
        gender: gender,
        minAge: minAge,
        maxAge: maxAge,
      );
    }
  }

  Future<List<ProfileEntity>> getCachedProfiles({
    String? query,
    String? gender,
    int? minAge,
    int? maxAge,
  }) async {
    final cachedMaps = await _db.getCachedProfiles(
      query: query,
      gender: gender,
      minAge: minAge,
      maxAge: maxAge,
    );
    return cachedMaps.map((m) => ProfileModel.fromMap(m)).toList();
  }

  Future<ProfileEntity?> getProfileById(String id) async {
    // Try cache first
    final cached = await _db.getCachedProfileById(id);
    if (cached != null) {
      final userId = _prefs.userId ?? '';
      final isFav = await _db.isFavorite(userId, id);
      return ProfileModel.fromMap({...cached, 'is_favorite': isFav ? 1 : 0});
    }

    try {
      final remote = await _remote.fetchProfileById(id);
      await _db.cacheProfiles([remote]);
      return ProfileModel.fromMap(remote);
    } catch (e) {
      return null;
    }
  }

  Future<void> toggleFavorite(String profileId) async {
    final userId = _prefs.userId ?? '';
    final isFav = await _db.isFavorite(userId, profileId);

    if (isFav) {
      await _db.removeFavorite(userId, profileId);
    } else {
      await _db.addFavorite(userId, profileId);
    }
  }

  Future<bool> isFavorite(String profileId) async {
    final userId = _prefs.userId ?? '';
    return await _db.isFavorite(userId, profileId);
  }

  Future<List<ProfileEntity>> getFavoriteProfiles() async {
    final userId = _prefs.userId ?? '';
    final maps = await _db.getFavoriteProfiles(userId);
    return maps.map((m) => ProfileModel.fromMap({...m, 'is_favorite': 1})).toList();
  }

  bool _matchesFilters(
    ProfileEntity profile, {
    String? query,
    int? minAge,
    int? maxAge,
  }) {
    if (query != null && query.isNotEmpty) {
      final q = query.toLowerCase();
      final matches = profile.fullName.toLowerCase().contains(q) ||
          (profile.occupation?.toLowerCase().contains(q) ?? false) ||
          (profile.location?.toLowerCase().contains(q) ?? false);
      if (!matches) return false;
    }
    if (minAge != null && (profile.age ?? 0) < minAge) return false;
    if (maxAge != null && (profile.age ?? 99) > maxAge) return false;
    return true;
  }
}