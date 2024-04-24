import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/intl/app_localizations.dart';
import '../../util/color.dart';
import '../../values/app_theme_extension.dart';
import '../../values/assets.dart';

class NonInteractiveSearchField extends StatelessWidget {
  const NonInteractiveSearchField({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l = AppLocalizations.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              Assets.iconSearch,
              width: 20,
              height: 20,
              colorFilter: svgColor(theme.appThemeExtension?.elSecondary),
            ),
            const SizedBox(width: 8),
            Text(
              l.search,
              style: TextStyle(
                fontSize: 12,
                color: theme.appThemeExtension?.elSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
