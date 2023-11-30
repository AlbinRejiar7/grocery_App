// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors,

import 'package:flutter/material.dart';
import 'package:grocery_app/controller/dark_theme_controller.dart';
import 'package:grocery_app/widget/home_screen_widgets/onsale_container.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class OnSaleinnerScreen extends StatelessWidget {
  const OnSaleinnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final themeController = Provider.of<ThemeController>(context);
    Color color = themeController.getDarkTheme ? Colors.white : Colors.black;
    bool isEmpty = true;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "ON SALE",
              style: TextStyle(
                  color: Colors.red, fontSize: 24, fontWeight: FontWeight.w900),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              IconlyBold.discount,
              color: Colors.red,
              size: 35,
            )
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: !isEmpty
          ? Center(
              child: Text(
              "No Sales right now,\nStay tuned",
              style: TextStyle(
                  color: color, fontWeight: FontWeight.w900, fontSize: 34.0),
            ))
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: size.width / (size.height * 0.50)),
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(onTap: () {}, child: OnSaleWidget());
                },
              ),
            ),
    );
  }
}
