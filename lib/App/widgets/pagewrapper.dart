import 'package:flutter/material.dart';

class PageWrapper extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final bool useSafeArea;
  final EdgeInsets? additionalPadding;

  const PageWrapper({
    Key? key,
    required this.child,
    this.backgroundColor,
    this.useSafeArea = true,
    this.additionalPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (useSafeArea) {
      return Container(
        color: backgroundColor ?? Colors.white,
        child: SafeArea(
          bottom: true,
          minimum: additionalPadding ?? EdgeInsets.zero,
          child: child,
        ),
      );
    } else {
      return Container(
        color: backgroundColor ?? Colors.white,
        padding: additionalPadding,
        child: child,
      );
    }
  }
}
