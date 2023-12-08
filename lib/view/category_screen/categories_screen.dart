import 'package:flutter/material.dart';
import 'package:grocery_app/controller/dark_theme_provider.dart';
import 'package:provider/provider.dart';

import '../../widget/category_screen_widgets/categories_widget.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeController = Provider.of<DarkThemeProvider>(context);
    final color = themeController.getDarkTheme ? Colors.white : Colors.black;

    List<Map<String, dynamic>> categoriesDetails = [
      {
        "imagepath": "assets/images/categories/fruits.png",
        "catName": "Fruits",
      },
      {
        "imagepath": "assets/images/categories/vegetables.png",
        "catName": "Vegetables",
      },
      {
        "imagepath": "assets/images/categories/herbs.png",
        "catName": "Herbs",
      },
      {
        "imagepath": "assets/images/categories/nuts.png",
        "catName": "Nuts",
      },
      {
        "imagepath": "assets/images/categories/spices.png",
        "catName": "Spices",
      },
      {
        "imagepath": "assets/images/categories/grains.png",
        "catName": "Grains",
      },
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "Categories",
          style: TextStyle(color: color),
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 240 / 250,
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: categoriesDetails.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(13),
            child: CategoriesWidget(
              imagePath: categoriesDetails[index]["imagepath"],
              catName: categoriesDetails[index]["catName"],
            ),
          );
        },
      ),
    );
  }
}
