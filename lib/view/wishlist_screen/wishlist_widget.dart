//TODO: Comming soon
// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:flutter/material.dart';
// import 'package:grocery_app/controller/dark_theme_controller.dart';
// import 'package:iconly/iconly.dart';
// import 'package:provider/provider.dart';

// class WishListWidget extends StatelessWidget {
//   const WishListWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     ThemeController themeController = Provider.of<ThemeController>(context);
//     Color color = themeController.getDarkTheme ? Colors.white : Colors.black;
//     return Container(
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: color)),
//       child: Row(
//         children: [
//           Container(
//             padding: EdgeInsets.all(50),
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                   image: NetworkImage("https://i.ibb.co/F0s3FHQ/Apricots.png")),
//               borderRadius: BorderRadius.circular(20),
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Row(
//                 children: [
//                   Icon(IconlyLight.bag),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Icon(IconlyLight.heart),
//                 ],
//               ),
//               Flexible(
//                 child: Text(
//                   "Names",
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     overflow: TextOverflow.ellipsis,
//                     color: color,
//                   ),
//                 ),
//               ),
//               Text(
//                 "\$ 2.99",
//                 style: TextStyle(
//                     color: color, fontWeight: FontWeight.bold, fontSize: 20),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
