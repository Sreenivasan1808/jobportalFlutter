import 'dart:async';
import 'package:jobportal/job.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'job_portal.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE jobs(id INTEGER PRIMARY KEY AUTOINCREMENT, role TEXT, company TEXT, salary REAL, description TEXT, location TEXT); CREATE TABLE users(id INTEGER PRIMARY KEY, username TEXT, password TEXT, role TEXT);',
        );
      },
    );
  }

  Future<void> insertJob(Job job) async {
    final db = await database;
    await db.insert(
      'jobs',
      job.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Job>> getJobs() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('jobs');
    return List.generate(maps.length, (i) {
      return Job(
        id: maps[i]['id'],
        role: maps[i]['role'],
        company: maps[i]['company'],
        salary: maps[i]['salary'],
        description: maps[i]['description'],
        location: maps[i]['location'],
      );
    });
  }

  Future<void> deleteJob(int id) async {
    final db = await database;
    await db.delete(
      'jobs',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> insertUser (String username, String password, String role) async {

    final db = await database;

    await db.insert(

      'users',

      {'username': username, 'password': password, 'role': role},

      conflictAlgorithm: ConflictAlgorithm.replace,

    );

  }


  Future<List<Map<String, dynamic>>> getUser (String username, String password) async {

    final db = await database;

    return await db.query(

      'users',

      where: 'username = ? AND password = ?',

      whereArgs: [username, password],

    );

  }
}