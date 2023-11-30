import 'package:flutter/material.dart';
import 'package:grocery_app/view/order_screen/order_widget.dart';
import 'package:grocery_app/widget/empty_screen.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../../controller/dark_theme_controller.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isEmpty = false;
    ThemeController themeController = Provider.of<ThemeController>(context);
    Color color = themeController.getDarkTheme ? Colors.white : Colors.black;

    return isEmpty
        ? EmptyScreen()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              automaticallyImplyLeading: false,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    IconlyLight.arrow_left,
                    color: color,
                  )),
              title: Text(
                "Your orders (2)",
                style: TextStyle(color: color),
              ),
            ),
            body: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: color,
              ),
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return OrderWidget();
              },
            ),
          );
  }
}
