import 'package:flutter/material.dart';
import 'package:max2023_shop_app/providers/cart_provider.dart';
import 'package:max2023_shop_app/providers/product_provider.dart';
import 'package:max2023_shop_app/providers/products_provider.dart';
import 'package:max2023_shop_app/screens/cart_screen.dart';
import 'package:max2023_shop_app/screens/orders_screen.dart';
import 'package:max2023_shop_app/widgets/app_drawer.dart';
import 'package:max2023_shop_app/widgets/badge.dart';
import 'package:max2023_shop_app/widgets/products_grid.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatelessWidget {
  ProductsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyShop"),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              final showFav =
                  selectedValue == FilterOptions.Favorites ? true : false;
              Provider.of<ProductsProvider>(context, listen: false)
                  .showFavoritesOnly = showFav;
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<CartProvider>(
            child: IconButton(
              icon: Icon(Icons.shopping_basket),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CartScreen(),
                ));
              },
            ),
            builder: (context, cart, iconBtn) => Badge(
              value: cart.itemCount.toString(),
              child: iconBtn!,
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: SafeArea(
        child: ProductsGrid(),
      ),
    );
  }
}
