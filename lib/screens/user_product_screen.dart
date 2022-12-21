import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:flutter_complete_guide/widgets/app_drawer.dart';
import 'package:flutter_complete_guide/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user_products';
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: const Text("Your Products"),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            itemBuilder: (_, i) => Column(
              children: [
                UserProductItem(productsData.items[i].title,
                    productsData.items[i].imageUrl),
                Divider()
              ],
            ),
            itemCount: productsData.items.length,
          ),
        ));
  }
}
