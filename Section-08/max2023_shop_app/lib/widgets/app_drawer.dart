import 'package:flutter/material.dart';
import 'package:max2023_shop_app/screens/orders_screen.dart';
import 'package:max2023_shop_app/screens/products_overview_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                CircleAvatar(
                  radius: 30,
                  child: Icon(
                    Icons.account_box,
                    size: 40,
                  ),
                ),
                Text(
                  'Hi there!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text(
              "Shop",
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductsOverviewScreen(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.credit_card),
            title: const Text(
              "Your Orders",
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const OrdersScreen(),
              ));
            },
          ),
        ],
      ),
    );
  }
}
