import 'package:flutter/material.dart';

import '../ui_config/decoration_constants.dart';

final theme = ThemeData(
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: DecorationConstants.kBottomNavigationBarBackgroundColor,
    elevation: 5,
    enableFeedback: false,
    //landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
  ),
  buttonTheme: ButtonThemeData(buttonColor: DecorationConstants.kButtonColor),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: DecorationConstants.kButtonColor,
      shape: const StadiumBorder(),
      side: const BorderSide(
        color: DecorationConstants.kThemeColor,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    backgroundColor: DecorationConstants.kButtonColor,
  )),
  primaryColor: DecorationConstants.themeColor,
  appBarTheme: const AppBarTheme(elevation: 0),
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'Gilroy',
  textTheme: const TextTheme(
    displayLarge:
        TextStyle(fontSize: 38.0, color: DecorationConstants.kPrimaryTextColor),
    displayMedium:
        TextStyle(fontSize: 24.0, color: DecorationConstants.kPrimaryTextColor),
    displaySmall:
        TextStyle(fontSize: 22.0, color: DecorationConstants.kPrimaryTextColor),
    headlineMedium:
        TextStyle(fontSize: 18, color: DecorationConstants.kPrimaryTextColor),
    headlineSmall:
        TextStyle(fontSize: 16, color: DecorationConstants.kPrimaryTextColor),
    titleLarge:
        TextStyle(fontSize: 14.0, color: DecorationConstants.kPrimaryTextColor),
    bodyLarge: TextStyle(fontSize: 12.0),
    bodyMedium: TextStyle(fontSize: 10.0),
    labelLarge: TextStyle(fontSize: 12),
    // caption: TextStyle(fontSize: 20),
    labelSmall: TextStyle(
        fontSize: 16,
        letterSpacing: 0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        height: 1.5),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: DecorationConstants.kTextFieldBackgroundColor,
    hintStyle: TextStyle(
      fontSize: 14,
      color: DecorationConstants.kGreySecondaryTextColor,
    ),
    //labelStyle: TextStyle(color: themeColor),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        DecorationConstants.kTextFieldBorderRadius,
      ),
      borderSide: const BorderSide(
        width: 0,
        style: BorderStyle.none,
      ),
    ),
    // focusedBorder: InputBorder.none,
    // enabledBorder: InputBorder.none,
    // errorBorder: InputBorder.none,
    // disabledBorder: InputBorder.none,

    // focusedBorder:
    //     UnderlineInputBorder(borderSide: BorderSide(color: themeColor))
  ),
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
  }),
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(secondary: Colors.grey[300])
      .copyWith(background: Colors.white),
);
