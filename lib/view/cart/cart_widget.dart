// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/controller/dark_theme_controller.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  TextEditingController quantityController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quantityController.text = "1";
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    quantityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    ThemeController themeController = Provider.of<ThemeController>(context);
    Color color = themeController.getDarkTheme ? Colors.white : Colors.black;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(40),
          decoration: BoxDecoration(
            image: const DecorationImage(
                image: NetworkImage("https://i.ibb.co/F0s3FHQ/Apricots.png")),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Green Grape",
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
            SizedBox(
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
                          quantityController.text =
                              (int.parse(quantityController.text) - 1)
                                  .toString();
                        } else {
                          return;
                        }
                      });
                    },
                    child: Card(
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
                      quantityController.text =
                          (int.parse(quantityController.text) + 1).toString();
                      setState(() {});
                    },
                    child: Card(
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
        Spacer(),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkResponse(
              onTap: () {},
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
              "0.23 \$",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.green[700],
                  fontWeight: FontWeight.bold),
            )
          ],
        )
      ],
    );
  }
}
