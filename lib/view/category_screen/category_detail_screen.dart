import 'package:flutter/material.dart';
import 'package:grocery_app/Model/products_model.dart';

import 'package:grocery_app/controller/dark_theme_provider.dart';
import 'package:grocery_app/controller/product_controller.dart';
import 'package:grocery_app/widget/home_screen_widgets/product_widget.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class CategorydetailScreen extends StatefulWidget {
  const CategorydetailScreen({super.key});

  @override
  State<CategorydetailScreen> createState() => _CategorydetailScreenState();
}

class _CategorydetailScreenState extends State<CategorydetailScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  var query = "";
  @override
  Widget build(BuildContext context) {
    var themeController = Provider.of<DarkThemeProvider>(context);
    final color = themeController.getDarkTheme ? Colors.white : Colors.black;
    String catName = ModalRoute.of(context)!.settings.arguments as String;
    List<ProductModel> getProductBycat =
        Provider.of<ProductController>(context).findProductByCatName(catName);

    List<ProductModel> searchQueryList =
        Provider.of<ProductController>(context).findBySearch(query);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          catName,
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
                controller: searchController,
                style: TextStyle(color: color),
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      IconlyLight.search,
                      color: color,
                    ),
                    hintText: "Search the product in your mind",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
                onChanged: (value) {
                  setState(() {
                    query = value;
                  });
                },
              ),
            ),
            searchController.text.isNotEmpty && searchQueryList.isEmpty
                ? const Text("NO PRODUCTS WITH THIS NAME")
                : GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: searchController.text.isNotEmpty
                        ? searchQueryList.length
                        : getProductBycat.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ChangeNotifierProvider.value(
                        value: searchController.text.isNotEmpty
                            ? searchQueryList[index]
                            : getProductBycat[index],
                        child: const OurProductsWidget(),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
