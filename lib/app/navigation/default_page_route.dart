import 'package:flutter/material.dart';

class DefaultPageRoute<T> extends MaterialPageRoute<T> {
  DefaultPageRoute({
    required super.builder,
    super.settings,
    super.maintainState,
    super.fullscreenDialog,
  });

  final Tween<Offset> _offsetTween = Tween<Offset>(
    begin: const Offset(0, .05),
    end: Offset.zero,
  );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: _offsetTween.animate(animation),
        child: child,
      ),
    );
  }
}
