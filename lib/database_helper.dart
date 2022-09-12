import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:prico/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final dbname = "pricoDBs.db";
  static final dbversion = 1;
  static final tablename = "myTable";
  static final columnId = "id";
  static final columnCode = "productCode";
  static final columnName = "productName";
  static final columnAmount = "productAmount";

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
         CREATE TABLE $tablename ($columnId INTEGER PRIMARY KEY,
         $columnCode INTEGER NOT NULL, $columnName TEXT NOT NULL, $columnAmount INTEGER NOT NULL)
      ''');

    await db.execute('''
         CREATE TABLE $tableLogin ($columnIdS INTEGER PRIMARY KEY, $columnLoginPin TEXT NOT NULL, $columnphoneNo TEXT NOT NULL, $columndobyear TEXT NOT NULL,$columnadminPass TEXT NOT NULL)
      ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(tablename, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database? db = await instance.database;
    return await db!.query(tablename);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[columnId];
    return await db!
        .update(tablename, row, where: '$columnId=?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database? db = await instance.database;
    return await db!.delete(tablename, where: '$columnId=?', whereArgs: [id]);
  }

  Future<int?> countPeople() async {
    Database? db = await instance.database;
    final count = Sqflite.firstIntValue(
        await db!.rawQuery('SELECT COUNT(*) FROM $tablename'));
    //print(count);
    return count;
  }

  Future<int?> getcount(id) async {
    Database? db = await instance.database;
    final count = Sqflite.firstIntValue(await db!
        .rawQuery("SELECT COUNT(*) FROM $tablename WHERE $columnId=$id"));
    return count;
  }
}
