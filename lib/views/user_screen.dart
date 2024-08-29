import 'package:flutter/material.dart';
import 'package:sqflite_department/core/database/sqlite/my_sq_f_lite_database.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: const Text("SQfLite"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _userNameController,
              decoration: const InputDecoration(
                label: Text("user name"),
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () async{
                MySqFLiteDatabase db=MySqFLiteDatabase();
                bool inserted=await db.insertToUserTable(userName: _userNameController.text);
                print(inserted);
                _userNameController.clear();

              },
              child: const Text("insert"),
            ),
          ],
        ),
      ),
    );
  }
}
