import 'package:flutter/material.dart';
import 'package:sqflite_department/views/product_screen.dart';
import 'package:sqflite_department/views/sales_screen.dart';
import 'package:sqflite_department/views/user_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Screen"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const UserScreen(),
                ));
              },
              child: const Text("User Screen"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ProductScreen(),
                ));
              },
              child: const Text("Product Screen"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SalesScreen(),
                ));
              },
              child: const Text("Sales Screen"),
            ),
          ],
        ),
      ),
    );
  }
}
