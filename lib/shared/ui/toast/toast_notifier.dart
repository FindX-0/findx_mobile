import 'package:flutter/material.dart';
import 'package:global_navigator/global_navigator.dart';
import 'package:injectable/injectable.dart';

import '../../../app/intl/app_localizations.dart';
import '../../types.dart';
import '../../values/app_theme_extension.dart';

@lazySingleton
class ToastNotifier {
  void notify({
    required LocalizedMessage message,
    required LocalizedMessage title,
    VoidCallback? onTap,
    TextButton? mainButton,
  }) {
    _notify(
      message: message,
      title: title,
      onTap: onTap,
      mainButton: mainButton,
    );
  }

  void notifyNetworkError() {
    _notify(
      message: (l) => l.networkError,
      title: (l) => l.error,
    );
  }

  void notifyUnknownError({
    String? message,
    String? title,
  }) {
    _notify(
      message: (l) => l.unknownError,
      title: (l) => l.error,
    );
  }

  Future<void> dismiss() async => GlobalNavigator.closeCurrentSnackbar();

  void _notify({
    required LocalizedMessage message,
    required LocalizedMessage title,
    Icon? icon,
    TextButton? mainButton,
    VoidCallback? onTap,
  }) async {
    final context = GlobalNavigator.context;
    final resolvedMessage = context != null ? message(AppLocalizations.of(context)) : '';
    final resolvedTitle = context != null ? title(AppLocalizations.of(context)) : '';

    GlobalNavigator.snackbar(
      resolvedTitle,
      resolvedMessage,
      onTap: (_) => onTap?.call(),
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      colorText: GlobalNavigator.theme.appThemeExtension?.primaryText,
      animationDuration: const Duration(seconds: 1),
      borderRadius: 0,
      icon: icon != null
          ? Padding(
              padding: const EdgeInsets.only(left: 12, right: 6),
              child: icon,
            )
          : null,
      mainButton: mainButton,
      backgroundColor: GlobalNavigator.theme.colorScheme.secondaryContainer,
    );
  }
}
