import 'package:flutter/material.dart';

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
    return _Content(args: args);
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.args,
  });

  final MatchResultPageArgs args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Match results ${args.matchId}'),
        ),
      ),
    );
  }
}
