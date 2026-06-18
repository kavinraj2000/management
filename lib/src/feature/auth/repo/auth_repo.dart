
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:profilediscovery/src/core/storage/data_base_helper.dart';
import 'package:profilediscovery/src/data/domain/user_entity.dart';
import 'package:profilediscovery/src/data/model/user_model.dart';
import 'package:profilediscovery/src/data/repo/prefernces_repo.dart';
import 'package:uuid/uuid.dart';


class AuthRepository {
  final DatabaseHelper _db;
  final PreferencesService _prefs;
  final _uuid = const Uuid();

  AuthRepository(this._db, this._prefs);

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<UserEntity> register({
    required String fullName,
    required String email,
    required String password,
    String? phone,
  }) async {
    final exists = await _db.emailExists(email);
    if (exists) {
      throw Exception('Email already registered. Please login instead.');
    }

    final now = DateTime.now();
    final user = UserModel(
      id: _uuid.v4(),
      fullName: fullName,
      email: email.toLowerCase().trim(),
      phone: phone,
      createdAt: now,
      updatedAt: now,
    );

    final userMap = user.toMap();
    userMap['password_hash'] = _hashPassword(password);

    await _db.insertUser(userMap);

    await _prefs.saveUserSession(
      userId: user.id,
      email: user.email,
      name: user.fullName,
    );

    return user;
  }

  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final userMap = await _db.getUserByEmail(email.toLowerCase().trim());

    if (userMap == null) {
      throw Exception('No account found with this email.');
    }

    final passwordHash = _hashPassword(password);
    if (userMap['password_hash'] != passwordHash) {
      throw Exception('Incorrect password. Please try again.');
    }

    final user = UserModel.fromMap(userMap);

    await _prefs.saveUserSession(
      userId: user.id,
      email: user.email,
      name: user.fullName,
    );

    return user;
  }

  Future<void> logout() async {
    await _prefs.clearSession();
  }

  Future<UserEntity?> getCurrentUser() async {
    final userId = _prefs.userId;
    if (userId == null) return null;

    final userMap = await _db.getUserById(userId);
    if (userMap == null) return null;

    return UserModel.fromMap(userMap);
  }

  Future<bool> forgotPassword(String email) async {
    final exists = await _db.emailExists(email.toLowerCase().trim());
    if (!exists) {
      throw Exception('No account found with this email address.');
    }
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  Future<UserEntity> updateProfile({
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    data['updated_at'] = DateTime.now().toIso8601String();
    await _db.updateUser(userId, data);

    final userMap = await _db.getUserById(userId);
    if (userMap == null) throw Exception('User not found');

    if (data['full_name'] != null) {
      await _prefs.setString('user_name', data['full_name']);
    }

    return UserModel.fromMap(userMap);
  }

  bool get isLoggedIn => _prefs.isLoggedIn;
  String? get currentUserId => _prefs.userId;
}