import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syexpedition/notifiers/page_offset_notifier.dart';
import 'package:syexpedition/position_helpers.dart';
import 'package:syexpedition/styles/styles.dart';
import 'package:syexpedition/widgets/map_hider.dart';

class DistanceLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        double opacity = math.max(0, 4 * notifier.page - 3);
        return Positioned(
          top: topMargin(context) + mainSquareSize(context) + 32 + 16 + 32 + 40,
          width: MediaQuery.of(context).size.width,
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
      child: MapHider(
        child: Center(
          child: Text(
            '72 km',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: white,
            ),
          ),
        ),
      ),
    );
  }
}
