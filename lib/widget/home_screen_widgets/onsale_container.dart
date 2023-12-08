import 'package:flutter/material.dart';
import 'package:grocery_app/Model/products_model.dart';
import 'package:grocery_app/controller/cart_controller.dart';
import 'package:grocery_app/controller/dark_theme_provider.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class OnSaleWidget extends StatefulWidget {
  const OnSaleWidget({
    super.key,
  });

  @override
  State<OnSaleWidget> createState() => _OnSaleWidgetState();
}

class _OnSaleWidgetState extends State<OnSaleWidget> {
  @override
  Widget build(BuildContext context) {
    DarkThemeProvider themeController = Provider.of<DarkThemeProvider>(context);
    Color color = themeController.getDarkTheme ? Colors.white : Colors.black;

    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartController>(context);
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
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).cardColor,
        ),
        child: Column(
          children: [
            Row(
              children: [
                // FancyShimmerImage(
                //   imageUrl: "https://i.ibb.co/F0s3FHQ/Apricots.png",
                //   boxFit: BoxFit.fill,
                //   width: size.width * 0.22,
                //   height: size.width * 0.22,
                // ),
                Container(
                  padding: const EdgeInsets.all(50),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(productModel.imageUrl)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "1 ${productModel.isPiece ? "Piece" : "kg"}",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            cartProvider.addToCart(
                                productId: productModel.id,
                                quantity: 1,
                                context: context);
                            cartProvider.fetchCart();
                          },
                          child: Icon(
                            IconlyLight.bag_2,
                            color: color,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            IconlyLight.heart,
                            color: color,
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
            Flexible(
              child: Row(
                children: [
                  Text(
                    "₹${productModel.salePrice}",
                    style: const TextStyle(color: Colors.green, fontSize: 25),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '₹ ${productModel.price.toString()}',
                    style: TextStyle(
                      color: color,
                      fontSize: 15,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Text(
                productModel.title,
                style: TextStyle(fontWeight: FontWeight.w900, color: color),
              ),
            )
          ],
        ),
      ),
    );
  }
}
