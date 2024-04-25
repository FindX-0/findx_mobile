import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/intl/app_localizations.dart';
import '../../../shared/util/color.dart';
import '../../../shared/values/app_theme_extension.dart';
import '../../../shared/values/assets.dart';
import '../state/search_friends_state.dart';

class SearchFriendsField extends StatelessWidget {
  const SearchFriendsField({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return TextField(
      decoration: InputDecoration(
        hintText: l.search,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SvgPicture.asset(
            Assets.iconSearch,
            colorFilter: svgColor(theme.appThemeExtension?.elSecondary),
          ),
        ),
      ),
      onChanged: context.searchFriendsCubit.onSearchQueryChanged,
    );
  }
}
