import 'package:doc_tracker/Models/Widgets/style.dart';
import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: primaryMain,
  scaffoldBackgroundColor: const Color(0xff161616),
  dialogBackgroundColor: const Color(0xff161616),
  shadowColor:  Colors.white.withOpacity(.035),
  disabledColor: const Color(0xff505050),
  cardColor: const Color(0xffFFFFFF),
  canvasColor: const Color.fromRGBO(255, 255, 255, 0.2), //separate
  primaryColorLight: const Color(0xffFFFFFF), //primaryText
  primaryColorDark: const Color(0xffD3D3D3), //secondaryText
  unselectedWidgetColor: const Color(0xff242424), //fieldColor
);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: primaryMain,
  scaffoldBackgroundColor: const Color(0xffFFFFFF),
  dialogBackgroundColor: const Color(0xffFFFFFF),
  disabledColor: const Color(0xffD3D3D3),
  primaryColorLight: const Color(0xff242424), //primaryText
  primaryColorDark: const Color(0xff4E4E4E), //secondaryText
  unselectedWidgetColor: const Color(0xffF8F8F8), //fieldColor
  shadowColor:  Colors.black.withOpacity(.05),
  cardColor: const Color(0xff000000),
  canvasColor: const Color(0xffF5F5F5),
);
