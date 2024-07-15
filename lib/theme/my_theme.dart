import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTheme {
  static Color primary = const Color(0xFF043D7C);
  static Color blackColor = const Color(0xFF000000);
  static Color whiteColor = const Color(0xFFFFFFFF);
  static Color yellowColor =  Colors.yellow;

  static ThemeData lightTheme = ThemeData(
      appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: blackColor),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0.0),
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          color: blackColor,
          fontWeight: FontWeight.w500,
          fontSize: 18.sp,
        ),
        bodyMedium: TextStyle(
          color: blackColor,
          fontWeight: FontWeight.w400,
          fontSize: 16.sp,
        ),
        bodySmall: TextStyle(
          color: const Color(0x9906004E),
          fontSize: 14.sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w300,
        ),
          displaySmall: const TextStyle(fontSize: 12),
        displayLarge: const TextStyle(fontSize: 14),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: primary,
          type: BottomNavigationBarType.shifting,
          unselectedItemColor: whiteColor,
          selectedItemColor: blackColor,
          selectedLabelStyle: TextStyle(color: blackColor),
          selectedIconTheme: IconThemeData(color: blackColor)));

}
