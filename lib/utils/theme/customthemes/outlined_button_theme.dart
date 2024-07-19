import 'package:flutter/material.dart';

class DaguOutlinedButtonTheme {
  DaguOutlinedButtonTheme._();

  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.black,
          side: const BorderSide(color: Color(0xFF652D91)),
          textStyle: const TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
          padding:
              const EdgeInsets.only(top: 18, bottom: 18, left: 0, right: 0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))));
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          side: const BorderSide(color: Color(0xFF652D91)),
          textStyle: const TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
          padding:
              const EdgeInsets.only(top: 18, bottom: 18, left: 0, right: 0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))));
}
