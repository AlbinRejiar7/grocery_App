//TODO
// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:flutter/material.dart';
// import 'package:grocery_app/controller/dark_theme_controller.dart';
// import 'package:grocery_app/view/inner_screens.dart/product_detail_screen.dart';
// import 'package:provider/provider.dart';

// import '../../globalmethod/pagerouter.dart';

// class ViewedWidget extends StatelessWidget {
//   const ViewedWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     ThemeController themeController = Provider.of<ThemeController>(context);
//     Color color = themeController.getDarkTheme ? Colors.white : Colors.black;
//     var size = MediaQuery.of(context).size;

//     return GestureDetector(
//       onTap: () => Navigator.of(context)
//           .push(buildPageRouteBuilder(ProductdetailScreen())),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             padding: EdgeInsets.all(50),
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                   image: NetworkImage("https://i.ibb.co/F0s3FHQ/Apricots.png")),
//               borderRadius: BorderRadius.circular(20),
//             ),
//           ),
//           SizedBox(
//             width: 10,
//           ),
//           Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 "TITLE",
//                 style: TextStyle(
//                     color: color, fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 "\$12.9",
//                 style:
//                     TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
//               )
//             ],
//           ),
//           Spacer(),
//           SizedBox(
//             width: size.width * 0.1,
//             height: size.width * 0.1,
//             child: Card(
//               color: Colors.green,
//               child: Icon(
//                 Icons.add,
//                 color: Colors.white,
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
