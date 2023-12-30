import 'package:flutter/material.dart';

import '../features/matchmaking/ui/match_math_problem.dart';
import '../features/matchmaking/ui/match_players.dart';
import '../features/matchmaking/ui/match_timer.dart';
import '../shared/ui/widgets/sliver_align_bottom.dart';

class MatchPageArgs {
  MatchPageArgs({
    required this.matchId,
  });

  final String matchId;
}

class MatchPage extends StatelessWidget {
  const MatchPage({
    super.key,
    required this.args,
  });

  final MatchPageArgs args;

  @override
  Widget build(BuildContext context) {
    return const _Content();
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(child: MatchTimer()),
              SizedBox(height: 8),
              MatchPlayers(),
              SizedBox(height: 8),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(child: MatchMathProblemImage()),
                    SliverToBoxAdapter(child: MatchMathProblemTexContainer()),
                    SliverToBoxAdapter(child: MatchMathProblemText()),
                    SliverAlignBottom(
                      padding: EdgeInsets.only(top: 16, bottom: 16),
                      child: MatchMathProblemAnswers(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}