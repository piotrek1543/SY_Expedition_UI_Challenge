import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syexpedition/notifiers/map_animation_notifier.dart';
import 'package:syexpedition/painters/curve_painter.dart';
import 'package:syexpedition/styles/styles.dart';

import '../position_helpers.dart';

class CurvedRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EdgeInsets mediaPadding = MediaQuery.of(context).padding;
    return Consumer<MapAnimationNotifier>(
      builder: (context, animation, child) {
        if (animation.value == 0) {
          return Container();
        }
        double startTop =
            topMargin(context) + mainSquareSize(context) + 32 + 16 + 32 + 4;
        double endTop = topMargin(context) + 32 + 16 + 8;
        double oneThird = (startTop - endTop) / 3;
        double width = MediaQuery.of(context).size.width;

        return Positioned(
          top: endTop,
          bottom: bottom(context) - mediaPadding.vertical,
          left: 0,
          right: 0,
          child: CustomPaint(
            painter: CurvePainter(animation.value),
            child: Center(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Positioned(
                    top: oneThird,
                    right: width / 2 - 4 - animation.value * 60,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: white, width: 2.5),
                        color: mainBlack,
                      ),
                      height: 8,
                      width: 8,
                    ),
                  ),
                  Positioned(
                    top: 2 * oneThird,
                    right: width / 2 - 4 - animation.value * 50,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: white, width: 2.5),
                        color: mainBlack,
                      ),
                      height: 8,
                      width: 8,
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, 1),
                    child: Container(
                      margin: EdgeInsets.only(right: 100 * animation.value),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: white, width: 1),
                        color: mainBlack,
                      ),
                      height: 8,
                      width: 8,
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, -1),
                    child: Container(
                      margin: EdgeInsets.only(left: 40 * animation.value),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: white,
                      ),
                      height: 8,
                      width: 8,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
