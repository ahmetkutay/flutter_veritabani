import 'package:flutter/material.dart';
import 'package:flutter_veritabani_demo/data/dbHelper.dart';
import 'package:flutter_veritabani_demo/models/product.dart';
import 'package:flutter_veritabani_demo/models/screens/product_add.dart';

class ProductList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }
}

class _ProductListState extends State {
  DbHelper dbHelper = new DbHelper();
  List<Product> products;
  int productCount = 0;

  @override
  void initState() {
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün Listesi"),
      ),
      body: buildProductList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goToProductAdd();
        },
        child: Icon(Icons.add),
        tooltip: "Yeni Ürün Ekle",
      ),
    );
  }

  ListView buildProductList() {
    return ListView.builder(
        itemCount: productCount,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.green,
            elevation: 1.2,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black,
                child: Text("Product"),
              ),
              title: Text(this.products[position].name),
              subtitle: Text(this.products[position].description),
              onTap: () {},
            ),
          );
        });
  }

  void goToProductAdd() async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProductAdd()));
    if (result != null) {
      if (result) {}
    }
  }

  void getProducts() async {
    var productsFuture = dbHelper.getProducts();
    productsFuture.then((data) {
      this.products = data;
      productCount=data.length;
    });
  }
}
