import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vocabulary_client/controllers/AccessCodeController.dart';
import 'package:vocabulary_client/controllers/SelectLanguageController.dart';
import 'package:vocabulary_client/helpers/AppConstants.dart';
import 'package:easy_localization/easy_localization.dart';

class AccessCode extends StatefulWidget {
  @override
  _AccessCodeState createState() => _AccessCodeState();
}

AccessCodeController _con;

class _AccessCodeState extends StateMVC<AccessCode> {
  _AccessCodeState() : super(AccessCodeController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: AppConstants.blackColor,
          title: Text(
            "Enter code",
            style: TextStyle(
              color: AppConstants.primaryColor,
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Please enter the provided code".tr() + ":",
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 38,
                padding: EdgeInsets.only(left: 15),
                margin: EdgeInsets.symmetric(horizontal: 50),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                  border: Border.all(
                    color: AppConstants.secondaryColor,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "Access code".tr()),
                  onChanged: (v) {
                    _con.code = v;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/ContactUs');
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Need code ? enter here to get code!".tr(),
                      style: TextStyle(
                        fontSize: 16,
                        color: AppConstants.peachColor,
                      ),
                    ),
                  ),
                ),
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
