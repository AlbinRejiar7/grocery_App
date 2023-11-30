// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../../controller/dark_theme_controller.dart';

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
    ThemeController themeController = Provider.of<ThemeController>(context);
    Color color = themeController.getDarkTheme ? Colors.white : Colors.black;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
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
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(50),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://i.ibb.co/F0s3FHQ/Apricots.png")),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              Column(
                children: [
                  Text(
                    "1KG",
                    style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        shadows: [
                          BoxShadow(
                              blurRadius: 5,
                              spreadRadius: 20,
                              blurStyle: BlurStyle.outer)
                        ]),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "1.5\$",
                style: TextStyle(color: Colors.green, fontSize: 25),
              ),
              Text(
                "3.5\$",
                style: TextStyle(
                  color: color,
                  fontSize: 17,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
          Text(
            "Product Title",
            style: TextStyle(fontWeight: FontWeight.w900, color: color),
          )
        ],
      ),
    );
  }
}
