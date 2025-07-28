import 'package:flutter/material.dart';
import 'package:shartflix/core/theme/app_colors.dart';

class AppStyles {
  static const String euclidCircularA = 'Euclid Circular A';
  static const String montserrat = 'Montserrat';

  static const TextStyle bodyText1 = TextStyle(
    fontFamily: euclidCircularA,
    fontWeight: FontWeight.normal,
    fontSize: 16,
    color: AppColors.white,
  );

  static const TextStyle loginTitleStyle = TextStyle(
    fontFamily: euclidCircularA,
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color: AppColors.white,
  );

  static const TextStyle montserratRegular = TextStyle(
    fontFamily: montserrat,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle montserratMedium = TextStyle(
    fontFamily: montserrat,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle euclidCircularARegular = TextStyle(
    fontFamily: euclidCircularA,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle euclidCircularAMedium = TextStyle(
    fontFamily: euclidCircularA,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle euclidCircularABold = TextStyle(
    fontFamily: euclidCircularA,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle montserratBold = TextStyle(
    fontFamily: montserrat,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle montserratBlack = TextStyle(
    fontFamily: montserrat,
    fontWeight: FontWeight.w900,
  );

  static const TextStyle limitedOfferTitle = TextStyle(
    fontFamily: euclidCircularA,
    color: Colors.white,
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle tokenOriginalAmount = TextStyle(
    fontFamily: euclidCircularA,
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.lineThrough,
    decorationColor: Colors.white,
    decorationThickness: 1.5,
  );

  static ThemeData appTheme() {
    return ThemeData(
      primarySwatch: Colors.red,
      fontFamily: euclidCircularA,
      textTheme: const TextTheme(),
    );
  }
}
