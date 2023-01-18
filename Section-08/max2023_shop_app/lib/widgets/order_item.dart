import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:max2023_shop_app/providers/orders_provider.dart' as op;

class OrderItem extends StatefulWidget {
  final op.OrderItem order;

  const OrderItem(this.order, {super.key});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('\$${widget.order.amount}'),
          subtitle: Text(
            DateFormat('dd MM yyyy hh:mm').format(widget.order.dateTime),
          ),
          trailing: IconButton(
            icon: _expanded
                ? const Icon(Icons.expand_more)
                : const Icon(Icons.expand_less),
            onPressed: () {
              setState(() {
                print("_expanded: $_expanded");
                _expanded = !_expanded;
              });
            },
          ),
        ),
        Visibility(
          visible: _expanded,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (ctx, i) {
              final products = widget.order.products;
              return ListTile(
                title: Text(
                  products[i].title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle:
                    Text('\$${products[i].price} x ${products[i].quantity}'),
              );
            },
            itemCount: widget.order.products.length,
          ),
        ),
      ],
    );
  }
}
