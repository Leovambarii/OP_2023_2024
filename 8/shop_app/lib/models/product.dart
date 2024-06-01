import 'package:flutter/material.dart';

class Product extends ChangeNotifier {
  final IconData icon;
  final String name;
  final String description;
  final double price;

  Product({
    required this.icon,
    required this.name,
    required this.description,
    required this.price,
  });
}