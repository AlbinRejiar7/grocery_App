// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:grocery_app/controller/dark_theme_controller.dart';
import 'package:grocery_app/view/inner_screens.dart/all_products_inner_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../globalmethod/pagerouter.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Provider.of<ThemeController>(context);
    Color color = themeController.getDarkTheme ? Colors.white : Colors.black;
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Lottie.asset("assets/animations/empty_cart_animation.json"),
            Text(
              "Whoops!",
              style: TextStyle(
                  color: Colors.red, fontSize: 50, fontWeight: FontWeight.bold),
            ),
            Text(
              "Empty Here",
              style: TextStyle(color: color, fontSize: 24),
            ),
            SizedBox(
              height: size.width * 0.4,
            ),
            SizedBox(
              width: size.width * 0.5,
              height: size.width * 0.16,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                  onPressed: () {
                    Navigator.of(context)
                        .push(buildPageRouteBuilder(AllProductsInnerScreen()));
                  },
                  child: Text(
                    "Shop Now",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
