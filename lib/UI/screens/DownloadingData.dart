import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vocabulary_client/UI/widgets/loader_widget.dart';
import 'package:vocabulary_client/controllers/DownloadingDataController.dart';
import 'package:easy_localization/easy_localization.dart';

class DownloadingData extends StatefulWidget {
  @override
  _DownloadingDataState createState() => _DownloadingDataState();
}

DownloadingDataController _con;

class _DownloadingDataState extends StateMVC<DownloadingData> {
  _DownloadingDataState() : super(DownloadingDataController()) {
    _con = controller;
  }
  @override
  void initState() {
    super.initState();
    _con.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyLoader(),
            SizedBox(height: 20),
            Text("Downloading data please wait".tr()),
          ],
        ),
      ),
    );
  }
}
