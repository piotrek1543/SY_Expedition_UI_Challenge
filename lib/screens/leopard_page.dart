import 'package:flutter/material.dart';
import 'package:syexpedition/position_helpers.dart';
import 'package:syexpedition/widgets/leopard_description.dart';
import 'package:syexpedition/widgets/the_72_text.dart';
import 'package:syexpedition/widgets/travel_description_label.dart';

class LeopardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: topMargin(context)),
        The72Text(),
        SizedBox(height: 32),
        TravelDescriptionLabel(),
        SizedBox(height: 32),
        LeopardDescription(),
      ],
    );
  }
}
