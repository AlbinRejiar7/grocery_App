import 'package:flutter/material.dart';
import 'package:grocery_app/controller/dark_theme_provider.dart';
import 'package:grocery_app/view/inner_screens.dart/all_products_inner_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../globalmethod/pagerouter.dart';

class EmptyScreen extends StatefulWidget {
  const EmptyScreen({super.key});

  @override
  State<EmptyScreen> createState() => _EmptyScreenState();
}

class _EmptyScreenState extends State<EmptyScreen> {
  @override
  Widget build(BuildContext context) {
    DarkThemeProvider themeController = Provider.of<DarkThemeProvider>(context);
    Color color = themeController.getDarkTheme ? Colors.white : Colors.black;
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Lottie.asset("assets/animations/empty_cart_animation.json"),
          const Text(
            "Whoops!",
            style: TextStyle(
                color: Colors.red, fontSize: 50, fontWeight: FontWeight.bold),
          ),
          Text(
            "Empty Here",
            style: TextStyle(color: color, fontSize: 24),
          ),
          const SizedBox(
            height: 10,
          ),
          Flexible(
            child: SizedBox(
              width: size.width * 0.5,
              height: size.width * 0.13,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.green),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                  onPressed: () {
                    Navigator.of(context).push(
                        buildPageRouteBuilder(const AllProductsInnerScreen()));
                  },
                  child: const Text(
                    "Shop Now",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
