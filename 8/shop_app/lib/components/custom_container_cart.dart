import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/models/shop.dart';

class CustomContainerCart extends StatelessWidget {
  final Product product;

  const CustomContainerCart({
    super.key,
    required this.product
  });

  void removeFromCart(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: const Text(
          "Remove from cart?",
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
                  context.read<Shop>().removeFromCart(product);
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.green[300],
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0),
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Icon(
              product.icon,
              size: 44,
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  product.description,
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              Container(
                width: 30,
                height: 30,
                padding: EdgeInsets.zero,
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: IconButton(
                  icon: const Icon(Icons.remove),
                  iconSize: 18,
                  padding: EdgeInsets.zero,
                  onPressed: () => removeFromCart(context),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
