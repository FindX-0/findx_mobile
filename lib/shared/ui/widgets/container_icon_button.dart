import 'package:flutter/material.dart';

class ContainerIconButton extends StatelessWidget {
  const ContainerIconButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.color,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return MaterialButton(
      onPressed: onPressed,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.zero,
      minWidth: 32,
      height: 32,
      color: color ?? theme.colorScheme.secondary,
      elevation: 0,
      child: child,
    );
  }
}
