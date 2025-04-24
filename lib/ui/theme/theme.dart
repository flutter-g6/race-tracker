import 'package:flutter/material.dart';

class RTColors {
  // Define colors here
  static Color primary = const Color(0xFF9D3FE7);
  static Color secondary = const Color(0xFFD5D4FF);

  static Color backgroundAccent = const Color(0xFFEDEDED);
  static Color bgColor = const Color(0xFFF2F5FF);

  static Color greyLight = const Color(0xFFE2E2E2);
  static Color white = Colors.white;
  static Color black = Colors.black;

  static Color error = const Color(0xFFEE3B2B);
  static Color success =const Color(0xFF82DD55);
  static Color warning = const Color(0xFFFAC752);

  static Color get backGroundColor {
    return RTColors.bgColor;
  }

  static Color get disabled {
    return RTColors.greyLight;
  }
}

class RTTextStyles {
  // Define text styles here
  static TextStyle heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
  );

  static TextStyle subHeading = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  static TextStyle body = TextStyle(fontSize: 16, fontWeight: FontWeight.w400);

  static TextStyle label = TextStyle(fontSize: 14, fontWeight: FontWeight.w400);

  static TextStyle text = TextStyle(fontSize: 12, fontWeight: FontWeight.w400);

  static TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static TextStyle smallButton = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
}

class RTSpacings {
  // Define spacings here
  static const double s = 12;
  static const double m = 16;
  static const double l = 24;
  static const double xl = 32;
  static const double xxl = 40;

  static const double radius = 16;
  static const double radiusLarge = 24;
}

class RTSizes {
  // Define sizes here
  static const double smallIcon = 20;
  static const double icon = 24;
}

ThemeData appTheme = ThemeData(fontFamily: 'Poppins');
