import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syexpedition/notifiers/page_offset_notifier.dart';
import 'package:syexpedition/position_helpers.dart';

class The72Text extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        return Transform.translate(
          offset: Offset(-40 - 0.5 * notifier.offset, 0),
          child: child,
        );
      },
      child: RotatedBox(
        quarterTurns: 1,
        child: SizedBox(
          width: mainSquareSize(context),
          child: FittedBox(
            alignment: Alignment.topCenter,
            fit: BoxFit.cover,
            child: Text(
              '72',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}