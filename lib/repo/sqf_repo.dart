import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:vocabulary_client/models/SentenceWord.dart' as s;
import 'package:vocabulary_client/models/VocabWord.dart';
import 'package:vocabulary_client/repo/user_repo.dart';
import 'package:vocabulary_client/repo/vocab_repo.dart';

Database db;
String path;

getDBPath() async {
  var databasesPath = await getDatabasesPath();
  path = join(databasesPath, 'vocab.db');
  print(path);
}

openDB() async {
  await getDBPath();
  try {
    db = await openDatabase(path, version: 1);
  } catch (e) {
    print("Error $e");
  }
}

initDb() async {
  await getDBPath();
  db = await openDatabase(path, version: 1,
      onCreate: (Database _db, int version) async {
    await _db.execute(
        'CREATE TABLE Words (id INTEGER PRIMARY KEY NULL, uid TEXT NULL, artikel TEXT NULL, deutsch TEXT NULL, grammatik TEXT NULL, definition TEXT NULL, english TEXT NULL, cardPlayed TEXT NULL, artikelPlayed TEXT NULL, translationPlayed TEXT NULL, languages TEXT NULL,translation TEXT NULL, selectedLanguage TEXT NULL)');
    await _db.execute(
        'CREATE TABLE Sentences (id INTEGER PRIMARY KEY NULL, deutsch TEXT NULL, deutsch_sentence TEXT NULL, english_word TEXT NULL, english_sentence TEXT NULL, translation TEXT NULL, selectedLanguage TEXT NULL, nativeSentence TEXT NULL, languages TEXT NULL)');
  });
}

insertWordRecord(VocabWord word) async {
  await initDb();
  // await db.transaction((txn) async {
  word.languages = null;
  word.artikelPlayed = 'no';
  word.translationPlayed = 'no';
  word.cardPlayed = 'no';
  word.selectedLanguage = translationLanguage.value;
  int res = await db.insert('Words', word.toMap());
  print("RES: $res");
  // });
  return;
  // await getWordsTable();
}

deleteWordsTable() async {
  await initDb();
  await db.transaction((txn) async {
    await txn.delete("Words");
  });
  return;
  // await getWordsTable();
}

deleteSentencesTable() async {
  await initDb();
  await db.transaction((txn) async {
    await txn.delete("Sentences");
  });
  return;
  // await getWordsTable();
}

insertWordBatch(List<VocabWord> words) async {
  await initDb();
  Batch batch;

  batch = db.batch();
  for (int i = 0; i < words.length; i++) {
    VocabWord word = words[i];
    word.languages = null;
    word.artikelPlayed = 'no';
    word.translationPlayed = 'no';
    word.cardPlayed = 'no';
    word.selectedLanguage = translationLanguage.value;
    batch.insert('Words', word.toMap());
    print("Inserted: $i");
  }
  await batch.commit(noResult: true);
  return;
}

insertSentenceBatch(List<s.SentenceWord> words) async {
  await initDb();
  Batch batch;

  batch = db.batch();
  for (int i = 0; i < words.length; i++) {
    s.SentenceWord word = words[i];
    word.languages = null;
    batch.insert('Sentences', word.toMap());
    print("Inserted: $i");
  }
  await batch.commit(noResult: true);
  return;
}

insertSentenceRecord(s.SentenceWord word) async {
  await initDb();
  await db.transaction((txn) async {
    word.languages = null;
    // word.selectedLanguage = translationLanguage.value;
    int res = await txn.insert('Sentences', word.toMap());
    print("RES: $res");
  });
  // await getSentencesTable();
}

getWordsTable() async {
  await initDb();
  List<Map<String, dynamic>> dbList;
  List<VocabWord> _words = [];
  await db.transaction((txn) async {
    dbList = await txn.rawQuery('SELECT * FROM Words');
  });
  dbList.forEach((w) {
    VocabWord word = VocabWord.fromMap(w);

    _words.add(word);
  });

  return _words;
}

// multiplyRecords() async {
//   List<VocabWord> words = await getWords();
//   for (int i = 0; i < 12; i++) {
//     for (int j = 0; j < words.length; j++) {
//       print(j);
//       await insertWordRecord(words[j]);
//     }
//   }
// }

getSentencesTable() async {
  await initDb();
  List<Map<String, dynamic>> dbList;
  List<s.SentenceWord> _words = [];
  await db.transaction((txn) async {
    dbList = await txn.rawQuery('SELECT * FROM Sentences');
  });
  dbList.forEach((w) {
    s.SentenceWord word = s.SentenceWord.fromMap(w);
    _words.add(word);
  });
  return _words;
}

resetQuizScore() async {
  await initDb();
  Batch batch = db.batch();
  batch.rawUpdate(
      "UPDATE Words SET artikelPlayed = 'no', translationPlayed = 'no' WHERE cardPlayed = 'yes'");
  await batch.commit();
  currentQuizScore.value.right = 0;
  currentQuizScore.value.wrong = 0;
  await setQuizScore(currentQuizScore.value);
}

resetAllCards() async {
  Stopwatch _stopwatch = Stopwatch()..start();
  // List<VocabWord> _words = [];
  // _words = await getWordsTable();
  await initDb();
  Batch batch = db.batch();
  // for (int i = 0; i < _words.length; i++) {
  batch.rawUpdate(
      "UPDATE Words SET cardPlayed = 'no', artikelPlayed = 'no', translationPlayed = 'no'");
  // }
  await batch.commit();

  print("RESET QUERY TOOK ${_stopwatch.elapsedMilliseconds}");
}

updateRowCardFlag(VocabWord word) async {
  await initDb();
  await db.transaction((txn) async {
    await txn.rawUpdate(
        "UPDATE Words SET cardPlayed = 'yes' WHERE deutsch = '${word.deutsch}'");
  });
}

updateRowArtikelFlag(VocabWord word) async {
  await initDb();
  await db.transaction((txn) async {
    await txn.rawUpdate(
        "UPDATE Words SET artikelPlayed = 'yes' WHERE deutsch = '${word.deutsch}'");
  });
  await getWordsTable();
}

updateRowTranslationFlag(VocabWord word) async {
  await initDb();
  await db.transaction((txn) async {
    await txn.rawUpdate(
        "UPDATE Words SET translationPlayed = 'yes' WHERE deutsch = '${word.deutsch}'");
  });
  await getWordsTable();
}
