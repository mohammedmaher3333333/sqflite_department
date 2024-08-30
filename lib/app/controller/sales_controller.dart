import '../../core/database/sqlite/my_sq_f_lite_database.dart';

class SalesController {
  List dataUsers = [];
  int? valueButtonUsers;

  List dataProducts = [];
  int valueButtonProducts = 0;

  SalesController() {
    initialSelect();
  }

  void initialSelect() async {
    await selectUsers();
    valueButtonUsers = dataUsers[0]["user_id"];
    await selectProducts();
    valueButtonProducts = dataProducts[0]["product_id"];
  }

  Future<void> selectUsers() async {
    MySqFLiteDatabase db = MySqFLiteDatabase();
    dataUsers = await db.selectFromUserTable();
  }

  Future<void> selectProducts() async {
    MySqFLiteDatabase db = MySqFLiteDatabase();
    dataProducts = await db.selectFromProductTable();
  }

  Future<void> insertToSalesTable() async {
    String userName = "";
    String productName = "";
    if (valueButtonUsers != null) {
      for (int i = 0; i < dataUsers.length; i++) {
        if (dataUsers[i]['user_id'] == valueButtonUsers) {
          userName = dataUsers[i]['user_name'];
        }
      }
      // product data
      for (int i = 0; i < dataProducts.length; i++) {
        if (dataProducts[i]['product_id'] == valueButtonProducts) {
          productName = dataProducts[i]['product_name'];
        }
      }
    }
    MySqFLiteDatabase db = MySqFLiteDatabase();
    await db.insertToSalesTable(userName: userName, productName: productName);
  }
}
