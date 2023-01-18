import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:max2023_shop_app/providers/products_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final String id;

  const ProductDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final product =
        Provider.of<ProductsProvider>(context, listen: false).findById(id);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
              Text('\$${product.price}', style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              Text('${product.description}', style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
      appBar: AppBar(title: Text(product.title)),
    );
  }
}
