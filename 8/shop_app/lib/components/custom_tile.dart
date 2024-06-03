import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function()? onTap;

  const CustomTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        onTap: onTap,
      ),
    );
  }
}