import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app/di/register_dependencies.dart';
import '../app/intl/app_localizations.dart';
import '../entities/user/state/auth_user_state.dart';
import '../entities/user/ui/auth_user_profile.dart';
import '../entities/user_meta/ui/user_trophy_chip.dart';
import 'home/state/home_page_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthUserCubit>()),
        BlocProvider(create: (_) => getIt<HomePageCubit>()),
      ],
      child: const _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const UserTrophyChip(),
          const SizedBox(height: 4),
          const AuthUserProfile(),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 80,
                child: TextButton(
                  onPressed: context.homePageCubit.onPlayPressed,
                  child: Text(l.play),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 80,
                child: TextButton(
                  onPressed: context.homePageCubit.onFriendsPressed,
                  child: Text(l.friends),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
