import 'package:flutter/material.dart';

extension ThemeDataX on ThemeData {
  AppThemeExtension? get appThemeExtension => extension<AppThemeExtension>();
}

class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  AppThemeExtension({
    required this.elSecondary,
    required this.elSecondaryOnDark,
    required this.primaryText,
    required this.success,
    required this.secondaryVariant,
  });

  final Color elSecondary;
  final Color elSecondaryOnDark;
  final Color primaryText;
  final Color success;
  final Color secondaryVariant;

  @override
  ThemeExtension<AppThemeExtension> copyWith({
    Color? elSecondary,
    Color? elSecondaryOnDark,
    Color? primaryText,
    Color? success,
    Color? secondaryVariant,
  }) {
    return AppThemeExtension(
      elSecondary: elSecondary ?? this.elSecondary,
      elSecondaryOnDark: elSecondaryOnDark ?? this.elSecondaryOnDark,
      primaryText: primaryText ?? this.primaryText,
      success: success ?? this.success,
      secondaryVariant: secondaryVariant ?? this.secondaryVariant,
    );
  }

  @override
  ThemeExtension<AppThemeExtension> lerp(ThemeExtension<AppThemeExtension>? other, double t) {
    if (other is! AppThemeExtension) {
      return this;
    }

    return AppThemeExtension(
      elSecondary: Color.lerp(elSecondary, other.elSecondary, t) ?? elSecondary,
      elSecondaryOnDark: Color.lerp(elSecondaryOnDark, other.elSecondaryOnDark, t) ?? elSecondaryOnDark,
      primaryText: Color.lerp(primaryText, other.primaryText, t) ?? primaryText,
      success: Color.lerp(success, other.success, t) ?? success,
      secondaryVariant: Color.lerp(secondaryVariant, other.secondaryVariant, t) ?? secondaryVariant,
    );
  }
}
