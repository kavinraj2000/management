// lib/data/datasources/local/database_helper.dart

<<<<<<< HEAD
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tvkapp/src/core/constants/constants.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper.internal();
=======
import 'package:profilediscovery/src/core/constants/constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, Constants.APP.dbName);

    return await openDatabase(
      path,
      version: Constants.APP.dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${Constants.APP.tableUsers} (
        id TEXT PRIMARY KEY,
        full_name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password_hash TEXT NOT NULL,
        phone TEXT,
        occupation TEXT,
        location TEXT,
        about_me TEXT,
        age INTEGER,
        profile_picture TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE ${Constants.APP.tableProfiles} (
        id TEXT PRIMARY KEY,
        full_name TEXT NOT NULL,
        email TEXT,
        phone TEXT,
        occupation TEXT,
        location TEXT,
        about_me TEXT,
        age INTEGER,
        profile_picture TEXT,
        gender TEXT,
        is_favorite INTEGER DEFAULT 0,
        cached_at TEXT NOT NULL
      )
    ''');

<<<<<<< HEAD
=======
    // Favorites table
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
    await db.execute('''
      CREATE TABLE ${Constants.APP.tableFavorites} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id TEXT NOT NULL,
        profile_id TEXT NOT NULL,
        favorited_at TEXT NOT NULL,
        UNIQUE(user_id, profile_id)
      )
    ''');

    await _createIndexes(db);
  }

  Future<void> _createIndexes(Database db) async {
    await db.execute(
<<<<<<< HEAD
      'CREATE INDEX idx_users_email ON ${Constants.APP.tableUsers}(email)',
    );
    await db.execute(
      'CREATE INDEX idx_favorites_user ON ${Constants.APP.tableFavorites}(user_id)',
    );
    await db.execute(
      'CREATE INDEX idx_profiles_favorite ON ${Constants.APP.tableProfiles}(is_favorite)',
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {}
=======
        'CREATE INDEX idx_users_email ON ${Constants.APP.tableUsers}(email)');
    await db.execute(
        'CREATE INDEX idx_favorites_user ON ${Constants.APP.tableFavorites}(user_id)');
    await db.execute(
        'CREATE INDEX idx_profiles_favorite ON ${Constants.APP.tableProfiles}(is_favorite)');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle future migrations here
  }

  // ─── USERS ───────────────────────────────────────────────
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde

  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    return await db.insert(
      Constants.APP.tableUsers,
      user,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await database;
    final results = await db.query(
      Constants.APP.tableUsers,
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }

  Future<Map<String, dynamic>?> getUserById(String id) async {
    final db = await database;
    final results = await db.query(
      Constants.APP.tableUsers,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }

  Future<int> updateUser(String id, Map<String, dynamic> data) async {
    final db = await database;
    return await db.update(
      Constants.APP.tableUsers,
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<bool> emailExists(String email) async {
    final db = await database;
    final result = await db.query(
      Constants.APP.tableUsers,
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );
    return result.isNotEmpty;
  }

<<<<<<< HEAD
=======
  // ─── PROFILES ────────────────────────────────────────────
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde

  Future<void> cacheProfiles(List<Map<String, dynamic>> profiles) async {
    final db = await database;
    final batch = db.batch();
    for (final profile in profiles) {
      batch.insert(
        Constants.APP.tableProfiles,
        profile,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<Map<String, dynamic>>> getCachedProfiles({
    String? query,
    String? gender,
    int? minAge,
    int? maxAge,
  }) async {
    final db = await database;
    String where = '';
    List<dynamic> whereArgs = [];

    if (query != null && query.isNotEmpty) {
      where += '(full_name LIKE ? OR occupation LIKE ? OR location LIKE ?)';
      whereArgs.addAll(['%$query%', '%$query%', '%$query%']);
    }
    if (gender != null && gender != 'All') {
      if (where.isNotEmpty) where += ' AND ';
      where += 'gender = ?';
      whereArgs.add(gender.toLowerCase());
    }
    if (minAge != null) {
      if (where.isNotEmpty) where += ' AND ';
      where += 'age >= ?';
      whereArgs.add(minAge);
    }
    if (maxAge != null) {
      if (where.isNotEmpty) where += ' AND ';
      where += 'age <= ?';
      whereArgs.add(maxAge);
    }

    return await db.query(
      Constants.APP.tableProfiles,
      where: where.isNotEmpty ? where : null,
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
      orderBy: 'full_name ASC',
    );
  }

  Future<Map<String, dynamic>?> getCachedProfileById(String id) async {
    final db = await database;
    final results = await db.query(
      Constants.APP.tableProfiles,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }

<<<<<<< HEAD

  Future<void> addFavorite(String userId, String profileId) async {
    final db = await database;
    await db.insert(Constants.APP.tableFavorites, {
      'user_id': userId,
      'profile_id': profileId,
      'favorited_at': DateTime.now().toIso8601String(),
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
=======
  // ─── FAVORITES ───────────────────────────────────────────

  Future<void> addFavorite(String userId, String profileId) async {
    final db = await database;
    await db.insert(
      Constants.APP.tableFavorites,
      {
        'user_id': userId,
        'profile_id': profileId,
        'favorited_at': DateTime.now().toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    // Also update the profile's is_favorite field
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
    await db.update(
      Constants.APP.tableProfiles,
      {'is_favorite': 1},
      where: 'id = ?',
      whereArgs: [profileId],
    );
  }

  Future<void> removeFavorite(String userId, String profileId) async {
    final db = await database;
    await db.delete(
      Constants.APP.tableFavorites,
      where: 'user_id = ? AND profile_id = ?',
      whereArgs: [userId, profileId],
    );
    await db.update(
      Constants.APP.tableProfiles,
      {'is_favorite': 0},
      where: 'id = ?',
      whereArgs: [profileId],
    );
  }

  Future<bool> isFavorite(String userId, String profileId) async {
    final db = await database;
    final result = await db.query(
      Constants.APP.tableFavorites,
      where: 'user_id = ? AND profile_id = ?',
      whereArgs: [userId, profileId],
      limit: 1,
    );
    return result.isNotEmpty;
  }

  Future<List<Map<String, dynamic>>> getFavoriteProfiles(String userId) async {
    final db = await database;
<<<<<<< HEAD
    return await db.rawQuery(
      '''
=======
    return await db.rawQuery('''
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
      SELECT p.* FROM ${Constants.APP.tableProfiles} p
      INNER JOIN ${Constants.APP.tableFavorites} f 
        ON p.id = f.profile_id
      WHERE f.user_id = ?
      ORDER BY f.favorited_at DESC
<<<<<<< HEAD
    ''',
      [userId],
    );
=======
    ''', [userId]);
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
  }

  Future<void> clearCache() async {
    final db = await database;
    await db.delete(Constants.APP.tableProfiles);
  }

  Future<void> closeDatabase() async {
    final db = await database;
    await db.close();
    _database = null;
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
