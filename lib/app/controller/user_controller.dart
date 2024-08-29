import '../../core/database/sqlite/my_sq_f_lite_database.dart';

class UserController{
  List dataUser=[];
  UserController(){
    selectDataFromUserTable();
  }
  void insertUser({required String userName}) async {
    MySqFLiteDatabase db = MySqFLiteDatabase();
    bool inserted = await db.insertToUserTable(
        userName: userName);
    selectDataFromUserTable();
  }

  void selectDataFromUserTable() async {
    MySqFLiteDatabase db = MySqFLiteDatabase();
    dataUser = await db.select();

  }
}