import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vocabulary_client/UI/widgets/MyDrawer.dart';
import 'package:vocabulary_client/controllers/QuizController.dart';
import 'package:vocabulary_client/helpers/AppConstants.dart';
import 'package:vocabulary_client/repo/user_repo.dart';
import 'package:easy_localization/easy_localization.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

QuizController _con;

class _QuizState extends StateMVC<Quiz> {
  _QuizState() : super(QuizController()) {
    _con = controller;
  }
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();
  void _toggle() {
    _innerDrawerKey.currentState.toggle(direction: InnerDrawerDirection.start);
  }

  double _crossAxisSpacing = 8, _mainAxisSpacing = 12, _aspectRatio = 2;
  int _crossAxisCount = 2;

  @override
  void initState() {
    super.initState();
    _con.fetchWords();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var width = (screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var height = width / _aspectRatio;

    return MyDrawer(
        stateSetter: (f) {
          AppConstants.updateLocaleIfNeeded(f, context);
          setState(() {});
        },
        quizScoreReset: () {
          _con.fetchWords();
          setState(() {});
        },
        innerDrawerKey: _innerDrawerKey,
        scaffold: Scaffold(
            appBar: AppBar(
              backgroundColor: AppConstants.whiteColor,
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
                : _con.outOfWords
                    ? Center(
                        child: Text(
                          "Out of words".tr(),
                          style: TextStyle(
                            color: AppConstants.secondaryColor,
                            fontSize: 18,
                          ),
                        ),
                      )
                    : Container(
                        color: AppConstants.backgroundGreyColor,
                        padding: EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Right".tr() +
                                        ": ${currentQuizScore.value.right}",
                                    style: TextStyle(
                                      color: Colors.green,
                                    ),
                                  ),
                                  Text(
                                    "Wrong".tr() +
                                        ": ${currentQuizScore.value.wrong}",
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: RichText(
                                text: new TextSpan(
                                  style: TextStyle(
                                    color: AppConstants.blackColor,
                                    fontSize: 22,
                                  ),
                                  children: <TextSpan>[
                                    new TextSpan(
                                      text: _con.isArtikel
                                          ? "Artikel Question Quiz".tr()
                                          : "Translation Question Quiz".tr(),
                                    ),
                                    new TextSpan(
                                      text: _con.word.deutsch,
                                      style: TextStyle(
                                        color: AppConstants.peachColor,
                                        fontSize: 22,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 400,
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _con.tappedIndex = 0;
                                      setState(() {});
                                      _con.getNewWord();
                                    },
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Next".tr(),
                                            style: TextStyle(
                                              color:
                                                  AppConstants.secondaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: AppConstants.secondaryColor,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  _con.isArtikel
                                      ? Container(
                                          height: 320,
                                          child: GridView.builder(
                                            itemCount:
                                                _con.artikelOptions.length,
                                            itemBuilder: (context, index) =>
                                                GestureDetector(
                                              onTap: () {
                                                if (_con.picked == false) {
                                                  _con.selectAnswer(
                                                      artikelOptions:
                                                          _con.artikelOptions[
                                                              index]);
                                                  _con.tappedIndex = index;
                                                  setState(() {});
                                                }
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: _con.setColor(index),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(
                                                      20,
                                                    ),
                                                  ),
                                                ),
                                                child: Text(
                                                  _con.artikelOptions[index],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: _crossAxisCount,
                                              crossAxisSpacing:
                                                  _crossAxisSpacing,
                                              mainAxisSpacing: _mainAxisSpacing,
                                              childAspectRatio: _aspectRatio,
                                            ),
                                          ),
                                        )
                                      : Container(
                                          height: 320,
                                          child: GridView.builder(
                                            itemCount: _con.options.length,
                                            itemBuilder: (context, index) =>
                                                GestureDetector(
                                              onTap: () {
                                                if (_con.picked == false) {
                                                  _con.selectAnswer(
                                                      pickedWord:
                                                          _con.options[index]);
                                                  _con.tappedIndex = index;
                                                  setState(() {});
                                                }
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: _con.setColor(index),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(
                                                      20,
                                                    ),
                                                  ),
                                                ),
                                                child: Text(
                                                  _con.isArtikel
                                                      ? (_con.options[index]
                                                                  .artikel ==
                                                              "null"
                                                          ? "-"
                                                          : _con.options[index]
                                                              .artikel)
                                                      : (_con.options[index]
                                                                  .translation ==
                                                              "null"
                                                          ? "-"
                                                          : _con.options[index]
                                                              .translation),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: _crossAxisCount,
                                              crossAxisSpacing:
                                                  _crossAxisSpacing,
                                              mainAxisSpacing: _mainAxisSpacing,
                                              childAspectRatio: _aspectRatio,
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )));
  }
}
