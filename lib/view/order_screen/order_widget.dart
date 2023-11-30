// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:grocery_app/controller/dark_theme_controller.dart';
import 'package:provider/provider.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Provider.of<ThemeController>(context);
    Color color = themeController.getDarkTheme ? Colors.white : Colors.black;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(50),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage("https://i.ibb.co/F0s3FHQ/Apricots.png")),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "TITLE x12",
              style: TextStyle(
                  color: color, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "Paid \$ 12.9",
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            )
          ],
        ),
        Spacer(),
        Text(
          "03/09/2022",
          style: TextStyle(fontSize: 18, color: color),
        ),
      ],
    );
  }
}
