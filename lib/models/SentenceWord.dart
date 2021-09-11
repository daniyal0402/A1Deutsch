// To parse this JSON data, do
//
//     final sentenceWord = sentenceWordFromMap(jsonString);

import 'dart:convert';

SentenceWord sentenceWordFromMap(String str) =>
    SentenceWord.fromMap(json.decode(str));

String sentenceWordToMap(SentenceWord data) => json.encode(data.toMap());

class SentenceWord {
  SentenceWord(
      {this.deutsch,
      this.deutschSentence,
      this.englishWord,
      this.englishSentence,
      this.languages,
      this.selectedLanguage,
      this.nativeSentence,
      this.translation});

  String deutsch;
  String deutschSentence;
  String englishWord;
  String englishSentence;
  String nativeSentence;
  String artikelPlayed;
  String translationPlayed;
  List<Language> languages;

  String selectedLanguage;
  String translation;

  factory SentenceWord.fromMap(Map<String, dynamic> json) => SentenceWord(
        deutsch: json["deutsch"] == null ? null : json["deutsch"],
        deutschSentence:
            json["deutsch_sentence"] == null ? null : json["deutsch_sentence"],
        englishWord: json["english_word"] == null ? null : json["english_word"],
        englishSentence:
            json["english_sentence"] == null ? null : json["english_sentence"],
        translation: json["translation"] == null ? null : json["translation"],
        nativeSentence:
            json["nativeSentence"] == null ? null : json["nativeSentence"],
        languages: json["languages"] == null
            ? null
            : List<Language>.from(
                json["languages"].map((x) => Language.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "deutsch": deutsch == null ? null : deutsch,
        "deutsch_sentence": deutschSentence == null ? null : deutschSentence,
        "english_word": englishWord == null ? null : englishWord,
        "english_sentence": englishSentence == null ? null : englishSentence,
        "translation": translation == null ? null : translation,
        "selectedLanguage": selectedLanguage == null ? null : selectedLanguage,
        "nativeSentence": nativeSentence == null ? null : nativeSentence,
        "languages": languages == null
            ? null
            : List<dynamic>.from(languages.map((x) => x.toMap())),
      };
}

class Language {
  Language({
    this.name,
    this.word,
    this.sentence,
  });

  String name;
  String word;
  String sentence;

  factory Language.fromMap(Map<String, dynamic> json) => Language(
        name: json["name"] == null ? null : json["name"],
        word: json["word"] == null ? null : json["word"],
        sentence: json["sentence"] == null ? null : json["sentence"],
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "word": word == null ? null : word,
        "sentence": sentence == null ? null : sentence,
      };
}
