import 'package:flutter/material.dart';
import 'package:grocery_app/controller/dark_theme_controller.dart';
import 'package:grocery_app/view/wishlist_screen/wishlist_widget.dart';
import 'package:grocery_app/widget/empty_screen.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Provider.of<ThemeController>(context);
    Color color = themeController.getDarkTheme ? Colors.white : Colors.black;
    bool isEmpty = false;
    return isEmpty
        ? EmptyScreen()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              centerTitle: true,
              automaticallyImplyLeading: false,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    IconlyLight.arrow_left,
                    color: color,
                  )),
              title: Text(
                "Wishist (2)",
                style: TextStyle(color: color),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      _showDeleteDialog(context);
                    },
                    icon: Icon(
                      IconlyBroken.delete,
                      color: color,
                    ))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return WishListWidget();
                },
              ),
            ),
          );
  }
}

Future<dynamic> _showDeleteDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Row(
              children: [
                Icon(
                  IconlyBroken.delete,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 28,
                ),
                Flexible(child: Text("DO YOU WANT TO CLEAR YOUR WISHLIST?")),
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.cancel)),
              IconButton(onPressed: () {}, icon: Icon(Icons.done))
            ],
          ));
}
