import '../../core/database/sqlite/my_sq_f_lite_database.dart';

class SalesController {
  List dataUsers = [];
  int? valueButtonUsers;

  List dataProducts = [];
  int? valueButtonProducts;

  List dataSales = [];

  SalesController() {
    initialSelect();
  }

  void initialSelect() async {
    await selectUsers();
    if (dataUsers.isNotEmpty) valueButtonUsers = dataUsers[0]["user_id"];
    await selectProducts();
    if (dataProducts.isNotEmpty) {
      valueButtonProducts = dataProducts[0]["product_id"];
    }
  }

  Future<void> selectUsers() async {
    MySqFLiteDatabase db = MySqFLiteDatabase();
    dataUsers = await db.selectFromUserTable();
  }

  Future<void> selectProducts() async {
    MySqFLiteDatabase db = MySqFLiteDatabase();
    dataProducts = await db.selectFromProductTable();
  }

  Future<void> selectSales() async {
    MySqFLiteDatabase db = MySqFLiteDatabase();
    // dataSales = await db.selectFromSalesTable();
    dataSales = await db.selectFromSalesTable();
    print(dataSales);
  }

  Future<void> insertToSalesTable() async {
    if (valueButtonUsers != null && valueButtonProducts != null) {
      MySqFLiteDatabase db = MySqFLiteDatabase();
      await db.insertToSalesTable(
        userID: valueButtonUsers!,
        productID: valueButtonProducts!,
      );
    }
  }
}
