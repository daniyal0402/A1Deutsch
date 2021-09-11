// To parse this JSON data, do
//
//     final quizScore = quizScoreFromMap(jsonString);

import 'dart:convert';

QuizScore quizScoreFromMap(String str) => QuizScore.fromMap(json.decode(str));

String quizScoreToMap(QuizScore data) => json.encode(data.toMap());

class QuizScore {
  QuizScore({
    this.right,
    this.wrong,
  });

  int right;
  int wrong;

  factory QuizScore.fromMap(Map<String, dynamic> json) => QuizScore(
        right: json["right"] == null ? null : json["right"],
        wrong: json["wrong"] == null ? null : json["wrong"],
      );

  Map<String, dynamic> toMap() => {
        "right": right == null ? null : right,
        "wrong": wrong == null ? null : wrong,
      };
}
