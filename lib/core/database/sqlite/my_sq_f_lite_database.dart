import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite_department/core/database/sqlite/crud.dart';
import 'package:sqflite/sqflite.dart' as sqFLiteDatabase;
import 'package:path/path.dart';

class MySqFLiteDatabase extends CRUD {
  initDatabase() async {
    String databasesPath = await sqFLiteDatabase.getDatabasesPath();
    String realDatabasesPath = join(databasesPath, 'management.db');
    // open the database
    int versionDatabase = 1;
    Database database = await openDatabase(
      realDatabasesPath,
      version: versionDatabase,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(
            'CREATE TABLE user (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
      },
    );
  }

  @override
  int delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  int insert() {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  int select() {
    // TODO: implement select
    throw UnimplementedError();
  }

  @override
  int update() {
    // TODO: implement update
    throw UnimplementedError();
  }
}
