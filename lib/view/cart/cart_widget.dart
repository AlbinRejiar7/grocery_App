import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/Model/cart_model.dart';
import 'package:grocery_app/controller/cart_controller.dart';

import 'package:grocery_app/controller/dark_theme_provider.dart';
import 'package:grocery_app/controller/product_controller.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class CartWidget extends StatefulWidget {
  final String quantity;
  const CartWidget({super.key, required this.quantity});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  TextEditingController quantityController = TextEditingController();
  @override
  void initState() {
    super.initState();
    quantityController.text = widget.quantity;
  }

  @override
  void dispose() {
    super.dispose();
    quantityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    DarkThemeProvider themeController = Provider.of<DarkThemeProvider>(context);
    Color color = themeController.getDarkTheme ? Colors.white : Colors.black;
    final productProvider = Provider.of<ProductController>(context);
    final cartModel = Provider.of<CartModel>(context);
    final getCurrentproduct = productProvider.findProdByid(cartModel.productId);
    final cartProvider = Provider.of<CartController>(context);
    double usedPrice = getCurrentproduct.isOnSale
        ? getCurrentproduct.salePrice
        : getCurrentproduct.price;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "productdetails",
            arguments: cartModel.productId);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(getCurrentproduct.imageUrl)),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                getCurrentproduct.title,
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (quantityController.text != "1") {
                            cartProvider.reduceQuantity(cartModel.productId);
                            quantityController.text =
                                (int.parse(quantityController.text) - 1)
                                    .toString();
                          } else {
                            return;
                          }
                        });
                      },
                      child: const Card(
                        color: Colors.red,
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Flexible(
                      child: SizedBox(
                        height: size.width * 0.07,
                        width: size.width * 0.2,
                        child: TextField(
                          textAlign: TextAlign.center,
                          style: TextStyle(color: color),
                          onChanged: (value) {
                            setState(() {
                              if (value.isEmpty) {
                                quantityController.text = "1";
                              } else {
                                return;
                              }
                            });
                          },
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          controller: quantityController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        cartProvider.increaseQuantity(cartModel.productId);
                        quantityController.text =
                            (int.parse(quantityController.text) + 1).toString();
                        setState(() {});
                      },
                      child: const Card(
                        color: Colors.green,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const Spacer(),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkResponse(
                onTap: () async {
                  await cartProvider.removeOneItem(
                      cartId: cartModel.id,
                      productId: cartModel.productId,
                      quantity: cartModel.quantity);
                },
                child: Icon(
                  Icons.delete_forever_outlined,
                  color: color,
                ),
              ),
              InkResponse(
                onTap: () {},
                child: Icon(
                  IconlyLight.heart,
                  color: color,
                ),
              ),
              Text(
                "₹ ${(usedPrice * (int.parse(quantityController.text)))}",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.green[700],
                    fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
