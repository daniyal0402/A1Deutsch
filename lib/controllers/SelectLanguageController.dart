import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vocabulary_client/UI/screens/DownloadingData.dart';
import 'package:vocabulary_client/UI/screens/HomepageParent.dart';
import 'package:vocabulary_client/repo/user_repo.dart';

class SelectLanguageController extends ControllerMVC {
  List<String> languages = []; // Option 2
  String selectedLanguage;

  fetchLanguages() async {
    languages = await getLanguages();
    if (languages.isNotEmpty) {
      selectedLanguage = languages[0];
    }
    setState(() {});
  }

  proceedToNext() async {
    await setLanguage(selectedLanguage);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => DownloadingData()));
  }
}
