// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery_app/Model/products_model.dart';
import 'package:grocery_app/controller/cart_controller.dart';
import 'package:grocery_app/controller/dark_theme_provider.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class OurProductsWidget extends StatelessWidget {
  const OurProductsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<DarkThemeProvider>(context);
    Color color = themeController.getDarkTheme ? Colors.white : Colors.black;
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartController>(context);

    bool isInCart = cartProvider.getCartItems.containsKey(productModel.id);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          arguments: productModel.id,
          context,
          "productdetails",
        );
      },
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            productModel.imageUrl.isEmpty || productModel.imageUrl == null
                ? Container(
                    padding: const EdgeInsets.all(38),
                    child: SpinKitCircle(
                      color: Colors.pink[200],
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(38),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(productModel.imageUrl)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    productModel.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: color, fontWeight: FontWeight.w900),
                  ),
                ),
                const Icon(IconlyLight.heart),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    productModel.isOnSale
                        ? Text(
                            "₹${productModel.salePrice.toString()}",
                            style: const TextStyle(
                                color: Colors.green,
                                fontSize: 22,
                                fontWeight: FontWeight.w900),
                          )
                        : Text(
                            "₹${productModel.price.toString()}",
                            style: const TextStyle(
                                color: Colors.green,
                                fontSize: 20,
                                fontWeight: FontWeight.w900),
                          ),
                    Visibility(
                      visible: productModel.isOnSale,
                      child: Text(
                        "₹${productModel.price.toString()}",
                        style: TextStyle(
                            color: color,
                            decoration: TextDecoration.lineThrough,
                            fontSize: 15,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${productModel.isPiece ? "piece" : "kg"} 1",
                  style: TextStyle(
                      fontSize: 17, color: color, fontWeight: FontWeight.w900),
                ),
              ],
            ),
            Flexible(
              child: ElevatedButton(
                  style: ButtonStyle(
                      elevation: const MaterialStatePropertyAll(0.6),
                      backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).primaryColor)),
                  onPressed: isInCart
                      ? () {}
                      : () {
                          cartProvider.addToCart(
                              productId: productModel.id,
                              quantity: 1,
                              context: context);
                          cartProvider.fetchCart();
                        },
                  child: Text(
                    isInCart ? "Already Added" : "Add to cart",
                    style: TextStyle(color: color, fontWeight: FontWeight.w900),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
