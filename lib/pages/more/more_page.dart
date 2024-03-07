import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/di/register_dependencies.dart';
import '../../features/authentication/state/authentication_state.dart';
import 'more_page_state.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthenticationStateCubit>()),
        BlocProvider(create: (_) => getIt<MorePageCubit>()),
      ],
      child: const _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton(
                  onPressed: context.read<AuthenticationStateCubit>().onSignInWithGooglePressed,
                  child: const Text('sign in'),
                ),
                TextButton(
                  onPressed: context.morePageCubit.onToDevPagePressed,
                  child: const Text('To dev page'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
