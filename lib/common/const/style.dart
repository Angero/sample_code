import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vizable/common/const/barrel.dart';

class STYLE {
  static const _BOLD = 'Bold';
  static const _REGULAR = 'Regular';
  static const _LIGHT = 'Light';

  static final TextStyle b_24_700 = _textStyle(_BOLD, 24.0, FontWeight.w700);
  static final TextStyle b_18_700 = _textStyle(_BOLD, 18.0, FontWeight.w700);
  static final TextStyle b_16_700 = _textStyle(_BOLD, 16.0, FontWeight.w700);
  static final TextStyle b_15_700 = _textStyle(_BOLD, 15.0, FontWeight.w700);
  static final TextStyle b_14_700 = _textStyle(_BOLD, 14.0, FontWeight.w700);
  static final TextStyle b_12_700 = _textStyle(_BOLD, 12.0, FontWeight.w700);
  static final TextStyle r_48_400 = _textStyle(_REGULAR, 48.0, FontWeight.w400);
  static final TextStyle r_34_400 = _textStyle(_REGULAR, 34.0, FontWeight.w400);
  static final TextStyle r_20_400 = _textStyle(_REGULAR, 20.0, FontWeight.w400);
  static final TextStyle r_18_400 = _textStyle(_REGULAR, 18.0, FontWeight.w400);
  static final TextStyle r_17_400 = _textStyle(_REGULAR, 17.0, FontWeight.w400);
  static final TextStyle r_16_400 = _textStyle(_REGULAR, 16.0, FontWeight.w400);
  static final TextStyle r_15_400 = _textStyle(_REGULAR, 15.0, FontWeight.w400);
  static final TextStyle r_14_400 = _textStyle(_REGULAR, 14.0, FontWeight.w400);
  static final TextStyle r_12_400 = _textStyle(_REGULAR, 12.0, FontWeight.w400);
  static final TextStyle r_11_400 = _textStyle(_REGULAR, 11.0, FontWeight.w400);
  static final TextStyle r_9_400 = _textStyle(_REGULAR, 9.0, FontWeight.w400);
  static final TextStyle l_60_300 = _textStyle(_LIGHT, 60.0, FontWeight.w300);

  static TextStyle _textStyle(
      [String fontSuffix = _REGULAR,
      double fontSize = 12.0,
      FontWeight fontWeight = FontWeight.w400]) {
    return TextStyle(
      fontFamily: 'Roboto' + ' ' + fontSuffix,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: COLOR.grey_dark,
    );
  }
}
