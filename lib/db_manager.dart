import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 1;

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();
  Future<Database?> get database1 async {
    _database ??= await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE conference_info (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL, 
            email TEXT NOT NULL,
            phone INTEGER NOT NULL,
            role TEXT NOT NULL,
            area TEXT NOT NULL,
            institute TEXT NOT NULL,
            password TEXT NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE admin (
            id INTEGER PRIMARY KEY,
            username TEXT NOT NULL, 
            password TEXT NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE roles (
            id INTEGER PRIMARY KEY,
            roleName TEXT NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE areaSpec (
            id INTEGER PRIMARY KEY,
            areaName TEXT NOT NULL
          )
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insertUser(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db.insert('conference_info', row);
  }

  Future<int> insertRole(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db.insert('roles', row);
  }

  Future<int> insertArea(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db.insert('areaSpec', row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.

  Future<List<Map<String, dynamic>>> queryAllRowsofUser() async {
    Database db = await instance.database;
    return await db.query('conference_info');
  }

  Future<List<Map<String, dynamic>>> queryAllRowsofRole() async {
    Database db = await instance.database;
    return await db.query('roles');
  }

  Future<List<Map<String, dynamic>>> queryAllRowsofArea() async {
    Database db = await instance.database;
    return await db.query('areaSpec');
  }

  Future<List<Map<String, dynamic>>> queryOneUserDetails(int id) async {
    Database db = await instance.database;
    return db.query('conference_info',
        where: "id = ?", whereArgs: [id], limit: 1);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM conference_info')) ??
        0;
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row['id'];
    return await db
        .update('conference_info', row, where: 'id = ?', whereArgs: [id]);
  }

  // Update registered user details by id
  static Future<int> updateUserDetails(
      int id,
      String name,
      String email,
      int phone,
      String role,
      String area,
      String institute,
      String password) async {
    final db = await instance.database;

    final data = {
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'area': area,
      'institute': institute,
      'password': password
    };

    final result = await db
        .update('conference_info', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete('conference_info', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteRole(int id) async {
    Database db = await instance.database;
    return await db.delete('roles', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteArea(int id) async {
    Database db = await instance.database;
    return await db.delete('areaSpec', where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> checkLogin(String email, String password) async {
    Database db = await instance.database;
    var result = await db.rawQuery(
        "select * from conference_info where email ='$email' and password ='$password'");
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<int> getLoggedInUserID(String email, String password) async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery(
            "select id from conference_info where email ='$email' and password ='$password'")) ??
        0;
  }
}
