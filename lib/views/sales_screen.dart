import 'package:flutter/material.dart';
import 'package:sqflite_department/app/controller/sales_controller.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  late SalesController _salesController;

  @override
  void initState() {
    // TODO: implement initState
    _salesController = SalesController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("sales Screen"),
      ),
      body: FutureBuilder(
        future: _salesController.selectUsers(),
        builder: (context, snapshot) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Text("Users"),
                  const SizedBox(
                    width: 100,
                  ),
                  DropdownButton(
                    value: _salesController.valueButtonUsers,
                    items: [
                      for (int i = 0;
                          i < _salesController.dataUsers.length;
                          i++)
                        DropdownMenuItem(
                          value: _salesController.dataUsers[i]["user_id"],
                          child:
                              Text(_salesController.dataUsers[i]['user_name']),
                        ),
                    ],
                    onChanged: (value) {
                      _salesController.valueButtonUsers =
                          int.parse(value.toString());
                      setState(() {});
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  const Text("Products"),
                  const SizedBox(
                    width: 100,
                  ),
                  DropdownButton(
                    value: _salesController.valueButtonProducts,
                    items: [
                      for (int i = 0;
                          i < _salesController.dataProducts.length;
                          i++)
                        DropdownMenuItem(
                          value: _salesController.dataProducts[i]["product_id"],
                          child: Text(
                            '${_salesController.dataProducts[i]['product_name']} / ${_salesController.dataProducts[i]['product_price']}',
                          ),
                        ),
                    ],
                    onChanged: (value) {
                      _salesController.valueButtonProducts =
                          int.parse(value.toString());
                      setState(() {});
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {});
                    },
                    child: const Text("Refresh"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _salesController.insertToSalesTable();
                      _salesController.selectSales();
                      setState(() {});
                    },
                    child: const Text("Add"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _salesController.selectSales();
                    },
                    child: const Text("get data"),
                  ),
                ],
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) => InkWell(
                    // onTap: () {
                    //   int id = _userController.dataUser[index]['user_id'];
                    //   _userNameEditController.text =
                    //   _userController.dataUser[index]['user_name'];
                    //   showModalBottomSheet(
                    //     context: context,
                    //     builder: (context) => Container(
                    //       padding: const EdgeInsets.all(16),
                    //       child: Column(
                    //         children: [
                    //           TextFormField(
                    //             controller: _userNameEditController,
                    //             decoration: const InputDecoration(
                    //               label: Text("user name"),
                    //               border: OutlineInputBorder(),
                    //             ),
                    //           ),
                    //           Row(
                    //             children: [
                    //               ElevatedButton(
                    //                 onPressed: () async {
                    //                   _userController.updateUser(
                    //                       userName: _userNameEditController.text, id: id);
                    //                   setState(() {});
                    //                   Navigator.pop(context);
                    //                 },
                    //                 child: const Text("update"),
                    //               ),
                    //               ElevatedButton(
                    //                 onPressed: () async {
                    //                   _userController.deleteUser(id: id);
                    //                   Navigator.pop(context);
                    //                 },
                    //                 child: const Text("delete"),
                    //               ),
                    //             ],
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   );
                    // },
                    child: Row(
                      children: [
                        Text(_salesController.dataSales[index]['sales_id']
                            .toString()),
                        Text(_salesController.dataSales[index]
                                ['user_name']
                            .toString()),
                        Text(_salesController.dataSales[index]
                                ['product_name']
                            .toString()),
                      ],
                    ),
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 20,
                  ),
                  itemCount: _salesController.dataSales.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
