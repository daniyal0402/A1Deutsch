// // To parse this JSON data, do
// //
// //     final vocabWord = vocabWordFromMap(jsonString);

// import 'dart:convert';

// VocabWord vocabWordFromMap(String str) => VocabWord.fromMap(json.decode(str));

// String vocabWordToMap(VocabWord data) => json.encode(data.toMap());

// class VocabWord {
//   VocabWord(
//       {this.nr,
//       this.artikel,
//       this.deutsch,
//       this.plural,
//       this.definition,
//       this.wortart,
//       this.nomGenDatAkk,
//       this.rechtschreibungWorttrennung,
//       this.wortverbindungen,
//       this.grammatik,
//       this.english,
//       this.languages,
//       this.cardPlayed,
//       this.quizPlayed,
//       this.selectedLanguage,
//       this.translation});

//   String nr;
//   String artikel;
//   String deutsch;
//   String plural;
//   String definition;
//   String wortart;
//   String nomGenDatAkk;
//   String rechtschreibungWorttrennung;
//   String wortverbindungen;
//   String grammatik;
//   String english;
//   String cardPlayed;
//   String quizPlayed;
//   String selectedLanguage;
//   String translation;
//   List<Language> languages;

//   factory VocabWord.fromMap(Map<String, dynamic> json) => VocabWord(
//         nr: json["nr"] == null ? null : json["nr"],
//         artikel: json["artikel"] == null ? null : json["artikel"],
//         deutsch: json["deutsch"] == null ? null : json["deutsch"],
//         plural: json["plural"] == null ? null : json["plural"],
//         definition: json["definition"] == null ? null : json["definition"],
//         wortart: json["wortart"] == null ? null : json["wortart"],
//         nomGenDatAkk:
//             json["nom_gen_dat_akk"] == null ? null : json["nom_gen_dat_akk"],
//         rechtschreibungWorttrennung:
//             json["rechtschreibung_worttrennung"] == null
//                 ? null
//                 : json["rechtschreibung_worttrennung"],
//         wortverbindungen:
//             json["wortverbindungen"] == null ? null : json["wortverbindungen"],
//         grammatik: json["grammatik"] == null ? null : json["grammatik"],
//         english: json["english"] == null ? null : json["english"],
//         translation: json["translation"] == null ? null : json["translation"],
//         cardPlayed: json["cardPlayed"] == null ? null : json["cardPlayed"],
//         quizPlayed: json["quizPlayed"] == null ? null : json["quizPlayed"],
//         languages: json["languages"] == null
//             ? null
//             : List<Language>.from(
//                 json["languages"].map((x) => Language.fromMap(x))),
//       );

//   Map<String, dynamic> toMap() => {
//         "nr": nr == null ? null : nr,
//         "artikel": artikel == null ? null : artikel,
//         "deutsch": deutsch == null ? null : deutsch,
//         "plural": plural == null ? null : plural,
//         "definition": definition == null ? null : definition,
//         "wortart": wortart == null ? null : wortart,
//         "nom_gen_dat_akk": nomGenDatAkk == null ? null : nomGenDatAkk,
//         "rechtschreibung_worttrennung": rechtschreibungWorttrennung == null
//             ? null
//             : rechtschreibungWorttrennung,
//         "wortverbindungen": wortverbindungen == null ? null : wortverbindungen,
//         "grammatik": grammatik == null ? null : grammatik,
//         "english": english == null ? null : english,
//         "languages": languages == null
//             ? null
//             : List<dynamic>.from(languages.map((x) => x.toMap())),
//         "cardPlayed": cardPlayed == null ? null : cardPlayed,
//         "quizPlayed": quizPlayed == null ? null : quizPlayed,
//         "translation": translation == null ? null : translation,
//         "selectedLanguage": selectedLanguage == null ? null : selectedLanguage,
//       };
// }

// class Language {
//   Language({
//     this.name,
//     this.translation,
//   });

//   String name;
//   String translation;

//   factory Language.fromMap(Map<String, dynamic> json) => Language(
//         name: json["name"] == null ? null : json["name"],
//         translation: json["translation"] == null ? null : json["translation"],
//       );

//   Map<String, dynamic> toMap() => {
//         "name": name == null ? null : name,
//         "translation": translation == null ? null : translation,
//       };
// }

import 'dart:convert';

VocabWord vocabWordFromMap(String str) => VocabWord.fromMap(json.decode(str));

String vocabWordToMap(VocabWord data) => json.encode(data.toMap());

class VocabWord {
  VocabWord(
      {this.uid,
      this.artikel,
      this.deutsch,
      this.grammatik,
      this.definition,
      this.english,
      this.languages,
      this.cardPlayed,
      this.artikelPlayed,
      this.translationPlayed,
      this.selectedLanguage,
      this.translation});

  String uid;
  String artikel;
  String deutsch;
  String grammatik;
  String definition;
  String english;
  String cardPlayed;
  String artikelPlayed;
  String translationPlayed;
  String selectedLanguage;
  String translation;
  List<Language> languages;

  factory VocabWord.fromMap(Map<String, dynamic> json) => VocabWord(
        uid: json["uid"] == null ? null : json["uid"],
        artikel: json["artikel"] == null ? null : json["artikel"],
        deutsch: json["deutsch"] == null ? null : json["deutsch"],
        grammatik: json["grammatik"] == null ? null : json["grammatik"],
        definition: json["definition"] == null ? null : json["definition"],
        english: json["english"] == null ? null : json["english"],
        translation: json["translation"] == null ? null : json["translation"],
        cardPlayed: json["cardPlayed"] == null ? null : json["cardPlayed"],
        artikelPlayed:
            json["artikelPlayed"] == null ? null : json["artikelPlayed"],
        translationPlayed: json["translationPlayed"] == null
            ? null
            : json["translationPlayed"],
        languages: json["languages"] == null
            ? null
            : List<Language>.from(
                json["languages"].map((x) => Language.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "uid": uid == null ? null : uid,
        "artikel": artikel == null ? null : artikel,
        "deutsch": deutsch == null ? null : deutsch,
        "grammatik": grammatik == null ? null : grammatik,
        "definition": definition == null ? null : definition,
        "english": english == null ? null : english,
        "cardPlayed": cardPlayed == null ? null : cardPlayed,
        "artikelPlayed": artikelPlayed == null ? null : artikelPlayed,
        "translationPlayed":
            translationPlayed == null ? null : translationPlayed,
        "translation": translation == null ? null : translation,
        "selectedLanguage": selectedLanguage == null ? null : selectedLanguage,
        "languages": languages == null
            ? null
            : List<dynamic>.from(languages.map((x) => x.toMap())),
      };
}

class Language {
  Language({
    this.name,
    this.translation,
  });

  String name;
  String translation;

  factory Language.fromMap(Map<String, dynamic> json) => Language(
        name: json["name"] == null ? null : json["name"],
        translation: json["translation"] == null ? null : json["translation"],
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "translation": translation == null ? null : translation,
      };
}
