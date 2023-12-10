import 'package:flutter/material.dart';

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
  const _Content({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Match'),
        ),
      ),
    );
  }
}
