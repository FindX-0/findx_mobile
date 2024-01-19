import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app/di/register_dependencies.dart';
import '../entities/math_battle_result/state/math_battle_result_state.dart';
import '../entities/math_battle_result/ui/match_results.dart';

class MatchResultPageArgs {
  MatchResultPageArgs({
    required this.matchId,
  });

  final String matchId;
}

class MatchResultPage extends StatelessWidget {
  const MatchResultPage({
    super.key,
    required this.args,
  });

  final MatchResultPageArgs args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MathBattleResultCubit>()
        ..init(
          MathBattleResultCubitArgs(
            matchId: args.matchId,
          ),
        ),
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
        child: MatchResults(),
      ),
    );
  }
}
