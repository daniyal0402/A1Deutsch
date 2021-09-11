import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vocabulary_client/UI/screens/AccessCode.dart';
import 'package:vocabulary_client/UI/widgets/MyDrawer.dart';
import 'package:vocabulary_client/controllers/SearchSentenceController.dart';
import 'package:vocabulary_client/helpers/AppConstants.dart';
import 'package:vocabulary_client/repo/user_repo.dart';
import 'package:easy_localization/easy_localization.dart';

class SearchSentence extends StatefulWidget {
  @override
  _SearchSentenceState createState() => _SearchSentenceState();
}

SearchSentencesController _con;

class _SearchSentenceState extends StateMVC<SearchSentence> {
  _SearchSentenceState() : super(SearchSentencesController()) {
    _con = controller;
  }
  GlobalKey<InnerDrawerState> innerDrawerKey;
  void _toggle() {
    innerDrawerKey.currentState.toggle(direction: InnerDrawerDirection.start);
  }

  @override
  void initState() {
    innerDrawerKey = GlobalKey<InnerDrawerState>();
    print("TRANSLATION LANGUAGE: ");
    super.initState();
    _con.fetchWords();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MyDrawer(
        stateSetter: (f) {
          AppConstants.updateLocaleIfNeeded(f, context);

          setState(() {});
        },
        innerDrawerKey: innerDrawerKey,
        scaffold: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: GestureDetector(
              onTap: () {
                _toggle();
              },
              child: Icon(
                Icons.menu,
                size: 35,
                color: AppConstants.secondaryColor,
              ),
            ),
            title: Container(
              height: 38,
              padding: EdgeInsets.only(left: 15),
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
                    border: InputBorder.none, hintText: "Search".tr()),
                onChanged: (v) {
                  _con.searchTerm = v;
                  _con.refreshSearch();
                },
              ),
            ),
          ),
          body: _con.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  child: ListView.builder(
                      itemCount: userCheck(_con.words.length) + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return (currentUser.value.accessCode == null)
                              ? GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return AccessCode();
                                    }));
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(20),
                                    child: Text(
                                      "Have a code? enter here to get full version"
                                          .tr(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppConstants.peachColor,
                                      ),
                                    ),
                                  ),
                                )
                              : Container();
                        }
                        return GestureDetector(
                          onTap: () {
                            _con.showDetailsSheet(_con.words[index - 1]);
                          },
                          child: Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.75,
                                        child: Text(
                                          "${_con.words[index - 1].deutsch}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      // Container(
                                      //   margin: EdgeInsets.all(10),
                                      //   width: 185,
                                      //   child: Text(
                                      //     "${_con.words[index - 1].deutsch}" +
                                      //         "${(_con.words[index - 1].wortart == null || _con.words[index - 1].wortart.isEmpty) ? '' : _con.words[index - 1].wortart}" +
                                      //         "\n"
                                      //             "${(_con.words[index - 1].plural == null || _con.words[index - 1].plural.isEmpty) ? '' : _con.words[index - 1].plural}",
                                      //     maxLines: 5,
                                      //     style: TextStyle(
                                      //         fontSize: 12,
                                      //         color: AppConstants.primaryColor),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 120,
                                        child: Text(
                                          "${(_con.words[index - 1].englishWord == null || _con.words[index - 1].englishWord.isEmpty ? '' : _con.words[index - 1].englishWord)}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        width: 185,
                                        child: Text(
                                          "${(_con.words[index - 1].translation == null || _con.words[index - 1].translation.isEmpty ? '' : _con.words[index - 1].translation)}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  AppConstants.secondaryColor),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )),
                        );
                      })),
        ),
      ),
    );
  }
}
