import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:breathe/constants.dart';
import 'package:flutter/material.dart';

class PlayerFiveStepPractice extends StatefulWidget {
  @override
  _PlayerFiveStepPracticeState createState() => _PlayerFiveStepPracticeState();
}

class _PlayerFiveStepPracticeState extends State<PlayerFiveStepPractice> {
  bool playing = false;
  IconData playBtn = Icons.play_arrow_rounded;

  AudioPlayer _player;
  AudioCache cache;

  Duration position = new Duration();
  Duration musicLength = new Duration();

  Widget slider() {
    return Container(
      width: 300.0,
      child: Slider.adaptive(
          activeColor: kActiveIconColor,
          inactiveColor: Colors.grey[350],
          value: position.inSeconds.toDouble(),
          max: musicLength.inSeconds.toDouble(),
          onChanged: (value) {
            seekToSec(value.toInt());
          }),
    );
  }

  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
  }

  void seekToSecNextTenSec() {
    Duration newPos = Duration(seconds: position.inSeconds + 10);
    _player.seek(newPos);
  }

  void seekToSecReplayTenSec() {
    Duration newPos = Duration(seconds: position.inSeconds - 10);
    _player.seek(newPos);
  }

  @override
  void initState() {
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

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF83e377),
                Color(0xFFf1c453),
              ]),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 62.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      color: Colors.black.withOpacity(0.1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              iconSize: 45.0,
                              color: Colors.white,
                              onPressed: () {
                                seekToSecReplayTenSec();
                              },
                              icon: Icon(
                                Icons.replay_10_rounded,
                              ),
                            ),
                            IconButton(
                                iconSize: 60.0,
                                color: Colors.white,
                                onPressed: () {
                                  if (!playing) {
                                    cache.load(
                                        "sounds/Consiciencia metacognitiva - 05.m4a");
                                    cache.play(
                                        "sounds/Consiciencia metacognitiva - 05.m4a");
                                    setState(() {
                                      playBtn = Icons.pause_rounded;
                                      playing = true;
                                    });
                                  } else {
                                    setState(() {
                                      _player.pause();
                                      playBtn = Icons.play_arrow_rounded;
                                      playing = false;
                                    });
                                  }
                                },
                                icon: Icon(
                                  playBtn,
                                )),
                            IconButton(
                                iconSize: 45.0,
                                color: Colors.white,
                                onPressed: () {
                                  seekToSecNextTenSec();
                                },
                                icon: Icon(Icons.forward_10_rounded)),
                          ],
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${position.inMinutes}:${position.inSeconds.remainder(66)}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white),
                              ),
                              slider(),
                              Text(
                                "${musicLength.inMinutes}:${position.inSeconds.remainder(60)}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
