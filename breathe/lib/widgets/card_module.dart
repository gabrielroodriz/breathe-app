import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class CardModule extends StatelessWidget {
  final String title;
  final String description;
  final Widget srcScreen;

  const CardModule({
    Key key,
    this.title,
    this.description,
    this.srcScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.all(10),
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 17),
            blurRadius: 23,
            spreadRadius: -13,
            color: kShadowColor,
          )
        ],
      ),
      child: Row(
        children: <Widget>[
          SvgPicture.asset(
            "assets/icons/Meditation_women_small.svg",
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(description)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return srcScreen;
                  }),
                );
              },
              child: Icon(
                Icons.play_arrow,
                color: kBlueColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
