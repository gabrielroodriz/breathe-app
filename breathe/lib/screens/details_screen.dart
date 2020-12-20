import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:breathe/screens/step_eight/detatils_eight_step.dart';
import 'package:breathe/screens/step_five/detatils_five_step.dart';
import 'package:breathe/screens/step_four/detatils_four_step.dart';
import 'package:breathe/screens/step_nine/detatils_nine_step.dart';
import 'package:breathe/screens/step_one/detatils_first_step.dart';
import 'package:breathe/screens/step_seven/detatils_seven_step.dart';
import 'package:breathe/screens/step_six/detatils_six_step.dart';
import 'package:breathe/screens/step_ten/detatils_ten_step.dart';
import 'package:breathe/screens/step_three/detatils_three_step.dart';
import 'package:breathe/screens/step_two/detatils_two_step.dart';
import 'package:breathe/widgets/bottom_nav_bar.dart';
import 'package:breathe/widgets/search-bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        bottomNavigationBar: BottomNavBar(),
        body: Stack(
          children: <Widget>[
            Container(
              height: size.height * .45,
              decoration: BoxDecoration(
                color: kBlueLightColor,
                image: DecorationImage(
                  alignment: Alignment.bottomRight,
                  image: AssetImage("assets/images/meditation_bg.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SafeArea(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Text(
                      'Meditação',
                      style: Theme.of(context)
                          .textTheme
                          .display1
                          .copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "3-10 Min de duração",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: size.width * .6,
                      child: Text(
                        "Viver mais feliz e mais saudável, aprendendo os fundamentos da meditação e da atenção",
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.5,
                      child: SearchBar(),
                    ),
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: <Widget>[
                        SeassonCard(
                          seassionNum: 1,
                          press: () {},
                          srcScreen: DetailsScreenFirstStep(),
                        ),
                        SeassonCard(
                          seassionNum: 2,
                          press: () {},
                          srcScreen: DetailsScreenSecondStep(),
                        ),
                        SeassonCard(
                          seassionNum: 3,
                          press: () {},
                          srcScreen: DetailsScreenThreeStep(),
                        ),
                        SeassonCard(
                          seassionNum: 4,
                          press: () {},
                          srcScreen: DetailsScreenFourStep(),
                        ),
                        SeassonCard(
                          seassionNum: 5,
                          press: () {},
                          srcScreen: DetailsScreenFiveStep(),
                        ),
                        SeassonCard(
                          seassionNum: 6,
                          press: () {},
                          srcScreen: DetailsScreenSixStep(),
                        ),
                        SeassonCard(
                          seassionNum: 7,
                          press: () {},
                          srcScreen: DetailsScreenSevenStep(),
                        ),
                        SeassonCard(
                          seassionNum: 8,
                          press: () {},
                          srcScreen: DetailsScreenEightStep(),
                        ),
                        SeassonCard(
                          seassionNum: 9,
                          press: () {},
                          srcScreen: DetailsScreenNineStep(),
                        ),
                        SeassonCard(
                          seassionNum: 10,
                          press: () {},
                          srcScreen: DetailsScreenTenStep(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ))
          ],
        ));
  }
}

class SeassonCard extends StatefulWidget {
  final int seassionNum;
  final Function press;
  final Widget srcScreen;
  const SeassonCard({
    Key key,
    this.seassionNum,
    this.press,
    this.srcScreen,
  }) : super(key: key);

  @override
  _SeassonCardState createState() => _SeassonCardState();
}

class _SeassonCardState extends State<SeassonCard> {
  bool playing = false;
  bool isDone = false;

  IconData playBtn = Icons.play_arrow;

  AudioPlayer _player;
  AudioCache cache;

  Duration position = new Duration();
  Duration musicLength = new Duration();

  Widget slider() {
    return Slider.adaptive(
        activeColor: kBlueColor,
        inactiveColor: kBlueLightColor,
        value: position.inSeconds.toDouble(),
        max: musicLength.inSeconds.toDouble(),
        onChanged: (value) {
          seekToSec(value.toInt());
        });
  }

  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _player = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);

    _player.durationHandler = (d) {
      setState(() {
        musicLength = d;
      });
    };

    _player.positionHandler = (p) {
      setState(() {
        position = p;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Container(
          width: constraint.maxWidth / 2 - 10,
          // padding: EdgeInsets.all(16),
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
              ]),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                setState(() {
                  isDone = true;
                  playBtn = Icons.pause;
                  playing = true;
                });

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return widget.srcScreen;
                  }),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 42,
                      width: 43,
                      decoration: BoxDecoration(
                        color: isDone ? kBlueColor : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: kBlueColor),
                      ),
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: isDone ? Colors.white : kBlueColor,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Passo ${widget.seassionNum}",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
