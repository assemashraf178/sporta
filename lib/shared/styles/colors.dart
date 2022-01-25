import 'package:flutter/material.dart';

MaterialColor defaultColor = const MaterialColor(
  0xff158ace, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
  <int, Color>{
    50: Color(0x1a158ace), //10%
    100: Color(0x33158ace), //20%
    200: Color(0x4d158ace), //30%
    300: Color(0x66158ace), //40%
    400: Color(0x80158ace), //50%
    500: Color(0x99158ace), //60%
    600: Color(0xb3158ace), //70%
    700: Color(0xcc158ace), //80%
    800: Color(0xe6158ace), //90%
    900: Color(0xff158ace), //100%
  },
);
