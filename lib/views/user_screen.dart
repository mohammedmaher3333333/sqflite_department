import 'package:flutter/material.dart';
import 'package:sqflite_department/app/controller/user_controller.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _userNameController = TextEditingController();
  late UserController _userController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userController = UserController();
  }

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
              onPressed: () async {
                setState(() {
                  _userController.selectDataFromUserTable();
                  _userController.insertUser(
                      userName: _userNameController.text);
                });
                _userNameController.clear();
              },
              child: const Text("insert"),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => Row(
                  children: [
                    Text(_userController.dataUser[index]['user_id'].toString()),
                    Text(_userController.dataUser[index]['user_name']
                        .toString()),
                  ],
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 20,
                ),
                itemCount: _userController.dataUser.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
