import 'package:flutter/material.dart';
import 'package:shop_app/components/custom_container.dart';
import 'package:shop_app/components/custom_drawer.dart';
import 'package:shop_app/models/category.dart';

class ProductsPage extends StatelessWidget {
  final Category category;

  const ProductsPage({
    super.key,
    required this.category
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          '${category.name} Products',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      endDrawer: const CustomDrawer(),
      backgroundColor: Colors.green[100],
      body: ListView.builder(
        itemCount: category.products.length,
        itemBuilder: (context, index) {
          final product = category.products[index];

          return CustomContainer(product: product);
        }
      ),
    );
  }
}