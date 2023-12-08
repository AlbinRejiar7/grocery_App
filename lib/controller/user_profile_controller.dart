// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/constants/firebase_const.dart';

class UserProfileScreenProvider with ChangeNotifier {
  String? email;
  String? username;
  String? address;
  String? imageUrl;
  Future<void> fetchData(BuildContext context) async {
    User? user = authInstance.currentUser;
    try {
      String userId = user!.uid;
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      email = userDoc.get("email");
      username = userDoc.get("name");
      address = userDoc.get("address");
      imageUrl = userDoc.get("profileimage");
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
    }
    notifyListeners();
  }
}
