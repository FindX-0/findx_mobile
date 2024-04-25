import 'package:flutter/material.dart';

import 'app_theme_extension.dart';
import 'palette.dart';

abstract final class AppTheme {
  AppTheme._();

  static final _defaultButtonShape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(8));
  static const _defaultButtonPadding = EdgeInsets.symmetric(vertical: 2, horizontal: 16);

  static final _defaultInputBorderRadius = BorderRadius.circular(4);

  static final light = ThemeData.light().copyWith(
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
      thumbColor: MaterialStateProperty.resolveWith(
        (states) =>
            states.contains(MaterialState.selected) ? Palette.secondary : Palette.secondary.withOpacity(.8),
      ),
      trackColor: MaterialStateProperty.resolveWith(
        (states) => states.contains(MaterialState.selected)
            ? Palette.secondary.withOpacity(.5)
            : Palette.secondary.withOpacity(.3),
      ),
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: Palette.elPrimary,
      unselectedLabelColor: Palette.elSecondary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Palette.primaryContainer,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 14, color: Palette.elPrimary),
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
      hintStyle: const TextStyle(fontSize: 14, color: Palette.elSecondary),
      labelStyle: const TextStyle(fontSize: 14, color: Palette.elSecondary),
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
      style: TextButton.styleFrom(
        disabledBackgroundColor: Palette.secondary.withOpacity(.85),
        backgroundColor: Palette.secondary,
        shape: _defaultButtonShape,
        padding: _defaultButtonPadding,
        splashFactory: NoSplash.splashFactory,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(color: Colors.white),
        minimumSize: const Size(64, 32),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Palette.secondaryContainer,
      selectedItemColor: Palette.secondary,
      unselectedItemColor: Palette.elSecondary,
      selectedIconTheme: IconThemeData(color: Palette.elPrimary),
      unselectedIconTheme: IconThemeData(color: Palette.elSecondary),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith(
        (states) => states.contains(MaterialState.selected) ? Palette.secondary : Palette.elSecondary,
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith(
        (states) => states.contains(MaterialState.selected) ? Palette.secondary : Palette.elSecondary,
      ),
    ),
    extensions: <ThemeExtension<dynamic>>[
      AppThemeExtension(
        elSecondary: Palette.elSecondary,
        primaryText: Palette.elPrimary,
        success: Palette.success,
        elSecondaryOnDark: Palette.secondaryElementOnDark,
        secondaryVariant: Palette.secondaryVariant,
      ),
    ],
  );
}
