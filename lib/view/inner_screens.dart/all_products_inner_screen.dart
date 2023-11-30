import 'package:flutter/material.dart';
import 'package:grocery_app/controller/dark_theme_controller.dart';
import 'package:grocery_app/widget/home_screen_widgets/product_widget.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class AllProductsInnerScreen extends StatefulWidget {
  const AllProductsInnerScreen({super.key});

  @override
  State<AllProductsInnerScreen> createState() => _AllProductsInnerScreenState();
}

class _AllProductsInnerScreenState extends State<AllProductsInnerScreen> {
  @override
  Widget build(BuildContext context) {
    var themeController = Provider.of<ThemeController>(context);
    final color = themeController.getDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "All Products",
          style: TextStyle(fontWeight: FontWeight.w900, color: color),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: TextStyle(color: color),
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      IconlyLight.search,
                      color: color,
                    ),
                    hintText: "Search the product in your mind",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return OurProductsWidget();
              },
            ),
          ],
        ),
      ),
    );
  }
}
