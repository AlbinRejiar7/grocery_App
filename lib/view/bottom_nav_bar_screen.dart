// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:grocery_app/view/cart/cart_screen.dart';
import 'package:grocery_app/view/categories_screen.dart';
import 'package:grocery_app/view/home_screen.dart';
import 'package:grocery_app/view/user_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int index = 0;
  final List _screens = [
    HomeScreen(),
    CategoriesScreen(),
    CartScreen(),
    UserScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[index],
      bottomNavigationBar: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: GNav(
              activeColor: Colors.white,
              gap: 8,
              padding: EdgeInsets.all(16),
              tabBackgroundColor: Theme.of(context).splashColor,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              onTabChange: (value) {
                setState(() {
                  index = value;
                });
              },
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: "Home",
                ),
                GButton(
                  icon: Icons.event,
                  text: "Catagory",
                ),
                GButton(
                  icon: Icons.shopping_cart_sharp,
                  text: "Cart",
                ),
                GButton(
                  icon: Icons.person,
                  text: "Profile",
                ),
              ]),
        ),
      ),
    );
  }
}
