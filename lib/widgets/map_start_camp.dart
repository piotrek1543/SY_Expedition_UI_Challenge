import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syexpedition/notifiers/map_animation_notifier.dart';
import 'package:syexpedition/position_helpers.dart';

class MapStartCamp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MapAnimationNotifier>(
      builder: (context, notifier, child) {
        double opacity = math.max(0, 4 * (notifier.value - 3 / 4));
        return Positioned(
          top: startTop(context) - 4,
          width: (MediaQuery.of(context).size.width - 48) / 3,
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
      child: Align(
        alignment: Alignment.center,
        child: Text(
          'Start camp',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
