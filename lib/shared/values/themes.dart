import 'package:flutter/material.dart';

import 'app_theme_extension.dart';
import 'palette.dart';

abstract final class AppTheme {
  AppTheme._();

  static final RoundedRectangleBorder _defaultButtonShape =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(4));
  static const EdgeInsets _defaultButtonPadding = EdgeInsets.symmetric(vertical: 10, horizontal: 12);

  static final BorderRadius _defaultInputBorderRadius = BorderRadius.circular(4);

  static final ThemeData light = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Palette.primary,
    primaryColor: Palette.primary,
    primaryIconTheme: const IconThemeData(color: Palette.iconPrimary),
    secondaryHeaderColor: Palette.secondaryHeaderColor,
    splashFactory: NoSplash.splashFactory,
    canvasColor: Palette.primary,
    colorScheme: const ColorScheme.light().copyWith(
      primary: Palette.secondary,
      secondary: Palette.secondary,
      primaryContainer: Palette.primaryContainer,
      secondaryContainer: Palette.secondaryContainer,
      onSecondary: Palette.onSecondary,
      onSecondaryContainer: Palette.onSecondaryContainer,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Palette.secondary;
        }
        return Palette.secondary.withOpacity(.8);
      }),
      trackColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Palette.secondary.withOpacity(.5);
        }
        return Palette.secondary.withOpacity(.3);
      }),
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: Palette.textPrimary,
      unselectedLabelColor: Palette.secondaryElement,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Palette.primaryContainer,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 14, color: Palette.textPrimary),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.black,
    ),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Palette.primaryContainer,
      border: OutlineInputBorder(
        borderRadius: _defaultInputBorderRadius,
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: _defaultInputBorderRadius,
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: _defaultInputBorderRadius,
        borderSide: const BorderSide(color: Palette.secondaryContainer),
      ),
      isDense: true,
      constraints: const BoxConstraints(minHeight: 1),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      hintStyle: const TextStyle(fontSize: 14, color: Palette.secondaryElement),
      labelStyle: const TextStyle(fontSize: 14, color: Palette.secondaryElement),
      alignLabelWithHint: true,
      errorMaxLines: 2,
    ),
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.accent,
      padding: _defaultButtonPadding,
      shape: _defaultButtonShape,
      highlightColor: Colors.black12,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith(
          (Set<MaterialState> states) => states.contains(MaterialState.disabled)
              ? Palette.secondary.withOpacity(.85)
              : Palette.secondary,
        ),
        shape: MaterialStateProperty.all(_defaultButtonShape),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        overlayColor: MaterialStateProperty.all<Color>(Palette.secondaryDark),
        padding: MaterialStateProperty.all<EdgeInsets>(_defaultButtonPadding),
        splashFactory: NoSplash.splashFactory,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Palette.secondaryContainer,
      selectedItemColor: Palette.secondary,
      unselectedItemColor: Palette.secondaryElement,
      selectedIconTheme: IconThemeData(color: Palette.secondary),
      unselectedIconTheme: IconThemeData(color: Palette.secondaryElement),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith(
        (states) => states.contains(MaterialState.selected) ? Palette.secondary : Palette.secondaryElement,
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith(
        (states) => states.contains(MaterialState.selected) ? Palette.secondary : Palette.secondaryElement,
      ),
    ),
    extensions: <ThemeExtension<dynamic>>[
      AppThemeExtension(
        secondaryElement: Palette.secondaryElement,
        primaryText: Palette.textPrimary,
        success: Palette.success,
        secondaryElementOnDark: Palette.secondaryElementOnDark,
      ),
    ],
  );
}
