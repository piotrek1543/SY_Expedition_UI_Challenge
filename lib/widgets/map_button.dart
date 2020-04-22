import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syexpedition/notifiers/map_animation_notifier.dart';
import 'package:syexpedition/notifiers/page_offset_notifier.dart';

class MapButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 8,
      bottom: 0,
      child: Consumer<PageOffsetNotifier>(
        builder: (context, notifier, child) {
          double opacity = math.max(0, 4 * notifier.page - 3);
          return Opacity(
            opacity: opacity,
            child: child,
          );
        },
        child: FlatButton(
          child: Text(
            'ON MAP',
            style: TextStyle(fontSize: 12),
          ),
          onPressed: () {
            final notifier = Provider.of<MapAnimationNotifier>(context);
            notifier.value == 0 ? notifier.forward() : notifier.reverse();
          },
        ),
      ),
    );
  }
}