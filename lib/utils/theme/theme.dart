import 'package:dagu/utils/theme/customthemes/appbar_theme.dart';
import 'package:dagu/utils/theme/customthemes/bottom_sheet_theme.dart';
import 'package:dagu/utils/theme/customthemes/checkbox_theme.dart';
import 'package:dagu/utils/theme/customthemes/elevated_button_theme.dart';
import 'package:dagu/utils/theme/customthemes/outlined_button_theme.dart';
import 'package:dagu/utils/theme/customthemes/text_field_theme.dart';
import 'package:dagu/utils/theme/customthemes/text_theme.dart';
import 'package:flutter/material.dart';

class DaguAppTheme {
  DaguAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: const Color(0xFF652D91),
    scaffoldBackgroundColor: Colors.white,
    textTheme: DaguTextTheme.lightTextTheme,
    elevatedButtonTheme: DaguElevatedButtonTheme.lightElevatedButtonTheme,
    appBarTheme: DaguAppBarTheme.lightAppBarTheme,
    checkboxTheme: DaguCheckBoxTheme.lightCheckboxTheme,
    bottomSheetTheme: DaguBottomSheetTheme.lightBottomSheetTheme,
    outlinedButtonTheme: DaguOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: DaguTextFormField.lightInputDecorationTheme,

  );



  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF652D91),
    scaffoldBackgroundColor: Colors.black26,
    textTheme: DaguTextTheme.darkTextTheme,
    elevatedButtonTheme: DaguElevatedButtonTheme.darkElevatedButtonTheme,
    appBarTheme: DaguAppBarTheme.darkAppBarTheme,
    checkboxTheme: DaguCheckBoxTheme.darkCheckboxTheme,
    bottomSheetTheme: DaguBottomSheetTheme.darkBottomSheetTheme,
    outlinedButtonTheme: DaguOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: DaguTextFormField.darkInputDecorationTheme,
  );
}