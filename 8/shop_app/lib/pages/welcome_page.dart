import 'package:flutter/material.dart';
import 'package:shop_app/components/custom_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_bag_rounded,
              size: 64,
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome to our Shop App',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0
              ),
            ),
            const Text('We sell only the best products!'),
            const SizedBox(height: 30),
            CustomButton(
              onTap: () => Navigator.pushNamed(context, '/categories'),
              child: const Text(
                'Get started!',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            )
          ],
        ),
      ),
    );
  }
}