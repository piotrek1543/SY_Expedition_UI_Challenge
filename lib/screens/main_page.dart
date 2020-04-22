import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syexpedition/notifiers/map_animation_notifier.dart';
import 'package:syexpedition/notifiers/page_offset_notifier.dart';
import 'package:syexpedition/position_helpers.dart';
import 'package:syexpedition/screens/vulture_page.dart';
import 'package:syexpedition/styles/styles.dart';
import 'package:syexpedition/widgets/curved_route.dart';
import 'package:syexpedition/widgets/leopard_image.dart';
import 'package:syexpedition/widgets/map_hider.dart';
import 'package:syexpedition/widgets/animal_icon_label.dart';
import 'package:syexpedition/widgets/leopard_icon_label.dart';
import 'package:syexpedition/widgets/map_base_camp.dart';
import 'package:syexpedition/widgets/map_image.dart';
import 'package:syexpedition/widgets/map_leopards.dart';
import 'package:syexpedition/widgets/map_start_camp.dart';
import 'package:syexpedition/widgets/map_vultures.dart';

import 'leopard_page.dart';

//FIXME: pass this field as a constructor argument
EdgeInsets mediaPadding;

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  AnimationController _animationController;
  AnimationController _mapAnimationController;
  final PageController _pageController = PageController();

  double get maxHeight => mainSquareSize(context) + 32 + 24;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _mapAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _mapAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mediaPadding = MediaQuery.of(context).padding;
    return ChangeNotifierProvider(
      create: (_) => PageOffsetNotifier(_pageController),
      child: ListenableProvider.value(
        value: _animationController,
        child: ChangeNotifierProvider(
          create: (_) => MapAnimationNotifier(_mapAnimationController),
          child: Scaffold(
            body: Stack(
              children: <Widget>[
                MapImage(),
                SafeArea(
                  child: GestureDetector(
                    onVerticalDragUpdate: _handleDragUpdate,
                    onVerticalDragEnd: _handleDragEnd,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        PageView(
                          controller: _pageController,
                          physics: ClampingScrollPhysics(),
                          children: <Widget>[
                            LeopardPage(),
                            VulturePage(),
                          ],
                        ),
                        AppBar(),
                        LeopardImage(),
                        VultureImage(),
                        ShareButton(),
                        PageIndicator(),
                        ArrowIcon(),
                        TravelDetailsLabel(),
                        StartCampLabel(),
                        StartTimeLabel(),
                        BaseCampLabel(),
                        BaseTimeLabel(),
                        DistanceLabel(),
                        HorizontalTravelDots(),
                        MapButton(),
                        VerticalTravelDots(),
                        VultureIconLabel(),
                        LeopardIconLabel(),
                        CurvedRoute(),
                        MapBaseCamp(),
                        MapLeopards(),
                        MapVultures(),
                        MapStartCamp(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _animationController.value -= details.primaryDelta / maxHeight;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_animationController.isAnimating ||
        _animationController.status == AnimationStatus.completed) return;

    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / maxHeight;
    if (flingVelocity < 0.0)
      _animationController.fling(velocity: math.max(2.0, -flingVelocity));
    else if (flingVelocity > 0.0)
      _animationController.fling(velocity: math.min(-2.0, -flingVelocity));
    else
      _animationController.fling(
          velocity: _animationController.value < 0.5 ? -2.0 : 2.0);
  }
}

class VultureImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<PageOffsetNotifier, AnimationController>(
      builder: (context, notifier, animation, child) {
        return Positioned(
          left:
              1.2 * MediaQuery.of(context).size.width - 0.85 * notifier.offset,
          child: Transform.scale(
            scale: 1 - 0.1 * animation.value,
            child: Opacity(
              opacity: 1 - 0.6 * animation.value,
              child: child,
            ),
          ),
        );
      },
      child: MapHider(
        child: IgnorePointer(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 90.0),
            child: Image.asset(
              'assets/vulture.png',
              height: MediaQuery.of(context).size.height / 3,
            ),
          ),
        ),
      ),
    );
  }
}

class AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Row(
          children: <Widget>[
            Text(
              'SY',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Spacer(),
            Icon(Icons.menu),
          ],
        ),
      ),
    );
  }
}

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

class PageIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MapHider(
      child: Consumer<PageOffsetNotifier>(
        builder: (context, notifier, _) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: notifier.page.round() == 0 ? white : lightGrey,
                    ),
                    height: 6,
                    width: 6,
                  ),
                  SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: notifier.page.round() != 0 ? white : lightGrey,
                    ),
                    height: 6,
                    width: 6,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ShareButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 24,
      bottom: 16,
      child: Icon(Icons.share),
    );
  }
}

class TravelDetailsLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<PageOffsetNotifier, AnimationController>(
      builder: (context, notifier, animation, child) {
        return Positioned(
          top: topMargin(context) +
              (1 - animation.value) * (mainSquareSize(context) + 32 - 4),
          left: 24 + MediaQuery.of(context).size.width - notifier.offset,
          child: Opacity(
            opacity: math.max(0, 4 * notifier.page - 3),
            child: child,
          ),
        );
      },
      child: MapHider(
        child: Text(
          'Travel details',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class StartCampLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        double opacity = math.max(0, 4 * notifier.page - 3);
        return Positioned(
          top: topMargin(context) + mainSquareSize(context) + 32 + 16 + 32,
          width: (MediaQuery.of(context).size.width - 48) / 3,
          left: opacity * 24.0,
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
      child: MapHider(
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Start camp',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
          ),
        ),
      ),
    );
  }
}

class StartTimeLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        double opacity = math.max(0, 4 * notifier.page - 3);
        return Positioned(
          top: topMargin(context) + mainSquareSize(context) + 32 + 16 + 32 + 40,
          width: (MediaQuery.of(context).size.width - 48) / 3,
          left: opacity * 24.0,
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
      child: MapHider(
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            '02:40 pm',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w300, color: lighterGrey),
          ),
        ),
      ),
    );
  }
}

class BaseCampLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<PageOffsetNotifier, AnimationController>(
      builder: (context, notifier, animation, child) {
        double opacity = math.max(0, 4 * notifier.page - 3);
        return Positioned(
          top: topMargin(context) +
              32 +
              16 +
              4 +
              (1 - animation.value) * (mainSquareSize(context) + 32 - 4),
          width: (MediaQuery.of(context).size.width - 48) / 3,
          right: opacity * 24.0,
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
      child: MapHider(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Base camp',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }
}

class BaseTimeLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<PageOffsetNotifier, AnimationController>(
      builder: (context, notifier, animation, child) {
        double opacity = math.max(0, 4 * notifier.page - 3);
        return Positioned(
          top: topMargin(context) +
              32 +
              16 +
              44 +
              (1 - animation.value) * (mainSquareSize(context) + 32 - 4),
          width: (MediaQuery.of(context).size.width - 48) / 3,
          right: opacity * 24.0,
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
      child: MapHider(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '07:30 am',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: lighterGrey,
            ),
          ),
        ),
      ),
    );
  }
}

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

class VerticalTravelDots extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<AnimationController, MapAnimationNotifier>(
      builder: (context, animation, notifier, child) {
        if (animation.value < 1 / 6 || notifier.value > 0) {
          return Container();
        }
        double startTop = dotsTopMargin(context);
        double endTop = topMargin(context) + 32 + 16 + 8;

        double top = endTop +
            (1 - (1.2 * (animation.value - 1 / 6))) *
                (mainSquareSize(context) + 32 - 4);

        double oneThird = (startTop - endTop) / 3;

        return Positioned(
          top: top,
          bottom: bottom(context) - mediaPadding.vertical,
          child: Center(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  width: 2,
                  height: double.infinity,
                  color: white,
                ),
                Positioned(
                  top: top > oneThird + endTop ? 0 : oneThird + endTop - top,
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
                  top: top > 2 * oneThird + endTop
                      ? 0
                      : 2 * oneThird + endTop - top,
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
        );
      },
    );
  }
}

class HorizontalTravelDots extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<PageOffsetNotifier, AnimationController>(
      builder: (context, notifier, animation, child) {
        if (animation.value == 1) {
          return Container();
        }
        double spacingFactor;
        double opacity;
        if (animation.value == 0) {
          spacingFactor = math.max(0, 4 * notifier.page - 3);
          opacity = spacingFactor;
        } else {
          spacingFactor = math.max(0, 1 - 6 * animation.value);
          opacity = 1;
        }
        return Positioned(
          top: dotsTopMargin(context),
          left: 0,
          right: 0,
          child: Center(
            child: Opacity(
              opacity: opacity,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: spacingFactor * 10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: lightGrey,
                    ),
                    height: 4,
                    width: 4,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: spacingFactor * 10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: lightGrey,
                    ),
                    height: 4,
                    width: 4,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: spacingFactor * 40),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: white),
                    ),
                    height: 8,
                    width: 8,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: spacingFactor * 40),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: white,
                    ),
                    height: 8,
                    width: 8,
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


