import 'package:flutter/material.dart';

const MaterialColor customBlue = MaterialColor(
  _customBluePrimaryValue,
  <int, Color>{
    50: Color(0xFFF4F7FF),
    100: Color(0xFFCFE4FD),
    200: Color(0xFF76B5F4),
    300: Color(0xFF3F8FEA),
    400: Color(_customBluePrimaryValue),
  },
);
const int _customBluePrimaryValue = 0xFF1775E5;

const MaterialColor customBlueGrey = MaterialColor(
  _customBlueGreyPrimaryValue,
  <int, Color>{
    50: Color(0xFFEEF0F6),
    100: Color(0xFFCBD9E9),
    200: Color(0xFFC8D3E2),
    300: Color(0xFFA8B8CA),
    400: Color(_customBlueGreyPrimaryValue),
  },
);
const int _customBlueGreyPrimaryValue = 0xFF496D97;

const MaterialColor customGrey = MaterialColor(
  _customGreyPrimaryValue,
  <int, Color>{
    50: Color(0xFFE0E0E3),
    100: Color(0xFFB2B2B2),
    300: Color(0xFF434343),
    900: Color(0xFF000000),
  },
);
const int _customGreyPrimaryValue = 0xFF1775E5;

final lightTheme = ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: customBlue,
      onPrimary: customBlue,
      secondary: customGrey,
      onSecondary: customGrey,
      error: const Color(0xFFF25168),
      onError: const Color(0xFFF25168),
      background: customBlueGrey,
      onBackground: customBlueGrey,
      surface: Colors.black.withOpacity(0.6),
      onSurface: Colors.black.withOpacity(0.6),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(),
      displayMedium: TextStyle(),
      displaySmall: TextStyle(),
    )
);

// final darkTheme = ThemeData(
//   colorScheme: ColorScheme(
//       brightness: Brightness.dark,
//       primary: primary,
//       onPrimary: onPrimary,
//       secondary: secondary,
//       onSecondary: onSecondary,
//       error: error,
//       onError: onError,
//       background: background,
//       onBackground: onBackground,
//       surface: surface,
//       onSurface: onSurface,
//   ),
//   textTheme: TextTheme(
//     displayLarge: ,
//     displayMedium: ,
//     displaySmall: ,
//     bodyLarge: ,
//     bodyMedium: ,
//     bodySmall: ,
//     headlineLarge: ,
//     headlineMedium: ,
//     headlineSmall: ,
//     labelLarge: ,
//     labelMedium: ,
//     labelSmall: ,
//     titleLarge: ,
//     titleMedium: ,
//     titleSmall: ,
//   )
// );