import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vocabulary_client/UI/screens/HomepageParent.dart';
import 'package:vocabulary_client/repo/vocab_repo.dart';

class DownloadingDataController extends ControllerMVC {
  fetchData() async {
    getWrds().then((d) {
      print("RETURN");
      print(d);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePageParent()));
    });
  }
}
