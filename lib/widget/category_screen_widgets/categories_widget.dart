// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:grocery_app/controller/dark_theme_controller.dart';
import 'package:provider/provider.dart';

class CategoriesWidget extends StatelessWidget {
  void Function()? onTap;
  final String catName;
  final String imagePath;
  CategoriesWidget(
      {super.key, this.onTap, required this.catName, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    var themeController = Provider.of<ThemeController>(context);
    final color = themeController.getDarkTheme ? Colors.white : Colors.black;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: themeController.getDarkTheme
                  ? Colors.white10
                  : Colors.black54,
              width: 2,
            )),
        child: Column(
          children: [
            Container(
              height: screenWidth * 0.3,
              width: screenWidth * 0.3,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(imagePath))),
            ),
            Text(
              catName,
              style: TextStyle(color: color, fontSize: 17),
            )
          ],
        ),
      ),
    );
  }
}
