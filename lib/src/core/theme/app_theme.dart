// lib/core/theme/app_theme.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  AppTheme._();

  static const Color primaryColor = Color(0xFF0D47A1);
  static const Color primaryLight = Color(0xFF1565C0);
  static const Color primaryDark = Color(0xFF0A3880);
  static const Color accentColor = Color(0xFF1976D2);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color surfaceColor = Color(0xFFF5F7FA);
  static const Color textColor = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF616161);
  static const Color dividerColor = Color(0xFFE0E0E0);
  static const Color errorColor = Color(0xFFD32F2F);
  static const Color successColor = Color(0xFF388E3C);
  static const Color cardColor = Color(0xFFFFFFFF);

  static const Color darkBackground = Color(0xFF0D1117);
  static const Color darkSurface = Color(0xFF161B22);
  static const Color darkCard = Color(0xFF21262D);
  static const Color darkText = Color(0xFFE6EDF3);
  static const Color darkTextSecondary = Color(0xFF8B949E);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'Roboto',
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      onPrimary: Colors.white,
      secondary: accentColor,
      onSecondary: Colors.white,
      surface: backgroundColor,
      onSurface: textColor,
      error: errorColor,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
<<<<<<< HEAD
        fontSize: 20,
=======
        fontSize: 20.sp,
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
        color: Colors.white,
      ),
    ),
    cardTheme: CardThemeData(
      color: cardColor,
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        minimumSize: Size(double.infinity, 52.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        textStyle: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
<<<<<<< HEAD
          fontSize: 16,
=======
          fontSize: 16.sp,
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
          letterSpacing: 0.5,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: const BorderSide(color: primaryColor, width: 1.5),
        minimumSize: Size(double.infinity, 52.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        textStyle: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
<<<<<<< HEAD
          fontSize: 16,
=======
          fontSize: 16.sp,
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
        textStyle: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
<<<<<<< HEAD
          fontSize: 14,
=======
          fontSize: 14.sp,
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceColor,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: dividerColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: dividerColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: errorColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: errorColor, width: 2),
      ),
      labelStyle: TextStyle(
        color: textSecondary,
<<<<<<< HEAD
        fontSize: 14,
=======
        fontSize: 14.sp,
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
        fontFamily: 'Roboto',
      ),
      hintStyle: TextStyle(
        color: textSecondary,
<<<<<<< HEAD
        fontSize: 14,
=======
        fontSize: 14.sp,
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
        fontFamily: 'Roboto',
      ),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
<<<<<<< HEAD
        fontSize: 32,
=======
        fontSize: 32.sp,
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
        fontWeight: FontWeight.w300,
        color: textColor,
        fontFamily: 'Roboto',
      ),
      displayMedium: TextStyle(
<<<<<<< HEAD
        fontSize: 28,
=======
        fontSize: 28.sp,
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
        fontWeight: FontWeight.w400,
        color: textColor,
        fontFamily: 'Roboto',
      ),
      headlineLarge: TextStyle(
<<<<<<< HEAD
        fontSize: 24,
=======
        fontSize: 24.sp,
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
        fontWeight: FontWeight.w500,
        color: textColor,
        fontFamily: 'Roboto',
      ),
      headlineMedium: TextStyle(
<<<<<<< HEAD
        fontSize: 20,
=======
        fontSize: 20.sp,
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
        fontWeight: FontWeight.w500,
        color: textColor,
        fontFamily: 'Roboto',
      ),
      headlineSmall: TextStyle(
<<<<<<< HEAD
        fontSize: 18,
=======
        fontSize: 18.sp,
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
        fontWeight: FontWeight.w500,
        color: textColor,
        fontFamily: 'Roboto',
      ),
      titleLarge: TextStyle(
<<<<<<< HEAD
        fontSize: 16,
=======
        fontSize: 16.sp,
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
        fontWeight: FontWeight.w500,
        color: textColor,
        fontFamily: 'Roboto',
      ),
      titleMedium: TextStyle(
<<<<<<< HEAD
        fontSize: 14,
=======
        fontSize: 14.sp,
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
        fontWeight: FontWeight.w500,
        color: textColor,
        fontFamily: 'Roboto',
      ),
      bodyLarge: TextStyle(
<<<<<<< HEAD
        fontSize: 16,
=======
        fontSize: 16.sp,
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
        fontWeight: FontWeight.w400,
        color: textColor,
        fontFamily: 'Roboto',
      ),
      bodyMedium: TextStyle(
<<<<<<< HEAD
        fontSize: 14,
=======
        fontSize: 14.sp,
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
        fontWeight: FontWeight.w400,
        color: textColor,
        fontFamily: 'Roboto',
      ),
      bodySmall: TextStyle(
<<<<<<< HEAD
        fontSize: 12,
=======
        fontSize: 12.sp,
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
        fontWeight: FontWeight.w400,
        color: textSecondary,
        fontFamily: 'Roboto',
      ),
      labelLarge: TextStyle(
<<<<<<< HEAD
        fontSize: 14,
=======
        fontSize: 14.sp,
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
        fontWeight: FontWeight.w500,
        color: primaryColor,
        fontFamily: 'Roboto',
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: dividerColor,
      thickness: 1,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: backgroundColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: textSecondary,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: surfaceColor,
      selectedColor: primaryColor.withOpacity(0.15),
<<<<<<< HEAD
      labelStyle: TextStyle(fontSize: 12, fontFamily: 'Roboto'),
=======
      labelStyle: TextStyle(fontSize: 12.sp, fontFamily: 'Roboto'),
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
        side: const BorderSide(color: dividerColor),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: 'Roboto',
    colorScheme: const ColorScheme.dark(
      primary: primaryLight,
      onPrimary: Colors.white,
      secondary: accentColor,
      onSecondary: Colors.white,
      surface: darkSurface,
      onSurface: darkText,
      error: errorColor,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: darkBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: darkSurface,
      foregroundColor: darkText,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
<<<<<<< HEAD
        fontSize: 20,
=======
        fontSize: 20.sp,
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
        color: darkText,
      ),
    ),
    cardTheme: CardThemeData(
      color: darkCard,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryLight,
        foregroundColor: Colors.white,
        elevation: 0,
        minimumSize: Size(double.infinity, 52.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        textStyle: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
<<<<<<< HEAD
          fontSize: 16,
=======
          fontSize: 16.sp,
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkCard,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: darkText.withOpacity(0.2)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: darkText.withOpacity(0.15)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: primaryLight, width: 2),
      ),
<<<<<<< HEAD
      labelStyle: TextStyle(color: darkTextSecondary, fontSize: 14),
      hintStyle: TextStyle(color: darkTextSecondary, fontSize: 14),
=======
      labelStyle: TextStyle(color: darkTextSecondary, fontSize: 14.sp),
      hintStyle: TextStyle(color: darkTextSecondary, fontSize: 14.sp),
>>>>>>> 5bdfc22ad600a67ce0671fc6ab71faf855003dde
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: darkSurface,
      selectedItemColor: primaryLight,
      unselectedItemColor: darkTextSecondary,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),
  );
}