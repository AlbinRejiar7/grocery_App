// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery_app/constants/app_constants.dart';
import 'package:grocery_app/constants/firebase_const.dart';
import 'package:grocery_app/globalmethod/pagerouter.dart';
import 'package:grocery_app/view/auth/login_screen.dart';
import 'package:grocery_app/widget/app_text_form_field.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  FocusNode confirmFocusNode = FocusNode();

  bool isObscure = true;
  bool isConfirmPasswordObscure = true;
  bool isLoading = false;
  File? pickedImage;
  String imageUrl = "";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              height: size.height * 0.18,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.lightBlue,
                    Colors.blue,
                    Color.fromARGB(255, 1, 49, 88),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        'Register',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        'Create your account',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GestureDetector(
                onTap: () {
                  pickImageFromGallery();
                },
                child: Column(
                  children: [
                    pickedImage != null
                        ? CircleAvatar(
                            backgroundImage: FileImage(pickedImage!),
                            radius: 70,
                          )
                        : CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.deepOrangeAccent,
                          ),
                    Icon(Icons.add_a_photo)
                  ],
                )),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AppTextFormField(
                    labelText: 'Name',
                    autofocus: true,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => _formKey.currentState?.validate(),
                    validator: (value) {
                      return value!.isEmpty
                          ? 'Please, Enter Name '
                          : value.length < 4
                              ? 'Invalid Name'
                              : null;
                    },
                    controller: nameController,
                  ),
                  AppTextFormField(
                    labelText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onChanged: (_) => _formKey.currentState?.validate(),
                    validator: (value) {
                      return value!.isEmpty
                          ? 'Please, Enter Email Address'
                          : AppConstants.emailRegex.hasMatch(value)
                              ? null
                              : 'Invalid Email Address';
                    },
                    controller: emailController,
                  ),
                  AppTextFormField(
                    labelText: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,
                    onChanged: (_) => _formKey.currentState?.validate(),
                    validator: (value) {
                      return value!.isEmpty
                          ? 'Please, Enter Password'
                          : AppConstants.passwordRegex.hasMatch(value)
                              ? null
                              : 'Password must Contain symbol,capital letter,small letter\nnumber and must greater than 7';
                    },
                    controller: passwordController,
                    obscureText: isObscure,
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                      FocusScope.of(context).requestFocus(confirmFocusNode);
                    },
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Focus(
                        /// If false,
                        ///
                        /// disable focus for all of this node's descendants
                        descendantsAreFocusable: false,

                        /// If false,
                        ///
                        /// make this widget's descendants un-traversable.
                        // descendantsAreTraversable: false,
                        child: IconButton(
                          onPressed: () => setState(() {
                            isObscure = !isObscure;
                          }),
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(
                              const Size(48, 48),
                            ),
                          ),
                          icon: Icon(
                            isObscure
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  AppTextFormField(
                    labelText: 'Confirm Password',
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    focusNode: confirmFocusNode,
                    onChanged: (value) {
                      _formKey.currentState?.validate();
                    },
                    validator: (value) {
                      return value!.isEmpty
                          ? 'Please, Re-Enter Password'
                          : AppConstants.passwordRegex.hasMatch(value)
                              ? passwordController.text ==
                                      confirmPasswordController.text
                                  ? null
                                  : 'Password not matched!'
                              : 'Password not matched!';
                    },
                    controller: confirmPasswordController,
                    obscureText: isConfirmPasswordObscure,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Focus(
                        /// If false,
                        ///
                        /// disable focus for all of this node's descendants.
                        descendantsAreFocusable: false,

                        /// If false,
                        ///
                        /// make this widget's descendants un-traversable.
                        // descendantsAreTraversable: false,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              isConfirmPasswordObscure =
                                  !isConfirmPasswordObscure;
                            });
                          },
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(
                              const Size(48, 48),
                            ),
                          ),
                          icon: Icon(
                            isConfirmPasswordObscure
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  AppTextFormField(
                    labelText: 'Shipping Address',
                    validator: (value) {
                      return value!.isEmpty ? "Enter Your Address" : null;
                    },
                    autofocus: true,
                    keyboardType: TextInputType.streetAddress,
                    textInputAction: TextInputAction.done,
                    controller: addressController,
                  ),
                  isLoading
                      ? SpinKitCircle(
                          color: Colors.blueAccent,
                        )
                      : FilledButton(
                          onPressed: _formKey.currentState?.validate() ?? false
                              ? () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  try {
                                    await authInstance
                                        .createUserWithEmailAndPassword(
                                            email: emailController.text
                                                .toLowerCase()
                                                .trim(),
                                            password: passwordController.text);
                                    final uid = authInstance.currentUser!.uid;

                                    final ref = FirebaseStorage.instance
                                        .ref()
                                        .child("profileimage")
                                        .child("$uid.jpg");
                                    if (pickedImage != null) {
                                      await ref.putFile(pickedImage!);
                                      imageUrl = await ref.getDownloadURL();
                                    }

                                    await FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(uid)
                                        .set({
                                      "id": uid,
                                      "name": nameController.text,
                                      "email":
                                          emailController.text.toLowerCase(),
                                      "address": addressController.text,
                                      "userWish": [],
                                      "userCart": [],
                                      "profileimage": imageUrl,
                                      "createdAt": Timestamp.now()
                                    });

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Registration Complete!'),
                                      ),
                                    );
                                    Future.delayed(const Duration(seconds: 1));
                                    Navigator.of(context).push(
                                        buildPageRouteBuilder(LoginPage()));
                                  } on FirebaseAuthException catch (error) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('ERROR OCCURED $error '),
                                      ),
                                    );
                                    setState(() {
                                      isLoading = false;
                                    });
                                  } catch (error) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('ERROR OCCURED $error '),
                                      ),
                                    );
                                    setState(() {
                                      isLoading = false;
                                    });
                                  } finally {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }

                                  nameController.clear();
                                  emailController.clear();
                                  passwordController.clear();
                                  confirmPasswordController.clear();
                                  addressController.clear();
                                }
                              : null,
                          style: const ButtonStyle().copyWith(
                            backgroundColor: MaterialStateProperty.all(
                              _formKey.currentState?.validate() ?? false
                                  ? null
                                  : Colors.grey.shade300,
                            ),
                          ),
                          child: const Text('Register'),
                        ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'I have an account?',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: Theme.of(context).textButtonTheme.style,
                    child: Text(
                      'Login',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImageFromGallery() async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        pickedImage = File(pickedFile.path);
      } else {}
    });
  }
}
