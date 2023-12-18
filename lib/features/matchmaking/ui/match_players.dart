import 'package:flutter/material.dart';

class MatchPlayers extends StatelessWidget {
  const MatchPlayers({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final spacing = (constraints.maxWidth - 16 * 2) * .05;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(
              child: _PlayerContainer(
                reverse: false,
                username: 'My username',
                score: '12',
              ),
            ),
            SizedBox(width: spacing * 2),
            const Expanded(
              child: _PlayerContainer(
                reverse: true,
                username: 'Opponent',
                score: '10',
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PlayerContainer extends StatelessWidget {
  const _PlayerContainer({
    required this.reverse,
    required this.username,
    required this.score,
  });

  final String username;
  final String score;
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final children = [
      CircleAvatar(
        backgroundColor: theme.colorScheme.primary,
        radius: 15,
      ),
      const SizedBox(width: 5),
      Expanded(
        child: Text(
          username,
          maxLines: 1,
          textAlign: reverse ? TextAlign.right : null,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      const SizedBox(width: 6),
      Text(
        score,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: theme.colorScheme.primaryContainer,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: reverse ? children.reversed.toList() : children,
      ),
    );
  }
}
