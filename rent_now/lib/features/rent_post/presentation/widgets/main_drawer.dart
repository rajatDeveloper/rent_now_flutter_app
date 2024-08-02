import 'package:flutter/material.dart';
import 'package:rent_now/features/address/presentation/pages/address_page.dart';
import 'package:rent_now/features/rent_post/presentation/pages/my_rent_post_page.dart';

class DrawerMain extends StatefulWidget {
  const DrawerMain({super.key});

  @override
  State<DrawerMain> createState() => _DrawerMainState();
}

class _DrawerMainState extends State<DrawerMain> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('My Address'),
            onTap: () {
              Navigator.pushNamed(context, AddressPage.routeName);
            },
          ),
          ListTile(
            title: const Text('My Rent Post'),
            onTap: () {
              Navigator.pushNamed(context, MyRentPostPage.routeName);
            },
          ),
          ListTile(
            title: const Text('My Orders'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
