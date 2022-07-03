import 'package:corporatetransportapp/assets/custom_page_transition.dart';
import 'package:flutter/material.dart';

ThemeData customTheme = ThemeData(
  primaryColor: const Color(0xff107189),
  primaryColorLight: const Color(0xff50a0b9),
  primaryColorDark: const Color(0xff00465c),
  fontFamily: "Cardo",
  canvasColor: const Color(0xfff8f8f8),
  primarySwatch: const MaterialColor(
    0xFF107189, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xff0e667b), //10%
      100: Color(0xff0d5a6e), //20%
      200: Color(0xff0b4f60), //30%
      300: Color(0xff0a4452), //40%
      400: Color(0xff083945), //50%
      500: Color(0xff062d37), //60%
      600: Color(0xff052229), //70%
      700: Color(0xff03171b), //80%
      800: Color(0xff020b0e), //90%
      900: Color(0xff000000), //100%
    },
  ),
  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CustomPageTransitionBuilder(),
      TargetPlatform.iOS: CustomPageTransitionBuilder(),
    },
  ),
   inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 15.0,
      vertical: 15.0,
    ),
    fillColor: Colors.white,
    labelStyle: TextStyle(
      color: Colors.black.withOpacity(0.6),
      fontSize: 16.0,
    ),
    hintStyle: TextStyle(
      color: Colors.black.withOpacity(0.6),
      fontSize: 16.0,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        10.0,
      ),
      borderSide: BorderSide(
        color: Colors.grey[300]!,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        10.0,
      ),
      borderSide: BorderSide(
        color: Colors.grey[300]!,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        10.0,
      ),
      borderSide: BorderSide(
        color: Colors.grey[300]!,
      ),
    ),
  ),
);
