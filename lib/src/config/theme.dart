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
      primary: DecorationConstants.kButtonColor,
      shape: StadiumBorder(),
      side: BorderSide(
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
    primary: DecorationConstants.kButtonColor,
  )),
  primaryColor: DecorationConstants.themeColor,
  appBarTheme: const AppBarTheme(elevation: 0),
  scaffoldBackgroundColor: Colors.white,
  backgroundColor: Colors.white,
  fontFamily: 'Proxima Nova',
  textTheme: TextTheme(
    headline1:
        TextStyle(fontSize: 38.0, color: DecorationConstants.kPrimaryTextColor),
    headline2:
        TextStyle(fontSize: 24.0, color: DecorationConstants.kPrimaryTextColor),
    headline3:
        TextStyle(fontSize: 22.0, color: DecorationConstants.kPrimaryTextColor),
    headline4:
        TextStyle(fontSize: 18, color: DecorationConstants.kPrimaryTextColor),
    headline5:
        TextStyle(fontSize: 16, color: DecorationConstants.kPrimaryTextColor),
    headline6:
        TextStyle(fontSize: 14.0, color: DecorationConstants.kPrimaryTextColor),
    bodyText1: const TextStyle(fontSize: 12.0),
    bodyText2: const TextStyle(fontSize: 10.0),
    button: const TextStyle(fontSize: 12),
    // caption: TextStyle(fontSize: 20),
    overline: const TextStyle(
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
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.grey[300]),
);
