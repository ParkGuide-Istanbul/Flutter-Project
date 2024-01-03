import 'package:flutter/material.dart';

class CustomColors {
  static Color darkPurple() => Color.fromARGB(255, 123, 31, 162);
  static Color middlePurple() => Color.fromARGB(255, 149, 44, 231);
  static Color lightPurple() => Color.fromARGB(255, 186, 104, 200);
  static Color customGrey() => Color.fromARGB(255, 237, 237, 237);
  static Color darkGrey() => Color.fromARGB(255, 205, 205, 205);
}

class CustomTextStyles {
  static TextStyle drawerMenuTextStyle({bool? setPurple}) => setPurple == null
      ? TextStyle(
          color: CustomColors.middlePurple(),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        )
      : setPurple == true
          ? TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )
          : TextStyle(
              color: CustomColors.middlePurple(),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            );
  static labelTextStyle() => TextStyle(
        color: CustomColors.darkPurple(),
        fontWeight: FontWeight.bold,
        fontSize: 20,
      );
}
