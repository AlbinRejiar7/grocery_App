import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery_app/Model/order_model.dart';
import 'package:grocery_app/controller/dark_theme_provider.dart';
import 'package:grocery_app/controller/orders_controller.dart';
import 'package:grocery_app/view/order_screen/order_widget.dart';
import 'package:grocery_app/widget/empty_screen.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<OrderModel> orderList = [];
  @override
  void initState() {
    Future.delayed(Durations.extralong1, () async {
      final ordersProvider =
          Provider.of<OrdersController>(context, listen: false);
      await ordersProvider.fetchOrders();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final ordersProvider = Provider.of<OrdersController>(
    //   context,
    // );

    // List<OrderModel> orderList = ordersProvider.getOrders;
    DarkThemeProvider themeController = Provider.of<DarkThemeProvider>(context);
    Color color = themeController.getDarkTheme ? Colors.white : Colors.black;

    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('orders').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            orderList = snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return OrderModel(
                orderId: data["orderId"],
                userId: data["userId"],
                productId: data["productId"],
                userName: data["userName"],
                price: data["price"].toString(),
                imageUrl: data["imageUrl"],
                quantity: data["quantity"].toString(),
                orderTime: data["orderDate"],
              );
            }).toList();
            return Scaffold(
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
          } else if (!snapshot.hasData) {
            return const EmptyScreen();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: SpinKitCircle(
                  color: Colors.red,
                ),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(child: Text("Somethin went wrong")),
            );
          }
        });
  }
}
