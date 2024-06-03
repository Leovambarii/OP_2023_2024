import 'package:flutter/material.dart';
import 'package:shop_app/components/custom_tile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green[400],
            ),
            child: const Column(
              children: [
                Icon(
                  Icons.shopping_bag_rounded,
                  size: 64,
                ),
                Center(
                  child: Text(
                    'Best Shop App!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ),
          CustomTile(
            icon: Icons.home_rounded,
            title: 'Welcome Page',
            onTap: () => {
              Navigator.pop(context),
              Navigator.pushNamed(context, '/welcome')
            }
          ),
          const Divider(height: 0, thickness: 1),
          CustomTile(
            icon: Icons.category_rounded,
            title: 'Categories',
            onTap: () => {
              Navigator.pop(context),
              Navigator.pushNamed(context, '/categories')
            }
          ),
          const Divider(height: 0, thickness: 1),
          CustomTile(
            icon: Icons.shopping_cart_rounded,
            title: 'Shopping Cart',
            onTap: () => {
              Navigator.pop(context),
              Navigator.pushNamed(context, '/cart')
            }
          ),
          const Divider(height: 0, thickness: 1),
        ],
      ),
    );
  }
}