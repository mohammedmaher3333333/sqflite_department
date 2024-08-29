import 'package:flutter/material.dart';
import 'package:sqflite_department/app/controller/user_controller.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userNameEditController = TextEditingController();
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
        title: const Text("sales Screen"),
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
                _userController.insertUser(userName: _userNameController.text);
                _userNameController.clear();
              },
              child: const Text("insert"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              child: const Text("refresh"),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    int id = _userController.dataUser[index]['user_id'];
                    _userNameEditController.text =
                    _userController.dataUser[index]['user_name'];
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _userNameEditController,
                              decoration: const InputDecoration(
                                label: Text("user name"),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    _userController.updateUser(
                                        userName: _userNameEditController.text, id: id);
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: const Text("update"),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    _userController.deleteUser(id: id);
                                    Navigator.pop(context);
                                  },
                                  child: const Text("delete"),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Text(_userController.dataUser[index]['user_id']
                          .toString()),
                      Text(_userController.dataUser[index]['user_name']
                          .toString()),
                    ],
                  ),
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
