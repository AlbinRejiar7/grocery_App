import 'package:flutter/material.dart';
import 'package:grocery_app/controller/dark_theme_provider.dart';
import 'package:grocery_app/controller/orders_controller.dart';
import 'package:grocery_app/view/order_screen/order_widget.dart';
import 'package:grocery_app/widget/empty_screen.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersController>(context);
    DarkThemeProvider themeController = Provider.of<DarkThemeProvider>(context);
    Color color = themeController.getDarkTheme ? Colors.white : Colors.black;
    final orderList = ordersProvider.getOrders;
    return FutureBuilder(
        future: ordersProvider.fetchOrders(),
        builder: (context, snapshot) {
          return orderList.isEmpty
              ? const EmptyScreen()
              : Scaffold(
                  appBar: AppBar(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          IconlyLight.arrow_left,
                          color: color,
                        )),
                    title: Text(
                      "Your orders (${orderList.length})",
                      style: TextStyle(color: color),
                    ),
                  ),
                  body: ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: color,
                    ),
                    itemCount: orderList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ChangeNotifierProvider.value(
                          value: orderList[index], child: const OrderWidget());
                    },
                  ),
                );
        });
  }
}
