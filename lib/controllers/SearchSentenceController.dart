import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vocabulary_client/helpers/AppConstants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:vocabulary_client/models/SentenceWord.dart';
import 'package:vocabulary_client/repo/vocab_repo.dart';

class SearchSentencesController extends ControllerMVC {
  String searchTerm = '';
  List<SentenceWord> words = [];
  List<SentenceWord> tempWords = [];
  bool isLoading = true;

  fetchWords() async {
    words = await getLocalData("s");
    tempWords = words;
    isLoading = false;
    setState(() {});
    words.forEach((element) {
      print(element.toMap());
    });
  }

  refreshSearch() {
    List<SentenceWord> searchRelatedWords = [];
    if (searchTerm.isNotEmpty) {
      searchRelatedWords = tempWords.where((word) {
        // return (word.deutsch.toLowerCase().contains(searchTerm.toLowerCase()) ||
        //     (word.englishWord
        //             .toLowerCase()
        //             .contains(searchTerm.toLowerCase()) ||
        //         (word.translation
        //             .toLowerCase()
        //             .contains(searchTerm.toLowerCase()))));
        if (word.deutsch != null)
          return (word.deutsch
              .toLowerCase()
              .contains(searchTerm.toLowerCase()));
        return false;
      }).toList();
      words = searchRelatedWords;
    } else {
      words = tempWords;
    }
    setState(() {});
  }

  void showDetailsSheet(SentenceWord word) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppConstants.blackColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0))),
              child: Column(
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          FlutterTts _flutterTts = FlutterTts();
                          await _flutterTts.setLanguage('de-DE');
                          await _flutterTts.speak(word.deutsch);
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text(
                                "Deutsch",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: AppConstants.primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.volume_up,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${word.deutsch}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          word.deutschSentence == null
                              ? " "
                              : "${word.deutschSentence}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              FlutterTts _flutterTts = FlutterTts();
                              await _flutterTts.setLanguage('en-US');
                              await _flutterTts.speak(word.englishWord);
                            },
                            child: Container(
                              width: 150,
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Text(
                                    "English",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: AppConstants.primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.volume_up,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            width: 150,
                            child: Text(
                              "${(word.englishWord == null || word.englishWord.isEmpty) ? '' : word.englishWord}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            width: 150,
                            child: Text(
                              "${(word.englishSentence == null || word.englishSentence.isEmpty) ? '' : word.englishSentence}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          FlutterTts _flutterTts = FlutterTts();
                          await _flutterTts.setLanguage('de-DE');
                          await _flutterTts.speak(word.deutsch);
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text(
                                "Native Language",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: AppConstants.primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          word.translation == null
                              ? " "
                              : "${word.translation}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          word.nativeSentence == null
                              ? " "
                              : "${word.nativeSentence}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
