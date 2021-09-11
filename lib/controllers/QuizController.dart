import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:path/path.dart';
import 'package:vocabulary_client/helpers/AppConstants.dart';
import 'package:vocabulary_client/models/VocabWord.dart';
import 'package:vocabulary_client/repo/sqf_repo.dart';
import 'package:vocabulary_client/repo/user_repo.dart';
import 'package:vocabulary_client/repo/vocab_repo.dart';

class QuizController extends ControllerMVC {
  List<VocabWord> words = [];
  List<VocabWord> temp = [];
  List<VocabWord> unseen = [];
  List<VocabWord> options = [];
  VocabWord word;
  bool isArtikel = false;
  List<String> artikelOptions = ['die', 'der', 'das'];
  bool loading = true;
  bool outOfWords = false;
  int tappedIndex;
  final _random = new Random();
  bool picked = false;

  fetchWords() async {
    words = [];
    temp = [];
    unseen = [];
    options = [];
    words = await getLocalData("w");

    unseen = words.where((element) => element.cardPlayed == 'yes').toList();
    print("UNSEEN COUNT: ${unseen.length}");
    unseen = unseen
        .where((element) =>
            element.artikelPlayed == 'no' || element.translationPlayed == 'no')
        .toList();
    print("UNSEEN COUNT WHERE NO: ${unseen.length}");

    temp = words;
    loading = false;
    if (unseen.length > 0) {
      outOfWords = false;
      getNewWord();
    } else {
      outOfWords = true;
      setState(() {});
    }
    setState(() {});
  }

  getNewWord({shouldRemove = false}) {
    picked = false;
    // words = temp;
    words = [];
    temp.forEach((element) {
      words.add(element);
    });
    print(temp.length);
    options = [];
    setState(() {});
    if (unseen.length > 0) {
      word = unseen[randomNum(0, unseen.length)];
      if (word.artikelPlayed == 'no' && word.translationPlayed == 'no') {
        isArtikel = _random.nextBool();
      } else if (word.artikelPlayed == 'no' &&
          word.translationPlayed == 'yes') {
        isArtikel = true;
      } else if (word.artikelPlayed == 'yes' &&
          word.translationPlayed == 'no') {
        isArtikel = false;
      }
      if (isArtikel) {
        print("Is Artikel: " + isArtikel.toString());
        print("WORD ARTIKEL: " + word.artikel);
        if (!(word.artikel.trim().contains('die') ||
            word.artikel.trim().contains('der') ||
            word.artikel.trim().contains('das'))) {
          unseen.remove(word);
          getNewWord();
          // word = unseen[randomNum(0, unseen.length)];
        }
      } else {
        if (word.translation == null) {
          unseen.remove(word);
          getNewWord();
          // word = unseen[randomNum(0, unseen.length)];
        }
      }
      words.shuffle();
      words.remove(word);
      if (!isArtikel) {
        for (int i = 0; options.length < 5; i++) {
          if (isArtikel) {
            print("$i ${words[i].artikel.runtimeType}");
            if (words[i].artikel != null &&
                (words[i].artikel.contains('die') ||
                    words[i].artikel.contains('der') ||
                    words[i].artikel.contains('das'))) {
              print("$i ${words[i].artikel.runtimeType}");
              if (!options.contains(word)) options.add(words[i]);
            } else {
              options = [];
              getNewWord();
            }
          } else {
            if (words[i].translation != null) {
              print("$i ${words[i].artikel.runtimeType}");
              if (!options.contains(word)) options.add(words[i]);
            } else {
              options = [];

              getNewWord();
            }
          }
          // options.removeWhere((element) =>
          //     (element.artikel == null || element.artikel == "null") ||
          //     (element.translation == null || element.translation == "null"));
        }
      }
      // if (isArtikel) {
      //   final answerExists = options.firstWhere(
      //       (element) => element.artikel == word.artikel, orElse: () {
      //     return null;
      //   });
      //   if (answerExists == null) {
      //     options.add(word);
      //   }
      // }
      if (!isArtikel) if (!options.contains(word)) {
        options.add(word);
      }
      options.shuffle();
      setState(() {});
    } else {
      outOfWords = true;
    }
    print("SELECTED WORD ARTIKEL: ${word.artikel}");
    setState(() {});
  }

  selectAnswer({VocabWord pickedWord, String artikelOptions}) async {
    setState(() {
      picked = true;
    });
    if (isArtikel) {
      word.artikelPlayed = 'yes';
    } else {
      word.translationPlayed = 'yes';
    }
    if (isArtikel) {
      print("ARTIKEL OPTION: ${artikelOptions}");
      if (word.artikel.contains(artikelOptions)) {
        currentQuizScore.value.right = currentQuizScore.value.right + 1;
        if (word.artikelPlayed == 'yes' && word.translationPlayed == 'yes') {
          unseen.remove(word);
        }
        await updateRowArtikelFlag(word);
        await setQuizScore(currentQuizScore.value);
        setState(() {});
      } else {
        if (word.artikelPlayed == 'yes' && word.translationPlayed == 'yes') {
          unseen.remove(word);
        }
        currentQuizScore.value.wrong = currentQuizScore.value.wrong + 1;
        await updateRowArtikelFlag(word);
        await setQuizScore(currentQuizScore.value);
        setState(() {});
      }
    } else {
      if (pickedWord.translation == word.translation) {
        currentQuizScore.value.right = currentQuizScore.value.right + 1;
        if (word.artikelPlayed == 'yes' && word.translationPlayed == 'yes') {
          unseen.remove(word);
        }

        await updateRowTranslationFlag(word);
        await setQuizScore(currentQuizScore.value);
        setState(() {});
        // getNewWord();
      } else {
        if (word.artikelPlayed == 'yes' && word.translationPlayed == 'yes') {
          unseen.remove(word);
        }
        currentQuizScore.value.wrong = currentQuizScore.value.wrong + 1;
        await updateRowTranslationFlag(word);
        await setQuizScore(currentQuizScore.value);
        setState(() {});
        // getNewWord();
      }
    }
  }

  setColor(i) {
    if (picked) {
      if (tappedIndex == i) {
        if (isArtikel
            ? (word.artikel.contains(artikelOptions[i]))
            : (options[i].translation == word.translation)) {
          return AppConstants.greenColor;
        } else {
          return AppConstants.secondaryColor;
        }
      } else {
        if (isArtikel
            ? (word.artikel.contains(artikelOptions[i]))
            : (options[i].translation == word.translation)) {
          return AppConstants.greenColor;
        } else {
          return AppConstants.blackColor;
        }
      }
    } else {
      return AppConstants.blackColor;
    }
  }

  int randomNum(int min, int max) => min + _random.nextInt(max - min);
  bool randomBool() => _random.nextBool();
}
