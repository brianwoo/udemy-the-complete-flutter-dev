import 'package:flutter/material.dart';
import 'package:max2023_shop_app/providers/orders_provider.dart';
import 'package:max2023_shop_app/widgets/app_drawer.dart';
import 'package:max2023_shop_app/widgets/order_item.dart' as oiw;
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Your Orders")),
      drawer: AppDrawer(),
      body: SafeArea(
        child: ListView.builder(
          itemBuilder: (ctx, i) {
            return Card(
              margin: EdgeInsets.all(10),
              child: oiw.OrderItem(ordersProvider.orders[i]),
            );
          },
          itemCount: ordersProvider.orders.length,
        ),
      ),
    );
  }
}
