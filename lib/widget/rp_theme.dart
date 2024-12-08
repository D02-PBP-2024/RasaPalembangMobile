import 'package:flutter/material.dart';
import 'package:rasapalembang/utils/color_constants.dart';

class RPTheme {
  static ThemeData get theme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: RPColors.biruMuda),
      useMaterial3: true,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: RPColors.textFieldBackground,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.transparent, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: RPColors.biruMuda, width: 1.0),
        ),
        errorStyle: const TextStyle(
          color: RPColors.merahMuda,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: RPColors.merahMuda, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: RPColors.merahMuda, width: 1.0),
        ),
      ),
    );
  }
}
