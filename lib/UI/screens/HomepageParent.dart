import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:vocabulary_client/UI/screens/CardGame.dart';
import 'package:vocabulary_client/UI/screens/Homepage.dart';
import 'package:vocabulary_client/UI/screens/Quiz.dart';
import 'package:vocabulary_client/UI/screens/SearchSentences.dart';
import 'package:vocabulary_client/UI/screens/SearchWord.dart';
import 'package:vocabulary_client/helpers/AppConstants.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePageParent extends StatefulWidget {
  @override
  _HomePageParentState createState() => _HomePageParentState();
}

class _HomePageParentState extends State<HomePageParent> {
  int selectedIndex = 0;
  int badge = 0;
  var padding = EdgeInsets.symmetric(horizontal: 18, vertical: 12);
  double gap = 10;
  int randomValueForGradientSelection;
  PageController controller = PageController();

  List<Widget> pages = [
    SearchWord(),
    SearchSentence(),
    CardGame(),
    Quiz(),
  ];

  @override
  void initState() {
    super.initState();
    randomValueForGradientSelection = Random().nextInt(3);
    // var padding = EdgeInsets.symmetric(horizontal: 18, vertical: 5);
  }

  var _size;
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: PageView.builder(
          onPageChanged: (page) {
            setState(() {
              selectedIndex = page;
              badge = badge + 1;
            });
          },
          controller: controller,
          itemBuilder: (context, position) {
            return pages[position];
          },
          itemCount: pages.length, // Can be null
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // width: _size.width * 0.75,
              padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3),
              child: GNav(
                  tabs: [
                    GButton(
                      gap: gap,
                      iconActiveColor: AppConstants.secondaryColor,
                      iconColor: Colors.black,
                      textColor: AppConstants.secondaryColor,
                      backgroundColor:
                          AppConstants.secondaryColor.withOpacity(.2),
                      iconSize: 24,
                      padding: padding,
                      icon: LineIcons.search,
                      text: 'Search word'.tr(),
                    ),
                    GButton(
                      gap: gap,
                      iconActiveColor: AppConstants.secondaryColor,
                      iconColor: Colors.black,
                      textColor: AppConstants.secondaryColor,
                      backgroundColor:
                          AppConstants.secondaryColor.withOpacity(.2),
                      iconSize: 24,
                      padding: padding,
                      icon: LineIcons.graduationCap,
                      text: 'Sentences'.tr(),
                    ),
                    GButton(
                      gap: gap,
                      iconActiveColor: AppConstants.secondaryColor,
                      iconColor: Colors.black,
                      textColor: AppConstants.secondaryColor,
                      backgroundColor:
                          AppConstants.secondaryColor.withOpacity(.2),
                      iconSize: 24,
                      padding: padding,
                      icon: LineIcons.eye,
                      text: 'Cards'.tr(),
                    ),
                    GButton(
                      gap: gap,
                      iconActiveColor: AppConstants.secondaryColor,
                      iconColor: Colors.black,
                      textColor: AppConstants.secondaryColor,
                      backgroundColor:
                          AppConstants.secondaryColor.withOpacity(.2),
                      iconSize: 24,
                      padding: padding,
                      icon: LineIcons.infoCircle,
                      text: 'Quiz'.tr(),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onTabChange: (index) {
                    print(index);
                    setState(() {
                      selectedIndex = index;
                    });
                    controller.jumpToPage(index);
                    // });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
