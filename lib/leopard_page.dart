import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'main_page.dart';

class LeopardImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<PageOffsetNotifier, AnimationController>(
      builder: (context, notifier, animation, child) {
        return Positioned(
          left: -0.85 * notifier.offset,
          width: MediaQuery.of(context).size.width * 1.6,
          child: Transform.scale(
            alignment: Alignment(0.6, 0),
            scale: 1 - 0.1 * animation.value,
            child: Opacity(
              opacity: 1 - 0.6 * animation.value,
              child: child,
            ),
          ),
        );
      },
      child: IgnorePointer(
        child: Image.asset('assets/leopard.png'),
      ),
    );
  }
}

class LeopardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 128),
        The72Text(),
        SizedBox(height: 32),
        TravelDescriptionLabel(),
        SizedBox(height: 32),
        LeopardDescription(),
      ],
    );
  }
}

class TravelDescriptionLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        return Opacity(
          opacity: math.max(0, 1 - 4 * notifier.page),
          child: child,
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 24),
        child: Text(
          'Travel description',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class LeopardDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        return Opacity(
          opacity: math.max(0, 1 - 4 * notifier.page),
          child: child,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Text(
          'The leopard is distinguished by its well-camouflaged fur, opportunistic hunting behaviour, broad diet, and strength.',
          style: TextStyle(fontSize: 13, color: lightGrey),
        ),
      ),
    );
  }
}

class The72Text extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        return Transform.translate(
          offset: Offset(-48 - 0.5 * notifier.offset, 0),
          child: child,
        );
      },
      child: Container(
        alignment: Alignment.topLeft,
        child: RotatedBox(
          quarterTurns: 1,
          child: Container(
            width: 400,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Text(
                '72',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
