import 'package:flutter/material.dart';

abstract class AppColors {
  static const lightBlue = MaterialColor(
    0xff3acbda,
    {
      50: Color(0xFFeaf9fb),
      100: Color(0xFFbfeef3),
      200: Color(0xFFbfeef3),
      300: Color(0xFF69d7e3),
      400: Color(0xFF3eccdb),
      500: Color(0xff3acbda),
      600: Color(0xFF24b2c1),
      700: Color(0xFF1c8b96),
      800: Color(0xFF14636b),
      900: Color(0xFF0c3b40),
    },
  );
  static const white = MaterialColor(
    0xFFECECEC,
    {
      50: Color(0xFFf6f6f6),
      100: Color(0xFFf4f4f4),
      200: Color(0xFFf2f2f2),
      300: Color(0xFFf0f0f0),
      400: Color(0xFFeeeeee),
      500: Color(0xFFECECEC),
      600: Color(0xFFe7e7e7),
      700: Color(0xFFbdbdbd),
      800: Color(0xFFa5a5a5),
      900: Color(0xFF8e8e8e),
    },
  );
  static const black = MaterialColor(
    0xFF191919,
    {
      50: Color(0xFF595959),
      100: Color(0xFF4d4d4d),
      200: Color(0xFF404040),
      300: Color(0xFF333333),
      400: Color(0xFF262626),
      500: Color(0xFF191919),
      600: Color(0xFF0d0d0d),
      700: Color(0xFF000000),
      800: Color(0xFF000000),
      900: Color(0xFF000000),
    },
  );
  static const blueGreen = MaterialColor(
    0xFF00a283,
    {
      50: Color(0xFFddf4f1),
      100: Color(0xFFabe4d9),
      200: Color(0xFF71d3c1),
      300: Color(0xFF1ec0a8),
      400: Color(0xFF00b195),
      500: Color(0xFF00a283),
      600: Color(0xFF009476),
      700: Color(0xFF008465),
      800: Color(0xFF007457),
      900: Color(0xFF00573b),
    },
  );

  static const red = Color(0xffde2d37);
  static const darkRed = Color(0xffa2001e);
  static const lightGreen = Color(0xff3ada9a);
  static const darkGreen = Color(0xff00a355);
}
