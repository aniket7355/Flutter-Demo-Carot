import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'profile.db');
    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE Profile(id INTEGER PRIMARY KEY, name TEXT, email TEXT, phone TEXT, address TEXT, city TEXT, state TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertOrUpdateProfile(Map<String, dynamic> profileData) async {
    final db = await database;
    await db.insert(
      'Profile',
      profileData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getProfile() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query('Profile', limit: 1);

    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }
}
