import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData appMainTheme = ThemeData(
    scaffoldBackgroundColor: appBackgroundColor,
    textTheme: TextTheme(
      titleLarge: GoogleFonts.firaSans(
        color: appPrimaryColor,
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.firaSans(
        color: appPrimaryColor,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: GoogleFonts.firaSans(
        color: appPrimaryColor,
        fontSize: 19,
        fontWeight: FontWeight.w400,
      ),
    ),

    progressIndicatorTheme: ProgressIndicatorThemeData(color: appPrimaryColor),
  );
}
