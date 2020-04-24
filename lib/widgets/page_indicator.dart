import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syexpedition/notifiers/page_offset_notifier.dart';
import 'package:syexpedition/styles/styles.dart';
import 'package:syexpedition/widgets/map_hider.dart';

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
