// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:grocery_app/controller/dark_theme_controller.dart';
import 'package:grocery_app/view/cart/cart_widget.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Provider.of<ThemeController>(context);
    Color color = themeController.getDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "Cart(3)",
          style: TextStyle(color: color, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _showDeleteDialog(context);
              },
              icon: Icon(
                IconlyBroken.delete,
                color: color,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.green)),
                    onPressed: () {},
                    child: Text(
                      "ORDER",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                FittedBox(
                  child: Text(
                    "Total : 322\$",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: color),
                  ),
                )
              ],
            ),
            Flexible(
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int value) => Divider(
                  height: 30,
                  color: color,
                ),
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return CartWidget();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<dynamic> _showDeleteDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Row(
              children: [
                Icon(
                  IconlyBroken.delete,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 28,
                ),
                Flexible(child: Text("DO YOU WANT TO CLEAR THE CART?")),
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
