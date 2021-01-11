import 'package:flutter/material.dart';
import 'package:vizable/common/const/barrel.dart';

class THEME {
  static final theme = ThemeData(
    scaffoldBackgroundColor: COLOR.white,
    primarySwatch: Colors.red,
    brightness: Brightness.dark,
    backgroundColor: COLOR.white,
    accentColor: COLOR.blue,
    accentIconTheme: IconThemeData(color: COLOR.blue),
    appBarTheme: AppBarTheme(
        elevation: 0,
        textTheme: TextTheme(
            subtitle1: TextStyle(
                color: COLOR.grey_dark,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                fontSize: 20)),
        actionsIconTheme: IconThemeData(color: COLOR.grey_dark, size: 24)),
  );
}
