import '../../core/database/sqlite/my_sq_f_lite_database.dart';

class SalesController {
  List dataUsers = [];
  int valueButtonUsers = 0;
  List dataProducts = [];
  int valueButtonProducts = 0;

  SalesController() {
    selectUsers();
    selectProducts();
  }

  Future<void> selectUsers() async {
    MySqFLiteDatabase db = MySqFLiteDatabase();
    dataUsers = await db.selectFromUserTable();
    valueButtonUsers = dataUsers[0]["user_id"];
  }

  Future<void> selectProducts() async {
    MySqFLiteDatabase db = MySqFLiteDatabase();
    dataProducts = await db.selectFromProductTable();
    valueButtonProducts = dataProducts[0]["product_id"];
  }
}
