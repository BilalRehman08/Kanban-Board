import 'package:flutter/material.dart';
import 'package:kanban_board_flutter/utils/colors.dart';

class AppTheme {
  static final darkTheme = ThemeData(
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: ColorUtils.whiteColor,
      ),
    ),
    primarySwatch: ColorUtils.secondaryColor,
    scaffoldBackgroundColor: ColorUtils.scaffoldBackgroundColor,
    appBarTheme: const AppBarTheme(
      color: ColorUtils.secondaryColor,
      iconTheme: IconThemeData(color: ColorUtils.secondaryColor),
    ),
  );

  static final lightTheme = ThemeData(
    primarySwatch: ColorUtils.lightPrimaryColor,
    scaffoldBackgroundColor: ColorUtils.lightBg,
    appBarTheme: AppBarTheme(
      color: Colors.orange[900],
      iconTheme: const IconThemeData(color: Colors.white),
    ),
  );
}
