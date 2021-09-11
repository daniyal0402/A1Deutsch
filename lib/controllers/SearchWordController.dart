import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vocabulary_client/helpers/AppConstants.dart';
import 'package:vocabulary_client/models/VocabWord.dart';
import 'package:vocabulary_client/repo/vocab_repo.dart';
import 'package:easy_localization/easy_localization.dart';

class SearchWordController extends ControllerMVC {
  String searchTerm = '';
  List<VocabWord> words = [];
  List<VocabWord> tempWords = [];
  bool isLoading = true;
  fetchWords() async {
    words = await getLocalData("w");
    tempWords = words;
    isLoading = false;
    setState(() {});
  }

  refreshSearch() {
    List<VocabWord> searchRelatedWords = [];
    if (searchTerm.isNotEmpty) {
      searchRelatedWords = tempWords.where((word) {
        // if (word.translation != null &&
        //     word.deutsch != null &&
        //     word.english != null) {
        //   return (word.deutsch
        //           .toLowerCase()
        //           .contains(searchTerm.toLowerCase()) ||
        //       (word.english
        //               .toString()
        //               .toLowerCase()
        //               .contains(searchTerm.toLowerCase()) ||
        //           (word.translation
        //               .toString()
        //               .toLowerCase()
        //               .contains(searchTerm.toLowerCase()))));
        // } else {
        //   return false;
        // }
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

  void showDetailsSheet(VocabWord word) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(15),
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
                      Row(
                        children: [
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
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "\t\t(${word.artikel})",
                              style: TextStyle(
                                fontSize: 14,
                                color: AppConstants.greenColor,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              FlutterTts _flutterTts = FlutterTts();
                              await _flutterTts.setLanguage('en-US');
                              await _flutterTts.speak(word.english);
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
                              "${(word.english == null || word.english.isEmpty) ? '' : word.english}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 150,
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Native Language".tr(),
                              style: TextStyle(
                                  fontSize: 18,
                                  color: AppConstants.primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            width: 150,
                            child: Text(
                              "${(word.translation == null || word.translation.isEmpty) ? '' : word.translation}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Definition".tr(),
                          style: TextStyle(
                              fontSize: 18,
                              color: AppConstants.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${(word.definition == null || word.definition.isEmpty) ? '-' : word.definition}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Grammar".tr(),
                          style: TextStyle(
                              fontSize: 18,
                              color: AppConstants.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 140,
                        alignment: Alignment.topLeft,
                        child: Text(
                          "${(word.grammatik == null || word.grammatik.isEmpty) ? '-' : word.grammatik}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
