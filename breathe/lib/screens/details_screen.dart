import 'package:flutter/material.dart';

import '../constants.dart';
import '../constants.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          height: size.height * .45,
          decoration: BoxDecoration(
            color: kBlueLightColor,
            image: DecorationImage(
              image: AssetImage("assets/images/meditation_bg.png"),
            ),
          ),
        ),
      ],
    ));
  }
}
