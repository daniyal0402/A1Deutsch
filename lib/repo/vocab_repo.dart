import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flowder/flowder.dart';
import 'package:flutter/foundation.dart';
// import 'package:firebase/firebase.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:json_traverse/json_traverse.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:vocabulary_client/models/SentenceWord.dart' as s;
import 'package:vocabulary_client/models/VocabWord.dart';
import 'package:vocabulary_client/repo/sqf_repo.dart';
import 'package:vocabulary_client/repo/user_repo.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

getWrds() async {
  // bool dbLock = await getDBLock();
  // if (!dbLock) {
  await deleteWordsTable();
  await deleteSentencesTable();
  Stopwatch _stopwatch = Stopwatch()..start();
  List<VocabWord> _words = [];
  List<s.SentenceWord> _sWords = [];
  // await setFetch(false, 's');
  // await setFetch(false, 's');

  // var wfetched = await getFetch('w');
  // var sfetched = await getFetch('s');
  // bool shouldReturn = false;
  // if (wfetched == null ||
  //     wfetched == false ||
  //     sfetched == null ||
  //     sfetched == false) {
  DocumentSnapshot _miscDoc =
      await _firestore.collection('misc').doc("languageList").get();
  Map<String, dynamic> miscData = _miscDoc.data();
  // if (wfetched == false || wfetched == null) {
  // await setDBLock(true);
  DownloaderUtils woptions;
  DownloaderCore wcore;
  DownloaderUtils soptions;
  DownloaderCore score;
  String path;
  // File wfile;
  path = (await getExternalStorageDirectory()).path;
  if (File("${path}/kVocabWords.json").existsSync()) {
    File("${path}/kVocabWords.json").deleteSync();
  }

  // woptions = DownloaderUtils(
  //   progressCallback: (current, total) {
  //     final progress = (current / total) * 100;
  //     // print('Downloading: $progress');
  //   },
  //   file: File('$path/kVocabWords.json'),
  //   progress: ProgressImplementation(),
  //   onDone: () async {
  //     wfile = File("${path}/kVocabWords.json");
  //   },
  //   deleteOnCancel: true,
  // );
  // wcore = await Flowder.download(miscData['VocabWords'], woptions);
  var wDownload =
      await downloadFile("${miscData['VocabWords']}", "kVocabWords.json", path);
  if (wDownload != "Can not fetch url") {
    File wfile = File(wDownload);
    var wReadData = await wfile.readAsStringSync();
    try {
      var wDecodedData = await json.decode(wReadData);
      for (int i = 0; i < wDecodedData.length; i++) {
        VocabWord word = VocabWord.fromMap(wDecodedData[i]);
        word.selectedLanguage = await getLanguage();
        Language _lang = word.languages
            .firstWhere((element) => element.name == translationLanguage.value);
        word.translation = _lang.translation;
        if (word.grammatik != null) {
          bool hasNomGen = word.grammatik.contains("Nom Gen Dat Akk");
          if (hasNomGen) {
            word.grammatik = word.grammatik
                .replaceAll("Nom Gen Dat Akk", "\nNom Gen Dat   Akk\n");
          }
        }
        // print(word.toMap());
        // await insertWordRecord(word);
        _words.add(word);
      }
      await insertWordBatch(_words);

      await setFetch(true, 'w');
      // await setDBLock(false);
    } catch (e) {
      // await setDBLock(false);
      print(e.toString());
    }
  }
  // }
  /////FOR SENTENCES//////
  // else if (sfetched == null || sfetched == false) {
  // await setDBLock(true);

  String spath;
  File sfile;
  spath = (await getExternalStorageDirectory()).path;

  if (File("${spath}/kSentenceWords.json").existsSync()) {
    File("${spath}/kSentenceWords.json").deleteSync();
  }
  // DocumentSnapshot _miscDoc =
  //     await _firestore.collection('misc').doc("languageList").get();
  // Map<String, dynamic> miscData = _miscDoc.data();
  // soptions = DownloaderUtils(
  //   progressCallback: (current, total) {
  //     final progress = (current / total) * 100;
  //   },
  //   file: File('$spath/kSentenceWords.json'),
  //   progress: ProgressImplementation(),
  //   onDone: () async* {
  //     sfile = File("${spath}/kSentenceWords.json");
  //   },
  //   deleteOnCancel: true,
  // );
  // score = await Flowder.download(miscData['SentenceWords'], soptions);

  var sDownload = await downloadFile(
      "${miscData['SentenceWords']}", "kSentenceWords.json", spath);
  if (sDownload != "Can not fetch url") {
    File sfile = File(sDownload);
    var sReadData = sfile.readAsStringSync();
    try {
      var sDecodedData = await json.decode(sReadData);
      for (int i = 0; i < sDecodedData.length; i++) {
        s.SentenceWord word = s.SentenceWord.fromMap(sDecodedData[i]);
        word.selectedLanguage = await getLanguage();
        s.Language _lang = word.languages
            .firstWhere((element) => element.name == word.selectedLanguage);
        word.translation = _lang.word;
        word.nativeSentence = _lang.sentence;
        // await insertSentenceRecord(word);
        _sWords.add(word);
      }
      await insertSentenceBatch(_sWords);
      await setFetch(true, 's');
      // await setDBLock(false);
    } catch (e) {
      // await setDBLock(false);
      print("YAHA GARBAR HAI DAYA!!!");
      print(e.toString());
    }
  }
  print("ELAPSED TIME: ${_stopwatch.elapsedMilliseconds}");

  return true;
}

getLocalData(String type) async {
  List<VocabWord> _words = [];
  List<s.SentenceWord> _sWords = [];
  if (type == 'w') {
    _words = await getWordsTable();
    return _words;
    // await setFetch(false, 'w');
  } else {
    _sWords = await getSentencesTable();
    return _sWords;
  }
}

Future<List<s.SentenceWord>> getSentences() async {
  print("GET SENTENCES");
  // await setFetch(false, 's');
  print(translationLanguage.value);
  List<s.SentenceWord> _words = [];
  var fetched = await getFetch('s');
  if (fetched == null || fetched == false) {
    QuerySnapshot _wordsQuery = await _firestore.collection('sentences').get();
    for (int i = 0; i < _wordsQuery.docs.length; i++) {
      var d = _wordsQuery.docs[i];
      s.SentenceWord word = s.SentenceWord.fromMap(d.data());
      word.selectedLanguage = translationLanguage.value;
      s.Language _lang = word.languages
          .firstWhere((element) => element.name == translationLanguage.value);

      word.translation = _lang.word;
      word.nativeSentence = _lang.sentence;

      await insertSentenceRecord(word);
      _words.add(word);
    }
    // _wordsQuery.docs.forEach((d) async {});
    await setFetch(true, 's');
  } else {
    _words = await getSentencesTable();
  }
  return _words;
}

Future<String> downloadFile(String url, String fileName, String dir) async {
  HttpClient httpClient = new HttpClient();
  File file;
  String filePath = '';
  String myUrl = '';
  try {
    myUrl = url + '/' + fileName;
    var request = await httpClient.getUrl(Uri.parse(myUrl));
    var response = await request.close();
    if (response.statusCode == 200) {
      var bytes = await consolidateHttpClientResponseBytes(response);
      filePath = '$dir/$fileName';
      file = File(filePath);
      await file.writeAsBytes(bytes);
    } else
      filePath = 'Error code: ' + response.statusCode.toString();
  } catch (ex) {
    filePath = 'Can not fetch url';
  }

  return filePath;
}
