import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 120,
        width: 120,
        child: Lottie.asset("assets/loading_anim.json"),
      ),
    );
  }
}
