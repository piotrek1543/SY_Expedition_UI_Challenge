import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syexpedition/position_helpers.dart';
import 'package:syexpedition/styles/styles.dart';
import 'package:syexpedition/widgets/map_hider.dart';

class ArrowIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AnimationController>(
      builder: (context, animation, child) {
        return Positioned(
          top: topMargin(context) +
              (1 - animation.value) * (mainSquareSize(context) + 32 - 4),
          right: 24,
          child: child,
        );
      },
      child: MapHider(
        child: Icon(
          Icons.keyboard_arrow_up,
          size: 28,
          color: lighterGrey,
        ),
      ),
    );
  }
}