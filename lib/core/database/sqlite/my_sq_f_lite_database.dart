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

  Future<Database> _initDatabase() async {
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
      'CREATE TABLE IF NOT EXISTS $_userTable ($_userColumnID INTEGER PRIMARY KEY AUTOINCREMENT, $_userColumnName TEXT)',
    );
    await db.execute(
      'CREATE TABLE IF NOT EXISTS $_productTable ($_productColumnID INTEGER PRIMARY KEY AUTOINCREMENT, $_productColumnName TEXT, $_productColumnPrice REAL, $_productColumnCount INTEGER);',
    );
    await db.execute(
      'CREATE TABLE IF NOT EXISTS $_salesTable ($_salesColumnID INTEGER PRIMARY KEY AUTOINCREMENT, $_salesColumnProductName TEXT, $_salesColumnUserName TEXT);',
    );
  }

  @override
  Future<bool> delete() async {
    // TODO: implement delete
    await _initDatabase();
    int deleted = await _db!.delete(
      _userTable,
      where: "$_userColumnID==1",
    );
    _db!.close();
    return deleted > 0 ? true : false;
    throw UnimplementedError();
  }

  insertToProductTable({
    required String nameProduct,
    required double priceProduct,
    required int countProduct,
  }) {
    insert(
      tableName: _productTable,
      values: {
        _productColumnName: nameProduct,
        _productColumnPrice: priceProduct,
        _productColumnCount: countProduct,
      },
    );
  }

  Future<bool> insertToUserTable({required String userName}) {
    return insert(
      tableName: _userTable,
      values: {
        _userColumnName: userName,
      },
    );
  }

  @override
  Future<bool> insert(
      {required String tableName, required Map<String, Object?> values}) async {
    // TODO: implement insert
    await _initDatabase();
    int inserted = await _db!.insert(tableName, values);
    _db!.close();
    return inserted > 0 ? true : false;
    throw UnimplementedError();
  }

  @override
  Future<bool> select() async {
    // TODO: implement select
    throw UnimplementedError();
  }

  @override
  Future<bool> update() async {
    // TODO: implement update
    await _initDatabase();
    int updated = await _db!.update(
        _userTable,
        {
          _userColumnName: "Ahmed",
        },
        where: "$_userColumnID == 1");
    _db!.close();
    return updated > 0 ? true : false;
    throw UnimplementedError();
  }
}
