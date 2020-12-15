import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
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
                  image: AssetImage("assets/images/meditation_bg.png"),
                  fit: BoxFit.fitWidth,
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
                          isDone: true,
                          srcSound: "sounds/music.mp3",
                          press: () {},
                        ),
                        SeassonCard(
                          seassionNum: 2,
                          press: () {},
                        ),
                        SeassonCard(
                          seassionNum: 3,
                          press: () {},
                        ),
                        SeassonCard(
                          seassionNum: 4,
                          press: () {},
                        ),
                        SeassonCard(
                          seassionNum: 5,
                          press: () {},
                        ),
                        SeassonCard(
                          seassionNum: 6,
                          press: () {},
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Meditação",
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
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
                                  "Básico 2",
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Text("Comece a sua prática de aprofundamento")
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset("assets/icons/Lock.svg"),
                          )
                        ],
                      ),
                    )
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
  final bool isDone;
  final Function press;
  final String srcSound;
  const SeassonCard({
    Key key,
    this.seassionNum,
    this.isDone = false,
    this.press,
    this.srcSound,
  }) : super(key: key);

  @override
  _SeassonCardState createState() => _SeassonCardState();
}

class _SeassonCardState extends State<SeassonCard> {
  bool playing = false;
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
                if (!playing) {
                  setState(() {
                    cache.load(widget.srcSound);
                    cache.play(widget.srcSound);
                    playBtn = Icons.pause;
                    playing = true;
                  });
                } else {
                  setState(() {
                    _player.pause();
                    playBtn = Icons.play_arrow;
                    playing = false;
                  });
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 42,
                      width: 43,
                      decoration: BoxDecoration(
                        color: widget.isDone ? kBlueColor : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: kBlueColor),
                      ),
                      child: Icon(
                        playBtn,
                        color: widget.isDone ? Colors.white : kBlueColor,
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
