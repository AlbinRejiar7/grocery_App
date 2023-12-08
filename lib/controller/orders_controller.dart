// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Model/order_model.dart';
import 'package:grocery_app/constants/firebase_const.dart';
import 'package:grocery_app/controller/cart_controller.dart';
import 'package:grocery_app/controller/product_controller.dart';
import 'package:grocery_app/controller/user_profile_controller.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class OrdersController with ChangeNotifier {
  static final List<OrderModel> _orders = [];
  List<OrderModel> get getOrders => _orders;

  Future<void> fetchOrders() async {
    User? user = authInstance.currentUser;
    await FirebaseFirestore.instance
        .collection("orders")
        .where("userId", isEqualTo: user!.uid)
        .get()
        .then((ordersSnapShot) {
      _orders.clear();
      ordersSnapShot.docs.forEach((document) {
        _orders.insert(
            0,
            OrderModel(
                orderId: document.get("orderId"),
                userId: document.get("userId"),
                productId: document.get("productId"),
                userName: document.get("userName"),
                price: document.get("price").toString(),
                imageUrl: document.get("imageUrl"),
                quantity: document.get("quantity").toString(),
                orderTime: document.get("orderDate")));
      });
    });
  }

  Future<void> saveOrderstoDb(BuildContext context, var total) async {
    try {
      final userProvider =
          Provider.of<UserProfileScreenProvider>(context, listen: false);
      await userProvider.fetchData(context);
      var cartProvider = Provider.of<CartController>(context, listen: false);
      cartProvider.getCartItems.forEach((key, value) async {
        var currentProduct =
            Provider.of<ProductController>(context, listen: false).findProdByid(
          value.productId,
        );

        User? user = authInstance.currentUser;
        final orderId = const Uuid().v4();
        await FirebaseFirestore.instance.collection("orders").doc(orderId).set({
          "orderId": orderId,
          "userId": user!.uid,
          "productId": value.productId,
          "price": (currentProduct.isOnSale
                  ? currentProduct.salePrice
                  : currentProduct.price) *
              value.quantity,
          "totalPrice": total,
          "quantity": value.quantity,
          "imageUrl": currentProduct.imageUrl,
          "userName": userProvider.username,
          "orderDate": Timestamp.now(),
          "address": userProvider.address,
        });
        await fetchOrders();
        cartProvider.clearCart();

        await cartProvider.clearCartOnDb();
      });
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("ERROR:${e.toString()}")));
    }
    notifyListeners();
  }
}
