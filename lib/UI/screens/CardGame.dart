import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vocabulary_client/UI/widgets/MyDrawer.dart';
import 'package:vocabulary_client/repo/vocab_repo.dart';
import 'package:vocabulary_client/controllers/CardGameController.dart';
import 'package:vocabulary_client/helpers/AppConstants.dart';
import 'package:vocabulary_client/repo/user_repo.dart';
import 'package:easy_localization/easy_localization.dart';

class CardGame extends StatefulWidget {
  @override
  _CardGameState createState() => _CardGameState();
}

CardGameController _con;
final GlobalKey<InnerDrawerState> _innerDrawerKey =
    GlobalKey<InnerDrawerState>();
void _toggle() {
  _innerDrawerKey.currentState.toggle(direction: InnerDrawerDirection.start);
}

class _CardGameState extends StateMVC<CardGame> {
  _CardGameState() : super(CardGameController()) {
    _con = controller;
  }
  bool _showFrontSide;
  bool _flipXAxis;

  @override
  void initState() {
    super.initState();
    _showFrontSide = true;
    _flipXAxis = true;
    _con.fetchWords();
  }

  @override
  Widget build(BuildContext context) {
    return MyDrawer(
      stateSetter: (func) {
        AppConstants.updateLocaleIfNeeded(func, context);

        setState(() {
          if (func == "fetch") {
            _con.fetchWords();
          }
        });
      },
      innerDrawerKey: _innerDrawerKey,
      scaffold: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              _toggle();
            },
            child: Icon(
              Icons.menu,
              size: 35,
              color: AppConstants.secondaryColor,
            ),
          ),
        ),
        body: _con.loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _con.outOfLimit
                ? Center(
                    child: Text(
                      "You have completed all the cards for today".tr(),
                      style: TextStyle(
                        color: AppConstants.secondaryColor,
                        fontSize: 18,
                      ),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text("Unseen".tr() + ": ${_con.unseenCount}"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text("Due".tr() +
                              ": ${currentCardsHistory.value.left}"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(child: _buildFlipAnimation())
                      ],
                    ),
                  ),
      ),
    );
  }

  void _changeRotationAxis() {
    setState(() {
      _flipXAxis = !_flipXAxis;
    });
  }

  void _switchCard() {
    setState(() {
      _showFrontSide = !_showFrontSide;
    });
  }

  Widget _buildFlipAnimation() {
    return GestureDetector(
      // onTap: _switchCard,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 800),
        transitionBuilder: __transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget, ...list]),
        child: _showFrontSide ? _buildFront() : _buildRear(),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
      ),
    );
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_showFrontSide) != widget.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: _flipXAxis
              ? (Matrix4.rotationY(value)..setEntry(3, 0, tilt))
              : (Matrix4.rotationX(value)..setEntry(3, 1, tilt)),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }

  Widget _buildFront() {
    return __buildLayout(
      key: ValueKey(true),
      backgroundColor: Colors.blue,
      faceName: "Front",
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcATop),
          child: FlutterLogo(),
        ),
      ),
    );
  }

  Widget _buildRear() {
    return __buildLayout(
      key: ValueKey(false),
      backgroundColor: Colors.blue.shade700,
      faceName: "Rear",
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcATop),
          child:
              Center(child: Text("Flutter", style: TextStyle(fontSize: 50.0))),
        ),
      ),
    );
  }

  Widget __buildLayout(
      {Key key, Widget child, String faceName, Color backgroundColor}) {
    return Container(
      key: key,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20.0),
        color: backgroundColor,
      ),
      child: faceName == "Front"
          ? Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppConstants.blackColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    20,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () async {
                        // speak("${_con.word.deutsch}", context);
                        FlutterTts _flutterTts = FlutterTts();
                        await _flutterTts.setLanguage('de-DE');
                        await _flutterTts.speak(_con.word.deutsch);
                      },
                      child: Icon(
                        Icons.volume_up,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      "${_con.word.deutsch}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_con.isRevealed == false) {
                        _con.reveal();
                      }
                      _switchCard();
                    },
                    child: Container(
                      child: Icon(
                        Icons.visibility,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  )
                ],
              ),
            )
          : Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppConstants.secondaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    20,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.volume_up,
                        color: Colors.white,
                        size: 1,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      "${_con.word.translation}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // _con.reveal();
                      _con.getNewWord();
                      // _con.isRevealed = true;
                      _switchCard();
                    },
                    child: Container(
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
