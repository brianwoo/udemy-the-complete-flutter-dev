import 'package:flutter/material.dart';
import 'package:max2023_shop_app/providers/cart_provider.dart';
import 'package:max2023_shop_app/providers/orders_provider.dart';
import 'package:max2023_shop_app/widgets/cart_item.dart' as ci;
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final orders = Provider.of<OrdersProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Spacer(),
                    Chip(
                      label: Text(
                        '\$${cart.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .bodyText1!
                                .color),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    TextButton(
                      onPressed: () {
                        orders.addOrder(
                            cart.items.values.toList(), cart.totalAmount);
                        cart.clearCart();
                      },
                      child: Text("ORDER NOW"),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
                child: ListView.builder(
              itemBuilder: (ctx, i) => ci.CartItem(
                id: cart.items.values.toList()[i].id,
                productId: cart.items.keys.toList()[i],
                title: cart.items.values.toList()[i].title,
                quantity: cart.items.values.toList()[i].quantity,
                price: cart.items.values.toList()[i].price,
              ),
              itemCount: cart.itemCount,
            )),
          ],
        ),
      ),
    );
  }
}
