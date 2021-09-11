import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:vocabulary_client/UI/screens/HomepageParent.dart';
import 'package:vocabulary_client/helpers/AppConstants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:vocabulary_client/models/CardHistory.dart';
import 'package:vocabulary_client/repo/sqf_repo.dart';
import 'package:vocabulary_client/repo/user_repo.dart';

class MyDrawer extends StatefulWidget {
  GlobalKey<InnerDrawerState> innerDrawerKey;
  Widget scaffold;
  Function stateSetter;
  Function quizScoreReset;
  MyDrawer({
    @required this.innerDrawerKey,
    @required this.scaffold,
    @required this.stateSetter,
    this.quizScoreReset,
  });

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

List<Color> gradient = [
  AppConstants.blackColor,
  AppConstants.blackColor,
  AppConstants.secondaryColor,
  AppConstants.primaryColor,
];

class _MyDrawerState extends State<MyDrawer> {
  String _lang;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _lang = context.locale.countryCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
      key: widget.innerDrawerKey,
      onTapClose: true,
      swipe: false,
      colorTransitionChild: AppConstants.secondaryColor,
      colorTransitionScaffold: Colors.black12,
      offset: IDOffset.horizontal(0.2),
      scale: IDOffset.horizontal(0.8),
      proportionalChildArea: true, // default true
      borderRadius: 50, // default 0
      leftAnimationType: InnerDrawerAnimation.static, // default static
      rightAnimationType: InnerDrawerAnimation.quadratic,
      backgroundDecoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradient,
        ),
      ),
      onDragUpdate: (double val, InnerDrawerDirection direction) {},
      innerDrawerCallback: (a) =>
          print(a), // return  true (open) or false (close)
      leftChild: SingleChildScrollView(
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "App Language".tr(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () async {
                      this.setState(() {
                        _lang = 'EN';
                        EasyLocalization.of(context)
                            .setLocale(Locale('en', "EN"));
                      });
                      widget.stateSetter("localeEN");
                      // Navigator.pushReplacement(context,
                      //     MaterialPageRoute(builder: (builder) {
                      //   return HomePageParent();
                      // })).then(
                      //     (value) => widget.innerDrawerKey.currentState.toggle());
                    },
                    child: Container(
                        width: 15,
                        height: 15,
                        decoration: _lang == 'EN'
                            ? BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppConstants.secondaryColor,
                              )
                            : BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppConstants.secondaryColor))),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Englisch',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      this.setState(() {
                        _lang = 'DE';
                        EasyLocalization.of(context)
                            .setLocale(Locale('de', "DE"));
                      });

                      widget.stateSetter("localeDE");
                      // Navigator.pushReplacement(context,
                      //     MaterialPageRoute(builder: (builder) {
                      //   return HomePageParent();
                      // })).then(
                      //     (value) => widget.innerDrawerKey.currentState.toggle());
                    },
                    child: Container(
                        width: 15,
                        height: 15,
                        decoration: _lang == 'DE'
                            ? BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppConstants.secondaryColor,
                              )
                            : BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppConstants.secondaryColor))),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Deutsch',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              SizedBox(
                height: 80,
              ),
              MaterialButton(
                padding: EdgeInsets.zero,
                onPressed: () async {
                  AppConstants.showLoader(context);

                  await resetAllCards();
                  await setCardHistory(CardsHistory(
                    limit: currentCardsHistory.value.limit,
                    left: currentCardsHistory.value.limit,
                    lastReset: currentCardsHistory.value.lastReset,
                  ));
                  final newHistory = await getCardHistory();
                  currentCardsHistory.value = newHistory;
                  widget.stateSetter("fetch");
                  await Future.delayed(Duration(seconds: 1));

                  Loader.hide();
                },
                child: Text(
                  "Reset all cards".tr(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              // InkWell(
              //   child: Text(
              //     "Reset skipped cards".tr(),
              //     style: TextStyle(
              //       color: Colors.white,
              //       fontSize: 16,
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 15,
              // ),
              MaterialButton(
                padding: EdgeInsets.zero,
                onPressed: () async {
                  AppConstants.showLoader(context);
                  await resetQuizScore();

                  if (widget.quizScoreReset != null) widget.quizScoreReset();
                  await Future.delayed(Duration(seconds: 1));

                  Loader.hide();
                },
                child: Text(
                  "Reset quiz score".tr(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                child: Row(
                  children: [
                    Text(
                      "Cards per day".tr(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      height: 30,
                      width: 60,
                      color: Colors.white,
                      child: TextField(
                        onSubmitted: (val) async {
                          if (val.contains(',') ||
                              val.contains('.') ||
                              val == '' ||
                              val.contains('-') ||
                              val.contains(' ')) {
                            AppConstants.showSnack(
                                context, "Invalid value", () {});
                          } else {
                            // currentCardsHistory.value.limit = int.parse(val);
                            AppConstants.showLoader(context);

                            await updateCardHistory(int.parse(val));
                            widget.stateSetter("fetch");
                            await Future.delayed(Duration(seconds: 1));
                            Loader.hide();
                          }
                        },
                        onChanged: (val) {},
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 7),
                            hintText: "${currentCardsHistory.value.limit}"),
                        keyboardType: TextInputType.number,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              SizedBox(
                height: 15,
              ),

              SizedBox(
                height: 15,
              ),
              MaterialButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  // Navigator.pushNamed(context, '/ContactUs');
                  Navigator.pushNamed(context, '/AboutUs');
                },
                child: Text(
                  "About us".tr(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
              ),

              MaterialButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.pushNamed(context, '/ContactUs');
                },
                child: Text(
                  "Contact us".tr(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ), // required if rightChild is not set
      // rightChild: Container(), // required if leftChild is not set
      scaffold: widget.scaffold,
    );
  }
}
