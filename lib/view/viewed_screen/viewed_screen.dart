//TODO
// import 'package:flutter/material.dart';
// import 'package:grocery_app/view/viewed_screen/viewed_widget.dart';
// import 'package:iconly/iconly.dart';
// import 'package:provider/provider.dart';

// import '../../controller/dark_theme_controller.dart';

// class Viewedscreen extends StatelessWidget {
//   const Viewedscreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     ThemeController themeController = Provider.of<ThemeController>(context);
//     Color color = themeController.getDarkTheme ? Colors.white : Colors.black;
//     bool isEmpty = true;

//     return isEmpty
//         ? Text("COMMING SOON")
//         : Scaffold(
//             appBar: AppBar(
//               backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//               automaticallyImplyLeading: false,
//               centerTitle: true,
//               actions: [
//                 Icon(
//                   IconlyBroken.delete,
//                   color: color,
//                 )
//               ],
//               leading: IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: Icon(
//                     IconlyLight.arrow_left,
//                     color: color,
//                   )),
//               title: Text(
//                 "Histroy",
//                 style: TextStyle(color: color),
//               ),
//             ),
//             body: ListView.builder(
//               itemCount: 3,
//               itemBuilder: (BuildContext context, int index) {
//                 return ViewedWidget();
//               },
//             ),
//           );
//   }
// }
