import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:grocery_app/view/cart/cart_screen.dart';
import 'package:grocery_app/view/category_screen/categories_screen.dart';
import 'package:grocery_app/view/home_screen.dart';
import 'package:grocery_app/view/user_screen.dart';
import 'package:iconly/iconly.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int index = 0;
  final List _screens = [
    const HomeScreen(),
    const CategoriesScreen(),
    const CartScreen(),
    const UserScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _screens[index],
        bottomNavigationBar: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: GNav(
                activeColor: Colors.white,
                gap: 8,
                padding: const EdgeInsets.all(16),
                tabBackgroundColor: Theme.of(context).splashColor,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                onTabChange: (value) {
                  setState(() {
                    index = value;
                  });
                },
                tabs: const [
                  GButton(
                    icon: IconlyLight.home,
                    text: "Home",
                  ),
                  GButton(
                    icon: IconlyLight.category,
                    text: "Catagory",
                  ),
                  GButton(
                    icon: IconlyLight.bag_2,
                    text: "Cart",
                  ),
                  GButton(
                    icon: IconlyLight.profile,
                    text: "Profile",
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
