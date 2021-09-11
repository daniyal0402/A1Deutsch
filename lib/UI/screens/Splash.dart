import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vocabulary_client/controllers/SplashController.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

SplashController _con;

class _SplashScreenState extends StateMVC<SplashScreen> {
  _SplashScreenState() : super(SplashController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    _con.startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: Image.asset('assets/AppLogo.jpeg'),
        ),
      ),
    );
  }
}
