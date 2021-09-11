import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vocabulary_client/UI/screens/HomepageParent.dart';
import 'package:vocabulary_client/UI/screens/SelectLanguage.dart';
import 'package:vocabulary_client/models/CardHistory.dart';
import 'package:vocabulary_client/models/QuizScore.dart';
import 'package:vocabulary_client/repo/user_repo.dart';

class SplashController extends ControllerMVC {
  startTimer() async {
    setDBLock(false);
    Timer timer = Timer(Duration(seconds: 3), () async {
      CardsHistory cardsHistory = await getCardHistory();
      QuizScore quizScore = await getQuizScore();

      if (cardsHistory == null || cardsHistory.lastReset == null) {
        await setCardHistory(
            CardsHistory(lastReset: DateTime.now(), limit: 5, left: 5));
        currentCardsHistory.value = await getCardHistory();
      } else {
        await checkAndUpdateReset();
        currentCardsHistory.value = await getCardHistory();
      }

      if (quizScore == null || quizScore.right == null) {
        await setQuizScore(QuizScore(right: 0, wrong: 0));
        currentQuizScore.value = await getQuizScore();
      } else {
        currentQuizScore.value = await getQuizScore();
      }
      var lang = await getLanguage();
      if (lang == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (builder) => SelectLanguage()));
      } else if (lang == '') {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (builder) => SelectLanguage()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (builder) => HomePageParent()));
      }
    });
  }
}
