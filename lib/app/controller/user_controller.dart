import '../../core/database/sqlite/my_sq_f_lite_database.dart';

class UserController {
  List dataUser = [];

  UserController() {
    selectUser();
  }

  void insertUser({required String userName}) async {
    MySqFLiteDatabase db = MySqFLiteDatabase();
    await db.insertToUserTable(userName: userName);
    selectUser();
  }

  void selectUser() async {
    MySqFLiteDatabase db = MySqFLiteDatabase();
    dataUser = await db.selectFromUserTable();
  }

  void updateUser({required String userName, required int id}) async {
    MySqFLiteDatabase db = MySqFLiteDatabase();
    await db.updateUserTable(userName: userName, id: id);
    selectUser();
  }

  void deleteUser({required int id}) async {
    MySqFLiteDatabase db = MySqFLiteDatabase();
    await db.deleteFromUserTable(id: id);
    selectUser();
  }
}
