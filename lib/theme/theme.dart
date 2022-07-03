import 'package:flutter/material.dart';
import 'package:l_movie/theme/colors.dart';

final ThemeData defaultTheme = ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: backgroundColor,
  fontFamily: 'Muli',
  appBarTheme: const AppBarTheme(
    color: backgroundColor,
    iconTheme: IconThemeData(color: accentLightColor),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: accentLightColor,
    disabledColor: primaryColorDark,
  ),
);
