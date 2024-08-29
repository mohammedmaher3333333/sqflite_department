import '../../core/database/sqlite/my_sq_f_lite_database.dart';

class ProductController {
  List dataProduct = [];

  ProductController() {
    selectProduct();
  }

  void insertProduct({required String productName,required double productPrice,required int productCount}) async {
    MySqFLiteDatabase db = MySqFLiteDatabase();
    await db.insertToProductTable(nameProduct: productName, priceProduct: productPrice, countProduct: productCount);
    selectProduct();
  }

  void selectProduct() async {
    MySqFLiteDatabase db = MySqFLiteDatabase();
    dataProduct = await db.selectFromProductTable();
  }

  void updateProduct({required String productName,required double productPrice,required int productCount, required int id}) async {
    MySqFLiteDatabase db = MySqFLiteDatabase();
    await db.updateProductTable(productName: productName, id: id, productPrice: productPrice, productCount: productCount);
    selectProduct();
  }

  void deleteProduct({required int id}) async {
    MySqFLiteDatabase db = MySqFLiteDatabase();
    await db.deleteFromProductTable(id: id);
    selectProduct();
  }
}
