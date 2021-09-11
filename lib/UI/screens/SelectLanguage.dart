import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vocabulary_client/controllers/SelectLanguageController.dart';
import 'package:vocabulary_client/helpers/AppConstants.dart';
import 'package:easy_localization/easy_localization.dart';

class SelectLanguage extends StatefulWidget {
  @override
  _SelectLanguageState createState() => _SelectLanguageState();
}

SelectLanguageController _con;

class _SelectLanguageState extends StateMVC<SelectLanguage> {
  _SelectLanguageState() : super(SelectLanguageController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    _con.fetchLanguages();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Select language".tr(),
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          alignment: Alignment.center,
          child: _con.languages.isEmpty
              ? Container()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Please Select a Language".tr() + ":",
                      style: TextStyle(fontSize: 17),
                    ),
                    DropdownButton(
                      hint: Text('language'.tr()), // Not necessary for Option 1
                      value: _con.selectedLanguage,
                      onChanged: (newValue) {
                        setState(() {
                          _con.selectedLanguage = newValue;
                        });
                      },
                      items: _con.languages.map((location) {
                        return DropdownMenuItem(
                          child: new Text(location),
                          value: location,
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    MaterialButton(
                      color: AppConstants.secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        _con.proceedToNext();
                      },
                      child: Text(
                        "Proceed to next".tr(),
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
