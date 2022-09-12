import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final dbname = "pricoDBLogs.db";
  static final dbversion = 1;

  static final columnIdS = "id";
  static final tableLogin = "myTables";
  static final columnLoginPin = "loginPin";
  static final columnphoneNo = "phoneNo";
  static final columndobyear = "dodYear";
  static final columnadminPass = "adminPass";

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initiateDatabase();
    return _database;
  }

  initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbname);
    return await openDatabase(path, version: dbversion, onCreate: onCreate);
  }

  Future onCreate(Database db, int dbversion) async {
    await db.execute('''
         CREATE TABLE $tableLogin ($columnIdS INTEGER PRIMARY KEY, $columnLoginPin TEXT NOT NULL, $columnphoneNo TEXT NOT NULL, $columndobyear TEXT NOT NULL,$columnadminPass TEXT NOT NULL)
      ''');
  }

  Future<int> insertAllPass(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(tableLogin, row);
  }

  Future<List<Map<String, dynamic>>> queryAllPass() async {
    Database? db = await instance.database;
    return await db!.query(tableLogin);
  }

  Future<int> updateAllPass(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[columnIdS];
    return await db!
        .update(tableLogin, row, where: '$columnIdS=?', whereArgs: [id]);
  }

  Future<int> deleteAllPass(int id) async {
    Database? db = await instance.database;
    return await db!.delete(tableLogin, where: '$columnIdS=?', whereArgs: [id]);
  }
}
