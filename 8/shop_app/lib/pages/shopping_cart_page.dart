import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/custom_button.dart';
import 'package:shop_app/components/custom_container_cart.dart';
import 'package:shop_app/components/custom_drawer.dart';
import 'package:shop_app/models/shop.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({super.key});

  void buyItems(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: const Text(
          "Buy products?",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  context.read<Shop>().clearCart();
                },
                child: const Text("Yes"),
              ),
              const SizedBox(width: 20.0),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text("No"),
              ),
            ],
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Shop>().cartItems;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'Shopping Cart',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      endDrawer: const CustomDrawer(),
      backgroundColor: Colors.green[100],
      body:  cart.isEmpty ? const Center(
        child: Text(
          'No products in cart ...',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20
            ),
          ),
        ) : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final product = cart[index];

                return CustomContainerCart(product: product);
              }
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 25),
            child: CustomButton(
              onTap: () => buyItems(context),
              child: const Text(
                'Buy Products',
                style: TextStyle(
                  fontWeight: FontWeight.bold),
                ),
            ),
          )
        ],
      )

    );
  }
}