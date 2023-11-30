import 'package:flutter/material.dart';
import 'package:grocery_app/constants/theme_data.dart';
import 'package:grocery_app/controller/dark_theme_controller.dart';
import 'package:grocery_app/view/auth/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ThemeController()),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeController themeController = ThemeController();
  void getCurrentTheme() async {
    themeController.setDarkTheme =
        await themeController.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = Provider.of<ThemeController>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'grocery App',
      theme: Styles.themeData(themeController.getDarkTheme, context),
      home: LoginPage(), //BottomNavScreen() ,
    );
  }
}
