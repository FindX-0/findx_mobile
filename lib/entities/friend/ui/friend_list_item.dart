import 'package:flutter/material.dart';

class FriendListItem extends StatelessWidget {
  const FriendListItem({
    super.key,
    required this.name,
    this.end,
  });

  final String name;
  final Widget? end;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            color: theme.colorScheme.secondary,
            width: 42,
            height: 42,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (end != null)
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: end!,
            ),
        ],
      ),
    );
  }
}
