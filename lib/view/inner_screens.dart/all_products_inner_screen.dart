import 'package:flutter/material.dart';
import 'package:grocery_app/Model/products_model.dart';
import 'package:grocery_app/controller/dark_theme_provider.dart';
import 'package:grocery_app/controller/product_controller.dart';
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
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Durations.extralong1, () async {
      final productProviders =
          Provider.of<ProductController>(context, listen: false);
      await productProviders.fetchProduct();
    });
  }

  TextEditingController searchController = TextEditingController();
  var query = "";
  @override
  Widget build(BuildContext context) {
    var themeController = Provider.of<DarkThemeProvider>(context);
    final color = themeController.getDarkTheme ? Colors.white : Colors.black;
    final productProviders = Provider.of<ProductController>(context);
    List<ProductModel> allProducts = productProviders.getProducts;
    List<ProductModel> searchProducts = productProviders.findBySearch(query);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: color,
            )),
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
                onChanged: (val) {
                  setState(() {
                    query = val;
                  });
                },
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
              ),
            ),
            searchProducts.isEmpty
                ? const Text("NO ITEM IN THIS NAME")
                : GridView.builder(
                    padding: const EdgeInsets.all(5),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: searchController.text.isEmpty
                        ? allProducts.length
                        : searchProducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ChangeNotifierProvider.value(
                        value: searchController.text.isEmpty
                            ? allProducts[index]
                            : searchProducts[index],
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
