import 'package:flutter/material.dart';
import 'product.dart';

class Category {
  final String name;
  final List<Product> products;
  final IconData icon;

  Category({
    required this.name,
    required this.products,
    required this.icon
  });
}