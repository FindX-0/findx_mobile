import 'package:flutter/material.dart';

import '../features/matchmaking/ui/match_math_problem.dart';
import '../features/matchmaking/ui/match_players.dart';
import '../features/matchmaking/ui/match_timer.dart';

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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Align(child: MatchTimer()),
              const SizedBox(height: 8),
              const MatchPlayers(),
              const SizedBox(height: 8),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(child: MatchMathProblemImage()),
                    const SliverToBoxAdapter(child: MatchMathProblemTexContainer()),
                    const SliverToBoxAdapter(child: MatchMathProblemText()),
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        child: const MatchMathProblemAnswers(),
                      ),
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
