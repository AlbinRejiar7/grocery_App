import 'package:flutter/material.dart';
import 'package:grocery_app/Model/products_model.dart';
import 'package:grocery_app/controller/dark_theme_provider.dart';
import 'package:grocery_app/controller/product_controller.dart';
import 'package:grocery_app/widget/home_screen_widgets/onsale_container.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class OnSaleinnerScreen extends StatefulWidget {
  const OnSaleinnerScreen({super.key});

  @override
  State<OnSaleinnerScreen> createState() => _OnSaleinnerScreenState();
}

class _OnSaleinnerScreenState extends State<OnSaleinnerScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Durations.medium1, () async {
      var provider = Provider.of<ProductController>(context, listen: false);
      await provider.fetchProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final themeController = Provider.of<DarkThemeProvider>(context);
    Color color = themeController.getDarkTheme ? Colors.white : Colors.black;
    final List<ProductModel> onSaleproducts =
        Provider.of<ProductController>(context).getOnsaleProducts;

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
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "ON SALE",
              style: TextStyle(
                  color: Colors.red, fontSize: 24, fontWeight: FontWeight.w900),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              IconlyBold.discount,
              color: Colors.red,
              size: 35,
            )
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: onSaleproducts.isEmpty
          ? Center(
              child: Text(
              "No Sales right now,\nStay tuned",
              style: TextStyle(
                  color: color, fontWeight: FontWeight.w900, fontSize: 34.0),
            ))
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: size.width / (size.height * 0.50)),
                itemCount: onSaleproducts.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {},
                      child: ChangeNotifierProvider.value(
                          value: onSaleproducts[index],
                          child: const OnSaleWidget()));
                },
              ),
            ),
    );
  }
}
