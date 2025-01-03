import 'package:flutter/material.dart';
import 'package:pust_guest_house/core/theme/app_pallete.dart';

class AppTheme {
  static final darkThemeMode = ThemeData.light().copyWith(
    // colorScheme: const ColorScheme.light(
    //   // primary: AppPallete.primary,
    //   // onPrimary: AppPallete.white,
    //   // onSurface: AppPallete.primary,
    // ),
    appBarTheme: const AppBarTheme(
      color: AppPallete.primaryDeep,
      iconTheme: IconThemeData(
        color: AppPallete.white,
      ),
    ),
    scaffoldBackgroundColor: Colors.transparent,
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.all(20.0),
      fillColor: AppPallete.primary,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppPallete.grey,
        ),
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppPallete.primary,
          width: 2.0,
        ),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppPallete.primary),
        textStyle: WidgetStateProperty.all(
          const TextStyle(color: AppPallete.white, fontWeight: FontWeight.bold),
        ),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppPallete.primaryDeep,
      foregroundColor: AppPallete.white,
    ),
    radioTheme: RadioThemeData(
      fillColor:
          WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return AppPallete.primaryDeep; // Selected color
        }
        return AppPallete.grey; // Default color
      }),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: Colors.white, // Background of the picker
      headerBackgroundColor: Colors.blue, // Header color of the picker
      headerForegroundColor: Colors.white, // Text color in the header
      dayStyle: TextStyle(color: Colors.black), // Day numbers style
      todayBorder: BorderSide(color: Colors.blue), // Today's date border color
      // selectedDayStyle: TextStyle(color: Colors.blue), // Style for selected date
    ),
  );
}
