import 'package:flutter/material.dart';

class SliverAlignBottom extends StatelessWidget {
  const SliverAlignBottom({
    super.key,
    required this.child,
    this.padding,
  });

  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Container(
        alignment: Alignment.bottomCenter,
        width: double.infinity,
        padding: padding,
        child: child,
      ),
    );
  }
}
