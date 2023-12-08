// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Model/cart_model.dart';
import 'package:grocery_app/constants/firebase_const.dart';
import 'package:uuid/uuid.dart';

class CartController with ChangeNotifier {
  final User? user = authInstance.currentUser;
  final userCollection = FirebaseFirestore.instance.collection("users");
  final Map<String, CartModel> _cartItems = {};

  Map<String, CartModel> get getCartItems {
    return _cartItems;
  }

  void addToCart(
      {required String productId,
      required int quantity,
      required BuildContext context}) async {
    try {
      var user = authInstance.currentUser;
      final uid = user!.uid;
      final cartId = const Uuid().v4();
      await FirebaseFirestore.instance.collection("users").doc(uid).update({
        "userCart": FieldValue.arrayUnion([
          {
            "cartId": cartId,
            "productId": productId,
            "quantity": quantity,
          }
        ])
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(milliseconds: 300),
          content: Text("ADDED TO CART")));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> fetchCart() async {
    final User? user = authInstance.currentUser;
    String uid = user!.uid;
    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    for (Map userCart in userDoc.get("userCart")) {
      _cartItems.putIfAbsent(
          userCart["productId"],
          () => CartModel(
              id: userCart["cartId"],
              productId: userCart["productId"],
              quantity: userCart["quantity"]));
    }

    notifyListeners();
  }

  void reduceQuantity(String productId) {
    _cartItems.update(
        productId,
        (value) => CartModel(
            id: value.id, productId: productId, quantity: value.quantity - 1));
    notifyListeners();
  }

  void increaseQuantity(String productId) {
    _cartItems.update(
        productId,
        (value) => CartModel(
            id: value.id, productId: productId, quantity: value.quantity + 1));
    notifyListeners();
  }

  Future<void> removeOneItem(
      {required String productId,
      required String cartId,
      required int quantity}) async {
    await userCollection.doc(user!.uid).update({
      "userCart": FieldValue.arrayRemove([
        {
          "cartId": cartId,
          "productId": productId,
          "quantity": quantity,
        }
      ])
    });
    _cartItems.remove(productId);

    notifyListeners();
  }

  Future<void> clearCartOnDb() async {
    await userCollection.doc(user!.uid).update({
      "userCart": [],
    });
    clearCart();
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
