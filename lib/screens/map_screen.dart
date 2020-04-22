import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syexpedition/notifiers/map_animation_notifier.dart';
import 'package:syexpedition/painters/curve_painter.dart';
import 'package:syexpedition/styles/styles.dart';

import '../position_helpers.dart';

class MapImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MapAnimationNotifier>(
      builder: (context, notifier, child) {
        double scale = 1 + 0.3 * (1 - notifier.value);
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..scale(scale, scale)
            ..rotateZ(0.05 * math.pi * (1 - notifier.value)),
          child: Opacity(
            opacity: notifier.value,
            child: child,
          ),
        );
      },
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: Image.asset(
          'assets/map-min.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class MapBaseCamp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MapAnimationNotifier>(
      builder: (context, notifier, child) {
        double opacity = math.max(0, 4 * (notifier.value - 3 / 4));
        return Positioned(
          top: topMargin(context) + 32 + 16 + 4,
          width: (MediaQuery.of(context).size.width - 48) / 3,
          right: 30.0,
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Base camp',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class MapLeopards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MapAnimationNotifier>(
      builder: (context, notifier, child) {
        double opacity = math.max(0, 4 * (notifier.value - 3 / 4));
        return Positioned(
          top: topMargin(context) + 32 + 16 + 4 + oneThird(context),
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: SmallAnimalIconLabel(
          isVulture: false,
          showLine: false,
        ),
      ),
    );
  }
}

class MapVultures extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MapAnimationNotifier>(
      builder: (context, notifier, child) {
        double opacity = math.max(0, 4 * (notifier.value - 3 / 4));
        return Positioned(
          top: topMargin(context) + 32 + 16 + 4 + 2 * oneThird(context),
          right: 50,
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
      child: SmallAnimalIconLabel(
        isVulture: true,
        showLine: false,
      ),
    );
  }
}

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

class LeopardIconLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<AnimationController, MapAnimationNotifier>(
      builder: (context, animation, notifier, child) {
        double opacity;
        if (animation.value < 3 / 4) {
          opacity = 0;
        } else if (notifier.value == 0) {
          opacity = 4 * (animation.value - 3 / 4);
        } else if (notifier.value < 0.33) {
          opacity = 1 - 3 * notifier.value;
        } else {
          opacity = 0;
        }
        return Positioned(
          top: endTop(context) + oneThird(context) - 28 - 16 - 7,
          left: 10 + opacity * 16,
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
      child: SmallAnimalIconLabel(
        isVulture: false,
        showLine: true,
      ),
    );
  }
}

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

class SmallAnimalIconLabel extends StatelessWidget {
  final bool isVulture;
  final bool showLine;

  const SmallAnimalIconLabel(
      {Key key, @required this.isVulture, @required this.showLine})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        if (showLine && isVulture)
          Container(
            margin: EdgeInsets.only(bottom: 8),
            width: 16,
            height: 1,
            color: white,
          ),
        SizedBox(width: 24),
        Column(
          children: <Widget>[
            Image.asset(
              isVulture ? 'assets/vultures.png' : 'assets/leopards.png',
              width: 28,
              height: 28,
            ),
            SizedBox(height: showLine ? 16 : 0),
            Text(
              isVulture ? 'Vultures' : 'Leopards',
              style: TextStyle(fontSize: showLine ? 14 : 12),
            )
          ],
        ),
        SizedBox(width: 24),
        if (showLine && !isVulture)
          Container(
            margin: EdgeInsets.only(bottom: 8),
            width: 16,
            height: 1,
            color: white,
          ),
      ],
    );
  }
}

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