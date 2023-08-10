import 'package:flutter/material.dart';

class DecorationConstants {
  static const Color themeColor = Color(0xff87c232);
  static Color kAppBarColor = Colors.white;
  static const Color kScaffoldBackgroundColor = Colors.white;
  static Color kGreySecondaryTextColor = const Color(0xFF9EA4B2);
  static const Color kThemeColor = Color(0xffCE3533);
  static const Color kThemeSecondaryColor = Color.fromARGB(255, 230, 128, 127);
  static Color kButtonColor = const Color(0xFF87C140);
  static Color kGreySecondaryColor = const Color(0xFFF3F9EA);
  static Color kRideTagColor = const Color(0xFF2673D5);
  static Color kDeliveryTagColor = const Color(0xFFD59B26);
  static Color kCorporateTagColor = const Color(0xFFD245B9);
  static const Color kEarningByCategoryCardColor = Color(0xFFF1F9F9);

  static Color kWideSectionBackgroundColor = const Color(0xFFF4F6FB);
  static Color kMessageGreyAreaColor = const Color(0xFFEBEEF3);
  static Color kChatMessageTextColor = const Color(0xFF3D4856);
  static Color kChatMessageIconColor = const Color(0xFF9EA4B2);
  static Color kMessageBubbleDividerColor = const Color(0xFFC2CADE);
  static const Color kTextFieldBackgroundColor = Color(0xFFF4F6FB);
  static const Color kDropShadowColor = Color(0xFF3E4958);
  static Color kMessageWhiteAreaColor = Colors.white;
  static const Color kPrimaryTextColor = Color(0xFF3E4958);
  static const Color kPrimaryIconsColor = Color(0xFF3E4958);
  static Color kButtonTextColor = Colors.white;
  static Color kBottomNavigationBarBackgroundColor = Colors.white;
  static Color kBottomNavigationBarTextColor = const Color(0xFF3D4856);
  static Color kRedColor = const Color(0xFFD44B3B);
  static Color kOrderChatGreyColor = const Color(0xFF8E8E93);
  static const Color kChatFieldBackgroundColor = Color(0xFFF6F6F6);

  static double kChatBubbleBorderRadius = 10;
  static double kMessageBubbleMargin = 12;
  static int kBotLoadingTimerDuration = 5000;
  static int kWidgetVisibleDuration = 1000;
  static int kChatBubbleAnimationDuration = 200;
  static const double kInitScreenHorizontalPadding = 20;
  static const double kInitScreenVerticalPadding = 10;
  static double kWideGreySectionVerticalPadding = 5;
  static double kWideButtonBorderRadius = 6;
  static double kTextFieldBorderRadius = 6;
  static double kChatFieldBorderRadius = 25;
  static double kTextFieldVerticalContentPadding = 13;
  static double kTextFieldHorizontalContentPadding = 13;
  static double kWidgetPadding = 5;
  static double kWidgetExtraPadding = 12;
  static double kWidgetDistanceHeight = 0.03;
  static double kWidgetDistanceChatHeight = 0.01;
  static double kWidgetSecondaryDistanceHeight = kWidgetDistanceHeight - 0.01;
  static double kWidgetThirdDistanceHeight = kWidgetDistanceHeight - 0.015;
  static double kWidgetFourthDistanceHeight = kWidgetDistanceHeight - 0.02;
  static EdgeInsets kChatBubbleMessagePadding =
      const EdgeInsets.only(top: 5, left: 8, right: 5, bottom: 5);
  static double kChatBubbleMessageVerticalDistance = 0.01;
  static double kMessageFunctionHeight = 30;
  static double kOfferBoxBorderRadius = 6;
  static int kMessageLoadingDuration = 700;
  static double kBottomModalSheetBorderRadius = 12;
  static double kDialogBoxBorderRadius = 8;

  static const String iconsPath = 'assets/icons/';
  static const String navBarIconsPath = 'assets/icons/nav_bar_icons/';
  static const String orderChatIconsPath = 'assets/icons/newChatUi/';
  static const String animationPath = 'assets/animations/';
  static const String imagePath = 'assets/images/';
  static const String drawerIconsPath = '${iconsPath}drawerIcons/';
  static const String chatIconsPath = '${iconsPath}chatScreenIcons/';

  static List<BoxShadow> dropShadow = [
    const BoxShadow(
      color: kDropShadowColor,
      blurRadius: 6,
      offset: Offset(0, 3),
    ),
  ];

  static LinearGradient linearGradient = const LinearGradient(
    colors: [
      kThemeColor,
      kThemeSecondaryColor,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static BoxDecoration containerDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    color: Colors.white,
    // boxShadow: [
    //   BoxShadow(
    //     color: DecorationConstants.kDropShadowColor.withOpacity(0.3),
    //     blurRadius: 2,
    //     offset: const Offset(0, 2),
    //   ),
    // ],
  );
}
