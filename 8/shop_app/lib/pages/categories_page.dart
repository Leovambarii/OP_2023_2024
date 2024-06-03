import 'package:flutter/material.dart';
import 'package:shop_app/models/shop.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/custom_drawer.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = context.watch<Shop>().categories;

    double gridSpacing = 16.0;
    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    double fontSize = isLandscape ? 28.0 : 22.0;
    double iconSize = isLandscape ? 64.0 : 48.0;
    int crossAxisCount = isLandscape ? 3 : 2;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'Categories',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      endDrawer: const CustomDrawer(),
      backgroundColor: Colors.green[100],
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: gridSpacing,
                  mainAxisSpacing: gridSpacing,
                  childAspectRatio: 1,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    onPressed: () => {
                      Navigator.pushNamed(
                        context,
                        '/products',
                        arguments: category
                      )
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          category.icon,
                          size: iconSize,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          category.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: fontSize
                          ),
                        ),
                      ],
                    )
                  );
                }
            ),
          ),
        ),
      )
    );
  }
}