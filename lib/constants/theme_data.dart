import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      textTheme: GoogleFonts.poppinsTextTheme(),
      splashColor: isDarkTheme ? const Color(0xff001f54) : Colors.black,
      scaffoldBackgroundColor: isDarkTheme
          ? const Color(0xFF00001a)
          : const Color.fromARGB(255, 212, 202, 202),
      primaryColor: isDarkTheme ? Colors.blue : Colors.green,
      colorScheme: ThemeData().colorScheme.copyWith(
            secondary: isDarkTheme
                ? const Color.fromARGB(255, 30, 62, 248)
                : const Color(0xFFE8FDFD),
            brightness: isDarkTheme ? Brightness.dark : Brightness.light,
          ),
      cardColor: isDarkTheme
          ? const Color.fromARGB(255, 26, 31, 85)
          : const Color(0xFFF2FDFD),
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme
              ? const ColorScheme.dark()
              : const ColorScheme.light()),
    );
  }
}
