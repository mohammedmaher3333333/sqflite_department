import 'package:flutter/material.dart';
import 'package:sqflite_department/app/controller/product_controller.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productCountController = TextEditingController();

  // editing
  final TextEditingController _productEditNameController =
      TextEditingController();
  final TextEditingController _productEditPriceController =
      TextEditingController();
  final TextEditingController _productEditCountController =
      TextEditingController();
  late ProductController _productController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productController = ProductController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _productPriceController.dispose();
    _productNameController.dispose();
    _productCountController.dispose();
    _productEditCountController.dispose();
    _productEditPriceController.dispose();
    _productEditNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: const Text("product Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _productNameController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                label: Text("product name"),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _productPriceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                label: Text("product price"),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _productCountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                label: Text("product count"),
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                _productController.insertProduct(
                  productName: _productNameController.text,
                  productPrice: double.parse(_productPriceController.text),
                  productCount: int.parse(_productCountController.text),
                );
                _productNameController.clear();
                _productPriceController.clear();
                _productCountController.clear();
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
                    int id =
                        _productController.dataProduct[index]['product_id'];
                    _productEditNameController.text =
                        _productController.dataProduct[index]['product_name'];
                    _productEditPriceController.text = _productController
                        .dataProduct[index]['product_price']
                        .toString();
                    _productEditCountController.text = _productController
                        .dataProduct[index]['product_count']
                        .toString();
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _productEditNameController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                label: Text("product name"),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: _productEditPriceController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                label: Text("product price"),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: _productEditCountController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                label: Text("product count"),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    _productController.updateProduct(
                                      productName:
                                          _productEditNameController.text,
                                      id: id,
                                      productPrice: double.parse(
                                          _productEditPriceController.text),
                                      productCount: int.parse(
                                          _productEditCountController.text),
                                    );
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: const Text("update"),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    _productController.deleteProduct(id: id);
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
                      Text(
                          "id.${_productController.dataProduct[index]['product_id']}  "),
                      Text(_productController.dataProduct[index]['product_name']
                          .toString()),
                      Text(
                          "   ${_productController.dataProduct[index]['product_price']}   "),
                      Text(_productController.dataProduct[index]
                              ['product_count']
                          .toString()),
                    ],
                  ),
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 20,
                ),
                itemCount: _productController.dataProduct.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
