// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:grocery_app/controller/cart_controller.dart';
import 'package:grocery_app/controller/product_controller.dart';
import 'package:grocery_app/view/bottom_nav_bar_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () async {
      var provider = Provider.of<ProductController>(context, listen: false);
      var cartProvider = Provider.of<CartController>(context, listen: false);
      cartProvider.fetchCart();
      await provider.fetchProduct();

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (ctx) => const BottomNavScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
              child: Lottie.asset(
                  fit: BoxFit.cover,
                  "assets/animations/splashbackground.json")),
          Lottie.asset("assets/animations/splashAnimation.json"),
          const Align(
            alignment: Alignment(0, -0.5),
            child: Text(
              "FRESH VEGGIES",
              style: TextStyle(color: Colors.white, fontSize: 50),
            ),
          )
        ],
      ),
    ));
  }
}
