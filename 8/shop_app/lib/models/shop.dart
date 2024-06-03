import 'package:flutter/material.dart';
import 'package:shop_app/models/category.dart';
import 'package:shop_app/models/product.dart';

class Shop extends ChangeNotifier{
  final List<Category> categories = [
    Category(
      name: 'Electronics',
      products: [
        Product(icon: Icons.tv_rounded, name: 'TV', description: 'A 50-inch smart TV', price: 499.99),
        Product(icon: Icons.laptop_rounded, name: 'Laptop', description: 'A powerful laptop', price: 999.99),
        Product(icon: Icons.phone_android_rounded, name: 'Phone', description: 'A smartphone with a great camera', price: 799.99),
        Product(icon: Icons.headphones_rounded, name: 'Headphones', description: 'Wireless headphones', price: 199.99),
        Product(icon: Icons.watch_rounded, name: 'Smartwatch', description: 'With fitness tracking', price: 299.99),
        Product(icon: Icons.tablet_android_rounded, name: 'Tablet', description: 'A 10-inch tablet', price: 399.99),
      ],
      icon: Icons.electrical_services_rounded,
    ),
    Category(
      name: 'Clothing',
      products: [
        Product(icon: Icons.checkroom_rounded, name: 'Shirt', description: 'A stylish shirt', price: 29.99),
        Product(icon: Icons.checkroom_rounded, name: 'Pants', description: 'Comfortable pants', price: 49.99),
        Product(icon: Icons.checkroom_rounded, name: 'Jacket', description: 'A warm jacket', price: 99.99),
        Product(icon: Icons.checkroom_rounded, name: 'Dress', description: 'An elegant dress', price: 79.99),
        Product(icon: Icons.checkroom_rounded, name: 'Sweater', description: 'A cozy sweater', price: 59.99),
        Product(icon: Icons.checkroom_rounded, name: 'Shoes', description: 'A pair of running shoes', price: 89.99),
      ],
      icon: Icons.checkroom_rounded,
    ),
    Category(
      name: 'Home',
      products: [
        Product(icon: Icons.cleaning_services_rounded, name: 'Vacuum Cleaner', description: 'A powerful vacuum cleaner', price: 149.99),
        Product(icon: Icons.kitchen_rounded, name: 'Refrigerator', description: 'A large double-door refrigerator', price: 899.99),
        Product(icon: Icons.microwave_rounded, name: 'Microwave', description: 'A microwave with grill function', price: 99.99),
        Product(icon: Icons.local_laundry_service_rounded, name: 'Washing Machine', description: 'A simple washing machine', price: 499.99),
        Product(icon: Icons.local_drink_rounded, name: 'Blender', description: 'A powerful blender', price: 79.99),
      ],
      icon: Icons.house_rounded,
    ),
    Category(
      name: 'Books',
      products: [
        Product(icon: Icons.book_rounded, name: 'Novel', description: 'A best-selling novel', price: 14.99),
        Product(icon: Icons.book_rounded, name: 'Science Fiction', description: 'An exciting science fiction book', price: 19.99),
        Product(icon: Icons.book_rounded, name: 'Mystery', description: 'A mystery novel', price: 12.99),
        Product(icon: Icons.book_rounded, name: 'Biography', description: 'A well-known biography', price: 24.99),
        Product(icon: Icons.book_rounded, name: 'Cookbook', description: 'Includes viral recipes', price: 29.99),
      ],
      icon: Icons.book_rounded,
    ),
    Category(
      name: 'Toys',
      products: [
        Product(icon: Icons.toys_rounded, name: 'Action Figure', description: 'A superhero action figure', price: 14.99),
        Product(icon: Icons.toys_rounded, name: 'Lego Set', description: 'A building block set', price: 29.99),
        Product(icon: Icons.toys_rounded, name: 'Doll', description: 'A beautiful doll', price: 19.99),
        Product(icon: Icons.toys_rounded, name: 'Puzzle', description: 'A 1000-piece puzzle', price: 9.99),
        Product(icon: Icons.toys_rounded, name: 'Board Game', description: 'A fun board game for family', price: 24.99),
        Product(icon: Icons.toys_rounded, name: 'Remote Control Car', description: 'A fast remote control car', price: 34.99),
      ],
      icon: Icons.toys_rounded,
    ),
    Category(
      name: 'Furniture',
      products: [
        Product(icon: Icons.chair_rounded, name: 'Sofa', description: 'A comfortable three-seater sofa', price: 499.99),
        Product(icon: Icons.table_restaurant_rounded, name: 'Dining Table', description: 'A large dining table', price: 299.99),
        Product(icon: Icons.chair_alt_rounded, name: 'Chair', description: 'A wooden dining chair', price: 49.99),
        Product(icon: Icons.bed_rounded, name: 'Bed', description: 'A king size bed', price: 399.99),
        Product(icon: Icons.checkroom_rounded, name: 'Wardrobe', description: 'A spacious wardrobe', price: 199.99),
        Product(icon: Icons.desk_rounded, name: 'Desk', description: 'An office desk', price: 149.99),
      ],
      icon: Icons.chair_rounded,
    ),
  ];


  List<Product> cartItems = [];

  void addToCart(Product product) {
    cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    for (int i = 0; i < cartItems.length; i++) {
      if (cartItems[i] == product) {
        cartItems.removeAt(i);
        break;
      }
    }
    notifyListeners();
  }

  void clearCart() {
    cartItems = [];
    notifyListeners();
  }
}