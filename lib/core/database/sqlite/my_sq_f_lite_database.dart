import 'package:sqflite/sqflite.dart';
import 'package:sqflite_department/core/database/sqlite/crud.dart';
import 'package:sqflite/sqflite.dart' as mySqfLiteDatabase;
import 'package:path/path.dart';

class MySqFLiteDatabase extends CRUD {
  final String _userTable = "user";
  final String _userColumnID = "user_id";
  final String _userColumnName = "user_name";
  final String _productTable = "product";
  final String _productColumnID = "product_id";
  final String _productColumnName = "product_name";
  final String _productColumnPrice = "product_price";
  final String _productColumnCount = "product_count";
  final String _salesTable = "sales";
  final String _salesColumnID = "sales_id";
  final String _salesColumnProductID = "sales_product_ID";
  final String _salesColumnUserID = "sales_user_ID";
  Database? _db;

  Future<Database> _initDatabase() async {
    String databasesPath = await mySqfLiteDatabase.getDatabasesPath();
    String realDatabasesPath = join(databasesPath, 'management.db');

    // // Check if the database already exists.
    // bool isExists = await mySqfLiteDatabase.databaseExists(realDatabasesPath);
    // // If the database exists, delete it.
    // if (isExists == true) {
    //   mySqfLiteDatabase.deleteDatabase(realDatabasesPath);
    // }

    // open the database
    int versionDatabase = 3;
    _db ??= await mySqfLiteDatabase.openDatabase(
      realDatabasesPath,
      version: versionDatabase,
      onCreate: _onCreate,
      onUpgrade: (db, oldVersion, newVersion) {
        print(db);
        print(oldVersion);
        print(newVersion);
      },
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
      'CREATE TABLE IF NOT EXISTS $_salesTable ($_salesColumnID INTEGER PRIMARY KEY AUTOINCREMENT, $_salesColumnProductID INTEGER, $_salesColumnUserID INTEGER);',
    );
  }

  //////////////////////////////////////   inserts
  // main function insert
  @override
  Future<bool> insert(
      {required String tableName, required Map<String, Object?> values}) async {
    await _initDatabase();
    int inserted = await _db!.insert(tableName, values);
    _db!.close();
    return inserted > 0 ? true : false;
  }

  // insert To Product Table
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

  //insert To User Table
  Future<bool> insertToUserTable({required String userName}) {
    return insert(
      tableName: _userTable,
      values: {
        _userColumnName: userName,
      },
    );
  }

  //insert To sales Table
  Future<bool> insertToSalesTable(
      {required int userID, required int productID}) {
    return insert(
      tableName: _salesTable,
      values: {
        _salesColumnUserID: userID,
        _salesColumnProductID: productID,
      },
    );
  }

  /////////////////////////////////////////////// selects

  // main function select
  @override
  Future<List<Map<String, Object?>>> select({
    required String tableName,
  }) async {
    await _initDatabase();
    List<Map<String, Object?>> selectedData = await _db!.query(tableName);
    _db!.close();
    return selectedData;
  }

  // select from user table
  Future<List<Map<String, Object?>>> selectFromSalesTable() async {
    await _initDatabase();
    List<Map<String, Object?>> selectedData = await _db!.rawQuery(
        "SELECT $_salesTable.$_salesColumnID,$_productTable.$_productColumnName,$_userTable.$_userColumnName FROM $_salesTable,$_userTable,$_productTable WHERE $_salesTable.$_salesColumnUserID = $_userTable.$_userColumnID AND $_salesTable.$_salesColumnProductID = $_productTable.$_productColumnID");
    _db!.close();
    return selectedData;
  }

  // select from user table
  Future<List<Map<String, Object?>>> selectFromUserTable() async {
    return select(tableName: _userTable);
  }

  // select from user table
  Future<List<Map<String, Object?>>> selectFromProductTable() async {
    return select(tableName: _productTable);
  }

  /////////////////////////////////////////////////  updates

  // main update
  @override
  Future<bool> update({
    required String tableName,
    required String where,
    required Map<String, Object?> values,
  }) async {
    await _initDatabase();
    int updated = await _db!.update(
      tableName,
      values,
      where: where,
    );
    _db!.close();
    return updated > 0 ? true : false;
  }

  // update User Table
  Future<bool> updateUserTable({required int id, required String userName}) {
    return update(
        tableName: _userTable,
        where: "$_userColumnID ==$id",
        values: {_userColumnName: userName});
  }

  // update product Table
  Future<bool> updateProductTable({
    required int id,
    required String productName,
    required double productPrice,
    required int productCount,
  }) {
    return update(
        tableName: _productTable,
        where: "$_productColumnID ==$id",
        values: {
          _productColumnName: productName,
          _productColumnPrice: productPrice,
          _productColumnCount: productCount,
        });
  }

  ///////////////////////////////////////////////////// deletes

  // main delete
  @override
  Future<bool> delete(
      {required String tableName, required String where}) async {
    await _initDatabase();
    int deleted = await _db!.delete(
      tableName,
      where: where,
    );
    _db!.close();
    return deleted > 0 ? true : false;
  }

  // delete from user table
  Future<bool> deleteFromUserTable({required int id}) async {
    return delete(tableName: _userTable, where: "$_userColumnID == $id");
  }

  // delete from product table
  Future<bool> deleteFromProductTable({required int id}) async {
    return delete(tableName: _productTable, where: "$_productColumnID == $id");
  }
}
