import '../../core/database/sqlite/my_sq_f_lite_database.dart';

class SalesController {
  List dataUsers = [];
  int valueButtonUsers = 0;
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
}
