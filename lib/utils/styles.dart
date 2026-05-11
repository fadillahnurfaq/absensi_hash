import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppColors {
  AppColors._();
  static const Color primary = Color(0xffc22838);
  static const Color white = Color(0xFFFFFFFF);
  static const Color whiteGrey = Color(0xFFF5f5f5);
  static const Color black = Color(0xFF101010);
  static const Color gray = Color(0xFF292929);
  static const Color gray25 = Color(0xFFfcfcfd);
  static const Color gray50 = Color(0xFFf9fafb);
  static const Color gray100 = Color(0xFFF2F4F7);
  static const Color gray200 = Color(0xFFeaecf0);
  static const Color gray300 = Color(0xFFd0d5dd);
  static const Color gray400 = Color(0xFF98a2b3);
  static const Color gray500 = Color(0xFF667085);
  static const Color gray600 = Color(0xFF475467);
  static const Color gray700 = Color(0xFF344054);
  static const Color gray800 = Color(0xFF1d2939);
  static const Color gray900 = Color(0xFF101828);
  static const Color red = Color(0xFFFF1212);
}

class AppTextStyles {
  AppTextStyles._();

  static double get headlineLargeSize => 20.sp;
  static double get headlineMediumSize => 18.sp;
  static double get headlineSmallSize => 16.sp;
  static double get bodyLargeSize => 14.sp;
  static double get bodySize => 12.sp;
  static double get bodySmallSize => 10.sp;
  static double get captionSize => 8.sp;

  static TextStyle get headlineLarge => TextStyle(fontSize: headlineLargeSize, color: Colors.black);
  static TextStyle get headlineMedium => headlineLarge.copyWith(fontSize: headlineMediumSize);
  static TextStyle get headlineSmall => headlineLarge.copyWith(fontSize: headlineSmallSize);
  static TextStyle get bodyLarge => headlineLarge.copyWith(fontSize: bodyLargeSize);
  static TextStyle get body => headlineLarge.copyWith(fontSize: bodySize);
  static TextStyle get bodySmall => headlineLarge.copyWith(fontSize: bodySmallSize);
  static TextStyle get caption => headlineLarge.copyWith(fontSize: captionSize);

  static FontWeight light = FontWeight.w300;
  static FontWeight regular = FontWeight.w400;
  static FontWeight medium = FontWeight.w500;
  static FontWeight semiBold = FontWeight.w600;
  static FontWeight bold = FontWeight.w700;
  static FontWeight extraBold = FontWeight.w800;
  static FontWeight black = FontWeight.w900;
}