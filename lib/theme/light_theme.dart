import 'package:flutter/material.dart';

ThemeData light({Color color = const Color(0xFF29abe2)}) => ThemeData(
      fontFamily: 'Roboto',
      primaryColor: Colors
          .green, //Colors.black,//Colors.deepOrange,//Colors.yellow.shade400, //Colors.deepOrange,   //color
      secondaryHeaderColor: Color(0xFF29abe2),
      disabledColor: Color(0xFFBABFC4),
      //disabledColor: Color(0xff1167b1),
      backgroundColor: Color(0xff1167b1) /*(0xFFF3F3F3)*/,
      errorColor: Color(0xFFE84D4F),
      brightness: Brightness.light,
      hintColor: Color(0xFF9F9F9F),
      dividerColor: Color(0xff1167b1),
      //cardColor1: Color(0xff1167b1),

      cardColor: Colors.white,
      colorScheme: ColorScheme.light(primary: color, secondary: color),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: color)),
    );
