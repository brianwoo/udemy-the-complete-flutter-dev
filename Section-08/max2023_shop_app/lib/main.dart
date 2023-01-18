import 'package:flutter/material.dart';
import 'package:max2023_shop_app/providers/cart_provider.dart';
import 'package:max2023_shop_app/providers/orders_provider.dart';
import 'package:max2023_shop_app/providers/products_provider.dart';
import 'package:max2023_shop_app/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductsProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => OrdersProvider()),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: ProductsOverviewScreen(),
      ),
    );
  }
}
