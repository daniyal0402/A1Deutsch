import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vocabulary_client/models/VocabWord.dart';
import 'package:vocabulary_client/repo/sqf_repo.dart';
import 'package:vocabulary_client/repo/user_repo.dart';
import 'package:vocabulary_client/repo/vocab_repo.dart';
import 'dart:math';

class CardGameController extends ControllerMVC {
  List<VocabWord> words = [];
  List<VocabWord> unseen = [];
  VocabWord word;
  bool outOfLimit = false;
  bool loading = true;
  final _random = new Random();
  int unseenCount = 0;
  bool isRevealed = true;

  fetchWords() async {
    if (currentCardsHistory.value.left >= 1) {
      words = await getLocalData("w");
      unseen = words.where((element) => element.cardPlayed == 'no').toList();
      getNewWord();
      loading = false;
      unseenCount = unseen.length;
      setState(() {});
    } else {
      loading = false;
      outOfLimit = true;

      setState(() {});
    }
  }

  getNewWord() async {
    await checkAndUpdateReset();
    isRevealed = false;
    print(
        "CURRENT CARD HISTORY FROM CARDS: ${currentCardsHistory.value.toMap()}");
    if (currentCardsHistory.value.left >= 1) {
      outOfLimit = false;
      word = unseen[randomNum(0, unseen.length)];
      if (word.translation == null) {
        unseen.remove(word);
        getNewWord();
      }
    } else {
      outOfLimit = true;
    }
    setState(() {});
  }

  reveal() async {
    unseen.remove(word);
    currentCardsHistory.value.left = currentCardsHistory.value.left - 1;
    unseenCount = unseenCount - 1;
    await setCardHistory(currentCardsHistory.value);
    // getNewWord();
    await updateRowCardFlag(word);
    setState(() {});
  }

  int randomNum(int min, int max) => min + _random.nextInt(max - min);
}
