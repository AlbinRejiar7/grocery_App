import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/constants/theme_data.dart';
import 'package:grocery_app/controller/cart_controller.dart';
import 'package:grocery_app/controller/orders_controller.dart';
import 'package:grocery_app/controller/product_controller.dart';
import 'package:grocery_app/controller/user_profile_controller.dart';
import 'package:grocery_app/firebase_options.dart';
import 'package:grocery_app/view/category_screen/category_detail_screen.dart';
import 'package:grocery_app/view/home_screen.dart';
import 'package:grocery_app/view/inner_screens.dart/product_detail_screen.dart';
import 'package:grocery_app/view/splash_screen.dart';
import 'package:provider/provider.dart';

import 'controller/dark_theme_provider.dart';
import 'view/auth/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => DarkThemeProvider()),
    ChangeNotifierProvider(create: (_) => ProductController()),
    ChangeNotifierProvider(create: (_) => CartController()),
    ChangeNotifierProvider(create: (_) => UserProfileScreenProvider()),
    ChangeNotifierProvider(create: (_) => OrdersController()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth authInstance = FirebaseAuth.instance;
    return Consumer<DarkThemeProvider>(
        builder: (context, themeProvider, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'grocery App',
        theme: Styles.themeData(themeProvider.getDarkTheme, context),
        home: authInstance.currentUser == null
            ? const LoginPage()
            : const SplashScreen(),
        routes: {
          "productdetails": (context) => const ProductdetailScreen(),
          "categorydetailsscreen": (context) => const CategorydetailScreen(),
          "homescreen": (context) => const HomeScreen(),
        },
      );
    });
  }
}
