import 'package:flutter/material.dart';
import 'package:max2023_shop_app/providers/cart_provider.dart';
import 'package:max2023_shop_app/providers/product_provider.dart';
import 'package:max2023_shop_app/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProductProvider product = Provider.of<ProductProvider>(context);
    CartProvider cart = Provider.of<CartProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(id: product.id),
          ),
        );
      },
      child: GridTile(
        child: Image.network(
          product.imageUrl,
          fit: BoxFit.cover,
        ),
        footer: GridTileBar(
          leading: IconButton(
            icon: product.isFavorite
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_outline),
            onPressed: () {
              product.toggleFavoriteStatus();
            },
          ),
          backgroundColor: Colors.black54,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
            },
          ),
        ),
      ),
    );
  }
}
