import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syexpedition/notifiers/map_animation_notifier.dart';
import 'package:syexpedition/position_helpers.dart';
import 'package:syexpedition/widgets/small_animal_icon_label.dart';

class VultureIconLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<AnimationController, MapAnimationNotifier>(
      builder: (context, animation, notifier, child) {
        double startTop =
            topMargin(context) + mainSquareSize(context) + 32 + 16 + 32 + 4;
        double endTop = topMargin(context) + 32 + 16 + 8;
        double oneThird = (startTop - endTop) / 3;
        double opacity;
        if (animation.value < 2 / 3) {
          opacity = 0;
        } else if (notifier.value == 0) {
          opacity = 3 * (animation.value - 2 / 3);
        } else if (notifier.value < 0.33) {
          opacity = 1 - 3 * notifier.value;
        } else {
          opacity = 0;
        }

        return Positioned(
          top: endTop + 2 * oneThird - 28 - 16 - 7,
          right: 10 + opacity * 16,
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
      child: SmallAnimalIconLabel(
        isVulture: true,
        showLine: true,
      ),
    );
  }
}
