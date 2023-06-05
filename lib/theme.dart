import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CarRentalTheme {
  static TextTheme lightTextTheme = TextTheme(
    labelMedium: GoogleFonts.varelaRound(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Colors.blue,
    ),
    labelLarge: GoogleFonts.varelaRound(
      fontSize: 14.0,
      color: Colors.black,
    ),
    bodyLarge: GoogleFonts.varelaRound(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    displayLarge: GoogleFonts.varelaRound(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    displayMedium: GoogleFonts.varelaRound(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    displaySmall: GoogleFonts.varelaRound(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    titleLarge: GoogleFonts.varelaRound(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: GoogleFonts.varelaRound(
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      color: Colors.green[600],
    ),
    labelLarge: GoogleFonts.varelaRound(
      fontSize: 14.0,
      color: Colors.white,
    ),
    labelSmall: GoogleFonts.varelaRound(
      fontSize: 14.0,
      //fontWeight: FontWeight.w600,
      color: Colors.grey[500],
    ),
    bodyLarge: GoogleFonts.varelaRound(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    displayLarge: GoogleFonts.varelaRound(
      fontSize: 40.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    displayMedium: GoogleFonts.varelaRound(
      fontSize: 22.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    displaySmall: GoogleFonts.varelaRound(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    titleLarge: GoogleFonts.varelaRound(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  );

  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith(
          (states) {
            return Colors.black;
          },
        ),
      ),
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.blue,
      ),
      textTheme: lightTextTheme,
    );
  }

  static ThemeData dark() {
    return ThemeData(
        brightness: Brightness.dark,
        iconTheme: const IconThemeData(color: Colors.blue),
        appBarTheme: AppBarTheme(
          foregroundColor: Colors.white,
          backgroundColor: Colors.grey[900],
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
          backgroundColor: Colors.green,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.green,
        ),
        textTheme: darkTextTheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30))),
              minimumSize:
                  MaterialStateProperty.all(const Size(double.infinity, 56)),
              elevation: MaterialStateProperty.all(8),
              textStyle: MaterialStateProperty.all(GoogleFonts.varelaRound(
                  fontSize: 16.0, fontWeight: FontWeight.w600))),
        ));
  }
}
