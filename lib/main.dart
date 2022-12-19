import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/cart.dart';
import 'package:flutter_complete_guide/screens/product_detail_screen.dart';
import 'package:flutter_complete_guide/screens/products_overview_screen.dart';
import './providers/products.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Products()),
        ChangeNotifierProvider.value(value: Cart())
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
            fontFamily: 'Lato',
            primarySwatch: Colors.purple,
            secondaryHeaderColor: Colors.deepOrange),
        routes: {
          ProductsOverviewScreen.routeName: (ctx) => ProductsOverviewScreen(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
        },
      ),
    );
  }
}
