import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app/di/register_dependencies.dart';
import '../features/matchmaking/state/matchmaking_state.dart';

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
  const _Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Searching opponent...',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 80),
              TextButton(
                onPressed: context.matchmakingCubit.onCancelTicketPressed,
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
