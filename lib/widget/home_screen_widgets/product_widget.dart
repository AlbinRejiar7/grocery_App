import 'package:flutter/material.dart';
import 'package:grocery_app/controller/dark_theme_controller.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class OurProductsWidget extends StatelessWidget {
  const OurProductsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    Color color = themeController.getDarkTheme ? Colors.white : Colors.black;
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(40),
            decoration: BoxDecoration(
              image: const DecorationImage(
                  image: NetworkImage("https://i.ibb.co/F0s3FHQ/Apricots.png")),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ProductName",
                style: TextStyle(color: color, fontWeight: FontWeight.w900),
              ),
              Icon(IconlyLight.heart),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "0.99\$",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 22,
                    fontWeight: FontWeight.w900),
              ),
              Text(
                "Kg 1",
                style: TextStyle(
                    fontSize: 17, color: color, fontWeight: FontWeight.w900),
              ),
            ],
          ),
          ElevatedButton(
              style: ButtonStyle(
                  elevation: MaterialStatePropertyAll(0.6),
                  backgroundColor:
                      MaterialStatePropertyAll(Theme.of(context).primaryColor)),
              onPressed: () {},
              child: Text(
                "Add to cart",
                style: TextStyle(color: color, fontWeight: FontWeight.w900),
              ))
        ],
      ),
    );
  }
}
