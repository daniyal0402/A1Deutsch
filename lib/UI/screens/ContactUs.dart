import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vocabulary_client/helpers/AppConstants.dart';
import 'package:easy_localization/easy_localization.dart';

class ContactUsPage extends StatefulWidget {
  @override
  ContactUsPageState createState() => ContactUsPageState();
}

class ContactUsPageState extends StateMVC<ContactUsPage> {
  @override
  void initState() {
    super.initState();
  }

  List<Color> gradient = [
    AppConstants.blackColor,
    AppConstants.secondaryColor,
    AppConstants.primaryColor,
  ];
  static const _url = 'mailto:app@lady2000.de?subject=Code-Anfrage&body=';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppConstants.blackColor,
          automaticallyImplyLeading: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: gradient,
            ),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  "we also have apps for A2, B1, B2, C1 and C2 in all languages"
                      .tr(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                  child: Linkify(
                text: "app@lady2000.de",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
                options: LinkifyOptions(humanize: true),
                onOpen: (link) async {
                  await canLaunch(_url)
                      ? await launch(_url)
                      : throw 'Could not launch $_url';
                },
              )
                  // RichText(
                  //   text: TextSpan(
                  //     children: const <TextSpan>[
                  //       TextSpan(
                  //         text: "für Kriegsflüchtende kostenlos mit E-Mal ",
                  //         style: TextStyle(color: Colors.black),
                  //       ),
                  //       TextSpan(
                  //         text: "app@lady2000.de",
                  //         style: TextStyle(color: Colors.blue),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
