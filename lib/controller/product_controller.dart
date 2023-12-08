// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Model/products_model.dart';

class ProductController with ChangeNotifier {
  static final List<ProductModel> _productsList = [];
  List<ProductModel> get getProducts => _productsList;

  List<ProductModel> get getOnsaleProducts {
    return _productsList.where((element) => element.isOnSale).toList();
  }

  Future<void> fetchProduct() async {
    await FirebaseFirestore.instance
        .collection("products")
        .get()
        .then((productSnapShot) {
      _productsList.clear();
      productSnapShot.docs.forEach((document) {
        _productsList.insert(
            0,
            ProductModel(
              id: document.get("id"),
              title: document.get("title"),
              imageUrl: document.get("imageUrl"),
              productCategoryName: document.get("categoryName"),
              price: double.parse(document.get("price")),
              salePrice: document.get("salePrice"),
              isOnSale: document.get("isOnSale"),
              isPiece: document.get("isPiece"),
            ));
      });
    });
  }

  ProductModel findProdByid(String productid) {
    return _productsList.firstWhere((element) => element.id == productid);
  }

  List<ProductModel> findProductByCatName(String catName) {
    return _productsList
        .where((element) =>
            element.productCategoryName.toLowerCase() == catName.toLowerCase())
        .toList();
  }

  List<ProductModel> findBySearch(String query) {
    List<ProductModel> searchList = _productsList
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return searchList;
  }
}
