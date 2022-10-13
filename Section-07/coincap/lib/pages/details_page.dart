import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final Map<String, dynamic> _allPrices;

  const DetailsPage(this._allPrices, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView.builder(
        itemCount: _allPrices.keys.length,
        itemBuilder: (context, index) {
          String key = _allPrices.keys.elementAt(index);
          num price = _allPrices[key];
          return ListTile(
            title: Text(
              "${key.toUpperCase()}: $price",
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      )),
    );
  }
}
