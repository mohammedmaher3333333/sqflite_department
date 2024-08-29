import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite_department/core/database/sqlite/crud.dart';
import 'package:sqflite/sqflite.dart' as sqFLiteDatabase;
import 'package:path/path.dart';

class MySqFLiteDatabase extends CRUD {
  String _userTable = "user";
  String _userColumnID = "user_id";
  String _userColumnName = "user_name";
  String _productTable = "product";
  String _productColumnID = "product_id";
  String _productColumnName = "product_name";
  String _productColumnPrice = "product_price";
  String _productColumnCount = "product_count";
  String _salesTable = "sales";
  String _salesColumnID = "sales_id";
  String _salesColumnProductName = "sales_product_name";
  String _salesColumnUserName = "sales_user_name";
  Database? _db;

  Future<Database> initDatabase() async {
    String databasesPath = await sqFLiteDatabase.getDatabasesPath();
    String realDatabasesPath = join(databasesPath, 'management.db');
    // open the database
    int versionDatabase = 1;
    _db ??= await openDatabase(
      realDatabasesPath,
      version: versionDatabase,
      onCreate: _onCreate,
    );
    return _db!;
  }

  _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
      'CREATE TABLE IF NOT EXISTS $_userTable ('
      '$_userColumnID INTEGER PRIMARY KEY AUTOINCREMENT,'
      ' $_userColumnName TEXT,'
      ');',
    );
    await db.execute(
      'CREATE TABLE IF NOT EXISTS $_productTable ('
      '$_productColumnID INTEGER PRIMARY KEY AUTOINCREMENT,'
      '$_productColumnName TEXT,'
      ' $_productColumnPrice REAL,'
      ' $_productColumnCount INTEGER,'
      ');',
    );
    await db.execute(
      'CREATE TABLE IF NOT EXISTS $_salesTable ('
      '$_salesColumnID INTEGER PRIMARY KEY AUTOINCREMENT,'
      ' $_salesColumnProductName TEXT,'
      ' $_salesColumnUserName TEXT,'
      ');',
    );
  }

  @override
  Future<int> delete() async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<int> insert() async {
    // TODO: implement insert
    await initDatabase();
    int inserted = await _db!.insert(
      _userTable,
      {
        _userColumnName: "Mohammed",
      },
    );
    return inserted;
    throw UnimplementedError();
  }

  @override
  Future<int> select() async {
    // TODO: implement select
    throw UnimplementedError();
  }

  @override
  Future<int> update() async {
    // TODO: implement update
    throw UnimplementedError();
  }
}
