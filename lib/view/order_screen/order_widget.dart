import 'package:flutter/material.dart';
import 'package:grocery_app/Model/order_model.dart';
import 'package:grocery_app/controller/dark_theme_provider.dart';
import 'package:grocery_app/controller/product_controller.dart';
import 'package:provider/provider.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({super.key});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    final ordersModel = Provider.of<OrderModel>(context);
    DarkThemeProvider themeController = Provider.of<DarkThemeProvider>(context);
    Color color = themeController.getDarkTheme ? Colors.white : Colors.black;
    final getCurrentProdcut =
        Provider.of<ProductController>(context, listen: false)
            .findProdByid(ordersModel.productId);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(50),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(getCurrentProdcut.imageUrl)),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${getCurrentProdcut.title} x${ordersModel.quantity}",
              style: TextStyle(
                  color: color, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "Paid ₹ ${ordersModel.price}",
              style: const TextStyle(
                  color: Colors.green, fontWeight: FontWeight.bold),
            )
          ],
        ),
        const Spacer(),
        Text(
          "${ordersModel.orderTime.toDate().day.toString()}/${ordersModel.orderTime.toDate().month.toString()}/${ordersModel.orderTime.toDate().year.toString()}",
          style: TextStyle(fontSize: 18, color: color),
        ),
      ],
    );
  }
}
