// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'light_color.dart';

class AppTheme {
  const AppTheme();
  static ThemeData lightTheme = ThemeData.light().copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
      },
    ),
    backgroundColor: LightColor.background,
    scaffoldBackgroundColor: LightColor.background,
    primaryColor: LightColor.purple,
    primaryColorDark: LightColor.darker,
    primaryColorLight: LightColor.brighter,
    cardTheme: const CardTheme(color: LightColor.background),
    iconTheme: const IconThemeData(color: LightColor.lightblack),
    bottomAppBarColor: LightColor.background,
    dividerColor: LightColor.lightGrey,
    colorScheme: const ColorScheme(
        primary: LightColor.purple,
        secondary: LightColor.lightBlue,
        surface: LightColor.background,
        background: LightColor.background,
        error: Colors.red,
        onPrimary: LightColor.darker,
        onSecondary: LightColor.background,
        onSurface: LightColor.darker,
        onBackground: LightColor.titleTextColor,
        onError: LightColor.titleTextColor,
        brightness: Brightness.dark),
  );

  static TextStyle titleStyle = const TextStyle(
      fontFamily: 'Poppins', color: LightColor.titleTextColor, fontSize: 16);
  static TextStyle subTitleStyle = const TextStyle(
      fontFamily: 'Poppins', color: LightColor.subTitleTextColor, fontSize: 12);

  static TextStyle h1Style = const TextStyle(
      fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.bold);
  static TextStyle h2Style =
      const TextStyle(fontFamily: 'Poppins', fontSize: 22);
  static TextStyle h3Style =
      const TextStyle(fontFamily: 'Poppins', fontSize: 20);
  static TextStyle h4Style =
      const TextStyle(fontFamily: 'Poppins', fontSize: 18);
  static TextStyle h5Style =
      const TextStyle(fontFamily: 'Poppins', fontSize: 16);
  static TextStyle h6Style =
      const TextStyle(fontFamily: 'Poppins', fontSize: 14);
}
