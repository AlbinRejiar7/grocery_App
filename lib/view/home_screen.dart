import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Model/products_model.dart';
import 'package:grocery_app/controller/dark_theme_provider.dart';
import 'package:grocery_app/controller/product_controller.dart';
import 'package:grocery_app/view/inner_screens.dart/all_products_inner_screen.dart';
import 'package:grocery_app/widget/home_screen_widgets/onsale_container.dart';
import 'package:grocery_app/widget/home_screen_widgets/product_widget.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../globalmethod/pagerouter.dart';
import 'inner_screens.dart/onsale_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    var provider = Provider.of<ProductController>(context, listen: false);
    provider.fetchProduct();
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final themeController = Provider.of<DarkThemeProvider>(context);
    Color color = themeController.getDarkTheme ? Colors.white : Colors.black;
    final List<ProductModel> allproducts =
        Provider.of<ProductController>(context).getProducts;
    final List<ProductModel> onSaleproducts =
        Provider.of<ProductController>(context).getOnsaleProducts;

    List<String> carouselImages = [
      "https://images.unsplash.com/photo-1550989460-0adf9ea622e2?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "https://images.unsplash.com/photo-1695653422259-8a74ffe90401?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "https://images.unsplash.com/photo-1526470498-9ae73c665de8?q=80&w=1996&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "https://images.unsplash.com/photo-1542838132-92c53300491e?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "https://images.unsplash.com/photo-1579113800032-c38bd7635818?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fGdyb2Nlcnl8ZW58MHx8MHx8fDA%3D",
    ];

    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: CarouselSlider.builder(
                    itemCount: carouselImages.length,
                    itemBuilder: (BuildContext context, int itemIndex,
                        int pageViewIndex) {
                      return Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    NetworkImage(carouselImages[itemIndex]))),
                      );
                    },
                    options: CarouselOptions(
                      animateToClosest: true,
                      height: size.width * 0.99,
                      autoPlay: true,
                      enableInfiniteScroll: true,
                    ),
                  ),
                ),
                Container(
                  height: size.width * 0.99,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Color.fromARGB(210, 0, 0, 0),
                    Colors.transparent
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
                ),
                Positioned(
                  bottom: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Fruits & Vegetables",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      const Text(
                        "Produced by local &\nit's safe to eat",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w900),
                      ),
                      Row(
                        children: [
                          Text(
                            "Shop Now",
                            style: TextStyle(
                                color: Colors.green[500],
                                fontSize: 34,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  buildPageRouteBuilder(const OnSaleinnerScreen()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "View All",
                      style: TextStyle(color: color, fontSize: 24),
                    ),
                    const Icon(
                      IconlyLight.arrow_right,
                      size: 29,
                    )
                  ],
                ),
              ),
            ),
            // DotsIndicator(
            //   dotsCount: carouselImages.length,
            //   position: currentIndex,
            //   decorator: DotsDecorator(
            //     color: Colors.brown,
            //     activeColor: Colors.blue[900],
            //     size: const Size.square(10),
            //     activeSize: const Size(25, 11),
            //     activeShape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(5.0),
            //     ),
            //   ),
            // ),
            onSaleproducts.isEmpty
                ? const Text(
                    "Currently Theres no offer",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 24,
                        fontWeight: FontWeight.w900),
                  )
                : Row(
                    children: [
                      const RotatedBox(
                        quarterTurns: -1,
                        child: Row(
                          children: [
                            Text(
                              "ON SALE",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900),
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
                      ),
                      Flexible(
                        child: SizedBox(
                          height: size.width * 0.50,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.separated(
                              separatorBuilder: (context, builder) =>
                                  const SizedBox(
                                width: 15,
                              ),
                              scrollDirection: Axis.horizontal,
                              itemCount: onSaleproducts.length > 4
                                  ? 4
                                  : onSaleproducts.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ChangeNotifierProvider.value(
                                    value: onSaleproducts[index],
                                    child: const OnSaleWidget());
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  buildPageRouteBuilder(const AllProductsInnerScreen()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Our Products",
                      style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w900,
                          fontSize: 24),
                    ),
                    const Icon(
                      IconlyLight.arrow_right,
                      size: 29,
                    )
                  ],
                ),
              ),
            ),
            allproducts.isEmpty
                ? const Text(
                    "STORE IS EMPTY",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 24,
                        fontWeight: FontWeight.w900),
                  )
                : GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                    ),
                    itemCount: allproducts.length > 4 ? 4 : allproducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ChangeNotifierProvider.value(
                          value: allproducts[index],
                          child: const OurProductsWidget());
                    },
                  )
          ],
        ),
      )),
    );
  }
}
