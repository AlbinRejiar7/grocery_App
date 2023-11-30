// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/controller/dark_theme_controller.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class ProductdetailScreen extends StatefulWidget {
  const ProductdetailScreen({super.key});

  @override
  State<ProductdetailScreen> createState() => _ProductdetailScreenState();
}

class _ProductdetailScreenState extends State<ProductdetailScreen> {
  TextEditingController quantityController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quantityController.text = "1";
  }

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    Color color = themeController.getDarkTheme ? Colors.white : Colors.black;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(IconlyLight.arrow_left),
          color: color,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(150),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image:
                        NetworkImage("https://i.ibb.co/F0s3FHQ/Apricots.png")),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Name",
                    style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                  Icon(IconlyLight.heart)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "\$ 2.99",
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                      Text(
                        "/Kg",
                        style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Free Delivery",
                      style: TextStyle(color: Colors.white),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.width * 0.22,
              width: size.width * 0.4,
              child: Row(
                children: [
                  SizedBox(
                      height: 50,
                      width: 50,
                      child: InkWell(
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
                            )),
                      )),
                  Flexible(
                    child: TextField(
                        style: TextStyle(color: color, fontSize: 20),
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        controller: quantityController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value) {
                          setState(() {
                            if (value.isEmpty) {
                              quantityController.text = "1";
                            } else {
                              return;
                            }
                          });
                        },
                        decoration:
                            InputDecoration(border: UnderlineInputBorder())),
                  ),
                  SizedBox(
                      height: 50,
                      width: 50,
                      child: InkWell(
                        onTap: () {
                          quantityController.text =
                              (int.parse(quantityController.text) + 1)
                                  .toString();
                          setState(() {});
                        },
                        child: Card(
                            color: Colors.green,
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            )),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Text(
                      "TOTAL",
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w900,
                          fontSize: 20),
                    ),
                    Text(
                      "\$ 2.8",
                      style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w900,
                          fontSize: 24),
                    )
                  ],
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6))),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.green)),
                    onPressed: () {},
                    child: Text(
                      "Add to cart",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
