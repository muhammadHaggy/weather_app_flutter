// based on original GradientContainer class by Felix Angelov
// https://gist.github.com/felangel/96b231de636173a44e4787fb52614130#file-gradient_container-dart

import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;
  final MaterialColor color;

  GradientContainer({
    Key? key,
    required this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 1.0],
          colors: [
            color[800]!,
            color[400]!,
          ],
        ),
      ),
      child: child,
    );
  }
}
