// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:grocery_app/controller/dark_theme_controller.dart';
import 'package:grocery_app/view/order_screen/order_screen.dart';
import 'package:grocery_app/view/viewed_screen/viewed_screen.dart';
import 'package:grocery_app/view/wishlist_screen/wishlist_screen.dart';
import 'package:grocery_app/widget/user_screen_wigets/my_list_tile.dart';
import 'package:provider/provider.dart';

import '../globalmethod/pagerouter.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    Color color = themeController.getDarkTheme ? Colors.white : Colors.black;
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: CircleAvatar(
                radius: 54,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      "https://image.lexica.art/full_jpg/7515495b-982d-44d2-9931-5a8bbbf27532"),
                ),
              ),
            ),
            Text(
              "Username",
              style: TextStyle(color: color),
            ),
            Text(
              "abcd@gmail.com",
              style: TextStyle(color: color),
            ),
            MyUserScreenListTile(
              onTap: () {},
              title: "address",
              myIcon: Icons.person_2_outlined,
              color: color,
            ),
            MyUserScreenListTile(
              onTap: () {
                Navigator.of(context)
                    .push(buildPageRouteBuilder(OrderScreen()));
              },
              title: "Orders",
              myIcon: Icons.account_balance_wallet_outlined,
              color: color,
            ),
            MyUserScreenListTile(
              onTap: () {
                Navigator.of(context)
                    .push(buildPageRouteBuilder(WishListScreen()));
              },
              title: "Wishlist",
              myIcon: Icons.favorite_border_outlined,
              color: color,
            ),
            MyUserScreenListTile(
              onTap: () {
                Navigator.of(context)
                    .push(buildPageRouteBuilder(Viewedscreen()));
              },
              title: "Viewed",
              myIcon: Icons.remove_red_eye_outlined,
              color: color,
            ),
            MyUserScreenListTile(
              onTap: () {},
              title: "Forget Password",
              myIcon: Icons.lock,
              color: color,
            ),
            SwitchListTile(
              title: Text(
                themeController.getDarkTheme ? "Dark theme" : "Light theme",
                style: TextStyle(color: color),
              ),
              secondary: SizedBox(
                height: 60,
                width: 60,
                child: Card(
                  child: Icon(themeController.getDarkTheme
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  themeController.setDarkTheme = value;
                });
              },
              value: themeController.getDarkTheme,
            ),
            MyUserScreenListTile(
              onTap: () {
                _showLogoutDialog(context);
              },
              title: "Logout",
              myIcon: Icons.logout_outlined,
              color: color,
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _showLogoutDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Row(
                children: [
                  Icon(
                    Icons.logout_outlined,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 28,
                  ),
                  Text("DO YOU WANT TO LOGOUT?"),
                ],
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.cancel)),
                IconButton(onPressed: () {}, icon: Icon(Icons.done))
              ],
            ));
  }
}
