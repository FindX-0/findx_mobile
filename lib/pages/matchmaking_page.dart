import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app/di/register_dependencies.dart';
import '../features/matchmaking/state/matchmaking_state.dart';
import '../features/matchmaking/ui/cancel_matchmaking_button.dart';

class MatchmakingPageArgs {
  MatchmakingPageArgs({
    required this.mathFieldId,
  });

  final String mathFieldId;
}

class MatchmakingPage extends StatelessWidget {
  const MatchmakingPage({
    super.key,
    required this.args,
  });

  final MatchmakingPageArgs args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MatchmakingCubit>()..init(mathFieldId: args.mathFieldId),
      child: const _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Searching opponent...',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 80),
              CancelMatchmakingButton(),
            ],
          ),
        ),
      ),
    );
  }
}
