import 'package:flutter/material.dart';

extension ThemeDataX on ThemeData {
  AppThemeExtension? get appThemeExtension => extension<AppThemeExtension>();
}

class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  AppThemeExtension({
    required this.secondaryElement,
    required this.secondaryElementOnDark,
    required this.primaryText,
    required this.success,
  });

  final Color secondaryElement;
  final Color secondaryElementOnDark;
  final Color primaryText;
  final Color success;

  @override
  ThemeExtension<AppThemeExtension> copyWith({
    Color? secondaryElement,
    Color? secondaryElementOnDark,
    Color? primaryText,
    Color? success,
  }) {
    return AppThemeExtension(
      secondaryElement: secondaryElement ?? this.secondaryElement,
      secondaryElementOnDark: secondaryElementOnDark ?? this.secondaryElementOnDark,
      primaryText: primaryText ?? this.primaryText,
      success: success ?? this.success,
    );
  }

  @override
  ThemeExtension<AppThemeExtension> lerp(ThemeExtension<AppThemeExtension>? other, double t) {
    if (other is! AppThemeExtension) {
      return this;
    }

    return AppThemeExtension(
      secondaryElement: Color.lerp(secondaryElement, other.secondaryElement, t) ?? secondaryElement,
      secondaryElementOnDark:
          Color.lerp(secondaryElementOnDark, other.secondaryElementOnDark, t) ?? secondaryElementOnDark,
      primaryText: Color.lerp(primaryText, other.primaryText, t) ?? primaryText,
      success: Color.lerp(success, other.success, t) ?? success,
    );
  }
}
