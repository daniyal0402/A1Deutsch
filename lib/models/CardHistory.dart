// To parse this JSON data, do
//
//     final cardsHistory = cardsHistoryFromMap(jsonString);

import 'dart:convert';

CardsHistory cardsHistoryFromMap(String str) =>
    CardsHistory.fromMap(json.decode(str));

String cardsHistoryToMap(CardsHistory data) => json.encode(data.toMap());

class CardsHistory {
  CardsHistory({
    this.limit,
    this.lastReset,
    this.left,
  });

  int limit;
  DateTime lastReset;
  int left;

  factory CardsHistory.fromMap(Map<String, dynamic> json) => CardsHistory(
        limit: json["limit"] == null ? null : json["limit"],
        lastReset: json["lastReset"] == null
            ? null
            : DateTime.parse(json["lastReset"]),
        left: json["left"] == null ? null : json["left"],
      );

  Map<String, dynamic> toMap() => {
        "limit": limit == null ? null : limit,
        "lastReset": lastReset == null ? null : lastReset.toIso8601String(),
        "left": left == null ? null : left,
      };
}
