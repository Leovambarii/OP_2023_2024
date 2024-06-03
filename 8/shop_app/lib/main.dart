import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/shop.dart';
import 'package:shop_app/models/category.dart' as shop_category;
import 'package:shop_app/pages/categories_page.dart';
import 'package:shop_app/pages/products_page.dart';
import 'package:shop_app/pages/shopping_cart_page.dart';
import 'package:shop_app/pages/welcome_page.dart';
import 'package:shop_app/themes/theme.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Shop(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: myTheme,
      home: const WelcomePage(),
      routes: {
        '/welcome' : (context) => const WelcomePage(),
        '/categories' : (context) => const CategoriesPage(),
        '/cart' : (context) => const ShoppingCartPage(),
        '/products': (context) => ProductsPage(category: ModalRoute.of(context)!.settings.arguments as shop_category.Category),
      },
    );
  }
}