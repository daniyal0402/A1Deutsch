import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocabulary_client/models/AppUser.dart';
import 'package:vocabulary_client/models/CardHistory.dart';
import 'package:vocabulary_client/models/QuizScore.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

SharedPreferences prefs;
ValueNotifier<String> translationLanguage = new ValueNotifier(null);
ValueNotifier<AppUser> currentUser = new ValueNotifier(AppUser());
ValueNotifier<CardsHistory> currentCardsHistory = new ValueNotifier(null);
ValueNotifier<QuizScore> currentQuizScore = new ValueNotifier(null);

getUserByCode(String accessCode) async {
  AppUser user = AppUser();
  try {
    QuerySnapshot _userQuery = await _firestore
        .collection('users')
        .where('access_code', isEqualTo: accessCode)
        .where('is_active', isEqualTo: true)
        .get();
    if (_userQuery.docs.length > 0) {
      user = AppUser.fromMap(_userQuery.docs[0].data());
      await _firestore
          .collection('users')
          .doc(accessCode)
          .update({'is_active': false});
    }
  } catch (e) {
    print(e.toString());
  }
  return user;
}

setLanguage(String language) async {
  prefs = await SharedPreferences.getInstance();
  await prefs.setString('lang', language);
  translationLanguage.value = language;
  return true;
}

getLanguage() async {
  prefs = await SharedPreferences.getInstance();
  String _lang = await prefs.getString('lang');
  return _lang;
}

getDBLock() async {
  prefs = await SharedPreferences.getInstance();
  bool _lock = await prefs.getBool('lock');
  return _lock;
}

setDBLock(bool lock) async {
  prefs = await SharedPreferences.getInstance();
  await prefs.setBool('lock', lock);
  return true;
}

setFetch(bool fetched, String type) async {
  prefs = await SharedPreferences.getInstance();
  if (type == 's') {
    await prefs.setBool('sfetched', fetched);
    return true;
  } else {
    await prefs.setBool('wfetched', fetched);
    return true;
  }
}

Future<AppUser> getUser() async {
  prefs = await SharedPreferences.getInstance();
  String user = prefs.getString("currentUser");
  if (user != null) {
    return AppUser.fromMap(json.decode(prefs.getString("currentUser")));
  } else {
    return AppUser();
  }
}

setUser(AppUser appUser) async {
  var user = appUser.toMap();
  prefs = await SharedPreferences.getInstance();
  await prefs.setString("currentUser", json.encode(user));
}

Future<CardsHistory> getCardHistory() async {
  prefs = await SharedPreferences.getInstance();
  String historyString = prefs.getString("cardHistory");
  if (historyString != null) {
    return CardsHistory.fromMap(json.decode(prefs.getString("cardHistory")));
  } else {
    return CardsHistory();
  }
}

setCardHistory(CardsHistory cardsHistory) async {
  var history = cardsHistory.toMap();
  prefs = await SharedPreferences.getInstance();
  await prefs.setString("cardHistory", json.encode(history));
}

updateCardHistory(int newLimit) async {
  int played = currentCardsHistory.value.limit - currentCardsHistory.value.left;
  int leftUpdated = newLimit - played;
  leftUpdated < 0 ? leftUpdated = 0 : null;
  currentCardsHistory.value.left = leftUpdated;
  currentCardsHistory.value.limit = newLimit;
  var history = currentCardsHistory.value.toMap();
  prefs = await SharedPreferences.getInstance();
  print("UPDATED CARD HISTORY");
  print(currentCardsHistory.value.toMap());
  await prefs.setString("cardHistory", json.encode(history));
}

getFetch(String type) async {
  prefs = await SharedPreferences.getInstance();
  if (type == 'w') {
    bool _fetched = await prefs.getBool('wfetched');
    return _fetched;
  } else {
    bool _fetched = await prefs.getBool('sfetched');
    return _fetched;
  }
}

Future<QuizScore> getQuizScore() async {
  prefs = await SharedPreferences.getInstance();
  String quizScoreString = prefs.getString("quizScore");
  if (quizScoreString != null) {
    return QuizScore.fromMap(json.decode(prefs.getString("quizScore")));
  } else {
    return QuizScore();
  }
}

setQuizScore(QuizScore quizScore) async {
  var score = quizScore.toMap();
  prefs = await SharedPreferences.getInstance();
  await prefs.setString("quizScore", json.encode(score));
}

getLanguages() async {
  List<String> _languages = [];
  try {
    DocumentSnapshot _langDoc =
        await _firestore.collection('misc').doc('languageList').get();
    Map<String, dynamic> data = _langDoc.data();
    List languages = data['languages'];
    languages.forEach((l) {
      _languages.add(l['name']);
    });
  } catch (e) {
    print(e.toString());
  }

  return _languages;
}

checkAndUpdateReset() async {
  CardsHistory _history = await getCardHistory();
  DateTime _current = DateTime.now();
  int difference = _history.lastReset.difference(_current).inHours;
  bool isNewDay = _current.difference(_history.lastReset).inHours >= 24;
  print("IS NEW DAY");
  print(isNewDay);
  if (isNewDay) {
    _history.lastReset = _current;
    _history.left = _history.limit;
    await setCardHistory(_history);
    currentCardsHistory.value = _history;
  }
}

userCheck(int val) {
  if (currentUser.value.accessCode == null) {
    if (val > 100) {
      return 100;
    } else {
      return val;
    }
  } else {
    return val;
  }
}
