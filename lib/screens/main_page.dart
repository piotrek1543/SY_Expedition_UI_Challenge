import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syexpedition/notifiers/map_animation_notifier.dart';
import 'package:syexpedition/notifiers/page_offset_notifier.dart';
import 'package:syexpedition/position_helpers.dart';
import 'package:syexpedition/screens/vulture_page.dart';
import 'package:syexpedition/widgets/arrow_icon.dart';
import 'package:syexpedition/widgets/base_camp_label.dart';
import 'package:syexpedition/widgets/base_time_label.dart';
import 'package:syexpedition/widgets/curved_route.dart';
import 'package:syexpedition/widgets/distance_label.dart';
import 'package:syexpedition/widgets/horizontal_travel_dots.dart';
import 'package:syexpedition/widgets/leopard_image.dart';
import 'package:syexpedition/widgets/map_button.dart';
import 'package:syexpedition/widgets/animal_icon_label.dart';
import 'package:syexpedition/widgets/leopard_icon_label.dart';
import 'package:syexpedition/widgets/map_base_camp.dart';
import 'package:syexpedition/widgets/map_image.dart';
import 'package:syexpedition/widgets/map_leopards.dart';
import 'package:syexpedition/widgets/map_start_camp.dart';
import 'package:syexpedition/widgets/map_vultures.dart';
import 'package:syexpedition/widgets/page_indicator.dart';
import 'package:syexpedition/widgets/share_button.dart';
import 'package:syexpedition/widgets/start_camp_label.dart';
import 'package:syexpedition/widgets/start_time_label.dart';
import 'package:syexpedition/widgets/travel_detail_label.dart';
import 'package:syexpedition/widgets/vertical_travel_dots.dart';
import 'package:syexpedition/widgets/vulture_image.dart';

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
                        CurvedRoute(mediaPadding: mediaPadding),
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
