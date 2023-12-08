// prefer_const_constructors, use_build_context_synchronously

// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery_app/constants/firebase_const.dart';
import 'package:grocery_app/controller/dark_theme_provider.dart';
import 'package:grocery_app/controller/user_profile_controller.dart';
import 'package:grocery_app/view/auth/login_screen.dart';
import 'package:grocery_app/view/order_screen/order_screen.dart';
import 'package:grocery_app/widget/user_screen_wigets/my_list_tile.dart';
import 'package:provider/provider.dart';

import '../globalmethod/pagerouter.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    UserProfileScreenProvider provider =
        Provider.of<UserProfileScreenProvider>(context, listen: false);
    provider.fetchData(context);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProfileScreenProvider>(context);

    final themeState = Provider.of<DarkThemeProvider>(context);
    Color color = themeState.getDarkTheme ? Colors.white : Colors.black;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            userProvider.username == null ||
                    userProvider.email == null ||
                    userProvider.imageUrl == null
                ? const SpinKitCircle(
                    color: Colors.pink,
                  )
                : Column(
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 54,
                          child: CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  NetworkImage(userProvider.imageUrl!)),
                        ),
                      ),
                      Text(
                        userProvider.username!.toUpperCase(),
                        style: TextStyle(color: color, fontSize: 23),
                      ),
                      Text(
                        userProvider.email!,
                        style: TextStyle(color: color),
                      )
                    ],
                  ),
            const SizedBox(
              height: 15,
            ),
            MyUserScreenListTile(
              isAddress: true,
              address: Text(
                userProvider.address ?? "something wrong",
                style: TextStyle(color: color),
              ),
              onTap: () {
                _showAddressTypingBox(context, color, userProvider);
              },
              title: "address",
              myIcon: Icons.person_2_outlined,
              color: color,
            ),
            const SizedBox(
              height: 15,
            ),
            MyUserScreenListTile(
              onTap: () {
                Navigator.of(context)
                    .push(buildPageRouteBuilder(const OrderScreen()));
              },
              title: "Orders",
              myIcon: Icons.account_balance_wallet_outlined,
              color: color,
            ),
            const SizedBox(
              height: 15,
            ),
            SwitchListTile(
              title: Text(
                themeState.getDarkTheme ? 'Dark mode' : 'Light mode',
                style: TextStyle(color: color),
              ),
              secondary: SizedBox(
                height: 60,
                width: 60,
                child: Card(
                  child: Icon(themeState.getDarkTheme
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  themeState.setDarkTheme = value;
                });
              },
              value: themeState.getDarkTheme,
            ),
            const SizedBox(
              height: 15,
            ),
            MyUserScreenListTile(
              onTap: () {
                _showLogoutDialog(context);
              },
              title: "Logout",
              myIcon: Icons.logout_outlined,
              color: color,
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _showLogoutDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: const Row(
                children: [
                  Icon(
                    Icons.logout_outlined,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 28,
                  ),
                  Text("DO YOU WANT TO LOGOUT?"),
                ],
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.cancel)),
                IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                      authInstance.signOut();

                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Logout Successfull")));
                    },
                    icon: const Icon(Icons.done))
              ],
            ));
  }

  Future<dynamic> _showAddressTypingBox(
      BuildContext context, var color, UserProfileScreenProvider provider) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Text(
                "UPDATE YOUR ADDRESS !",
                style: TextStyle(color: color),
              ),
              content: TextField(
                  controller: addressController,
                  style: TextStyle(color: color)),
              actions: [
                ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.green)),
                    onPressed: () async {
                      String userid = FirebaseAuth.instance.currentUser!.uid;
                      try {
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(userid)
                            .update({"address": addressController.text});
                        await provider.fetchData(context);
                      } on FirebaseException catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.message ?? "exception")));
                      }
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Update",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ));
  }
}
