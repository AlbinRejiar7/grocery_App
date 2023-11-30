// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/view/inner_screens.dart/all_products_inner_screen.dart';
import 'package:grocery_app/view/inner_screens.dart/product_detail_screen.dart';
import 'package:grocery_app/widget/home_screen_widgets/onsale_container.dart';
import 'package:grocery_app/widget/home_screen_widgets/product_widget.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../controller/dark_theme_controller.dart';
import '../globalmethod/pagerouter.dart';
import 'inner_screens.dart/onsale_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final themeController = Provider.of<ThemeController>(context);
    Color color = themeController.getDarkTheme ? Colors.white : Colors.black;

    List<String> carouselImages = [
      "https://images.unsplash.com/photo-1542838132-92c53300491e?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Z3JvY2VyeXxlbnwwfHwwfHx8MA%3D%3D",
      "https://images.unsplash.com/photo-1516594798947-e65505dbb29d?ixid=MnwyNTE2NnwwfDF8c2VhcmNofDJ8fEdyb2Nlcnl8ZW58MHx8fHwxNjY5MTQ1OTg5&ixlib=rb-4.0.3&q=85&w=2160",
      "https://globalnews.ca/wp-content/uploads/2020/12/CP161994.jpg?quality=85&strip=all&w=1200",
    ];

    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                CarouselSlider.builder(
                  itemCount: carouselImages.length,
                  itemBuilder:
                      (BuildContext context, int itemIndex, int pageViewIndex) {
                    return Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(carouselImages[itemIndex]))),
                    );
                  },
                  options: CarouselOptions(
                    height: size.width * 0.99,
                    onPageChanged: (value, reason) {
                      // setState(() {
                      //   currentIndex = value;
                      // });
                    },
                    autoPlay: true,
                    enableInfiniteScroll: true,
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
                      Text(
                        "Fruits & Vegetables",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      Text(
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
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  buildPageRouteBuilder(OnSaleinnerScreen()),
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
                    Icon(
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
            Row(
              children: [
                RotatedBox(
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
                        separatorBuilder: (context, builder) => SizedBox(
                          width: 15,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  buildPageRouteBuilder(ProductdetailScreen()),
                                );
                              },
                              child: OnSaleWidget());
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
                  buildPageRouteBuilder(AllProductsInnerScreen()),
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
                    Icon(
                      IconlyLight.arrow_right,
                      size: 29,
                    )
                  ],
                ),
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
      )),
    );
  }
}
