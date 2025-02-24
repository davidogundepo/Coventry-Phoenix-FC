import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../details_pages/club_captains_details_page.dart';
import '../notifier/club_captains_notifier.dart';

Color backgroundColor = const Color.fromRGBO(56, 56, 60, 1);
Color appBarTextColor = const Color.fromRGBO(56, 56, 60, 1);
Color appBarBackgroundColor = const Color.fromRGBO(56, 56, 60, 1);
Color appBarIconColor = const Color.fromRGBO(56, 56, 60, 1);
Color modalColor = Colors.transparent;
Color modalBackgroundColor = const Color.fromRGBO(56, 56, 60, 1);
Color materialBackgroundColor = Colors.transparent;
Color cardBackgroundColor = Colors.white70;
Color splashColor = const Color.fromRGBO(56, 56, 60, 1);
Color splashColorTwo = Colors.black87;
Color iconColor = Colors.white70;
Color iconColorTwo = Colors.white70;
Color textColor = Colors.white70;
Color textColorTwo = Colors.white70;
Color dialogBackgroundColor = const Color.fromRGBO(56, 56, 60, 1);
Color borderColor = Colors.black;
Color textHighlightColor = Colors.white70;

dynamic queryTech;

class MyCaptainsSearch extends SearchDelegate {
  final List? all;

  MyCaptainsSearch({this.all});

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = ThemeData(
        primaryColor: appBarBackgroundColor,
        primarySwatch: Colors.deepOrange,
        appBarTheme: AppBarTheme(backgroundColor: cardBackgroundColor),
        primaryIconTheme: IconThemeData(color: appBarIconColor),
        textTheme: TextTheme(
            titleMedium: TextStyle(color: appBarTextColor, fontSize: 25)),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: appBarTextColor.withAlpha(60)),
        ),
        textSelectionTheme:
            TextSelectionThemeData(cursorColor: appBarTextColor));
    return theme;
  }

  Future navigateToCaptainsDetailsPage(context) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const CaptainsDetailsPage()));
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    if (query.isNotEmpty) {
      return [
        Visibility(
          visible: true,
          child: IconButton(
            icon: Visibility(
                visible: true,
                child: Icon(
                  MdiIcons.closeCircleOutline,
                  color: appBarIconColor,
                )),
            onPressed: () {
              query = '';
            },
          ),
        )
      ];
    } else {
      return [
        Visibility(
          visible: false,
          child: IconButton(
            icon: Visibility(
                visible: false,
                child: Icon(
                  MdiIcons.closeCircleOutline,
                  color: appBarIconColor,
                )),
            onPressed: () {
              query = '';
            },
          ),
        )
      ];
    }
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        MdiIcons.chevronTripleLeft,
        color: appBarIconColor,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    String query1;
    var query2 = " ";
    if (query.isNotEmpty) {
      query1 = query.toLowerCase();
      query2 = query1[0].toUpperCase() + query1.substring(1);
    }

    var search =
        all?.where((captains) => captains.name.contains(query2)).toList();

    return search == null
        ? _buildProgressIndicator()
        : _buildSearchList(search);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    String query1;
    queryTech = "";
    if (query.isNotEmpty) {
      query1 = query.toLowerCase();
      queryTech = query1[0].toUpperCase() + query1.substring(1);
    }

    List? search;

    if (queryTech.isNotEmpty) {
      search =
          all?.where((captains) => captains.name.contains(queryTech)).toList();
    } else {
      search = all;
    }

    return search == null
        ? _buildProgressIndicator()
        : _buildSearchList(search);
  }

  _buildSearchList(List search) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: search.length,
              itemBuilder: (BuildContext context, int position) {
                CaptainsNotifier captainsNotifier =
                    Provider.of<CaptainsNotifier>(context);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: borderColor.withAlpha(50),
                    ),
                    child: Material(
                      color: materialBackgroundColor,
                      child: InkWell(
                        splashColor: splashColor,
                        onTap: () {
                          captainsNotifier.currentCaptains = search[position];
                          navigateToCaptainsDetailsPage(context);
                        },
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10)),
                                    image: DecorationImage(
                                        alignment: const Alignment(0, -1),
                                        image: CachedNetworkImageProvider(
                                            search[position].image),
                                        fit: BoxFit.cover)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 60),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Row(
                                        children: <Widget>[
                                          RichText(
                                            text: TextSpan(
                                                text: search[position]
                                                    .name
                                                    .substring(
                                                        0, queryTech.length),
                                                style: GoogleFonts.tenorSans(
                                                    color: textColor,
                                                    fontSize: 13.5,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                children: [
                                                  TextSpan(
                                                      text: search[position]
                                                          .name
                                                          .substring(
                                                              queryTech.length),
                                                      style: GoogleFonts.tenorSans(
                                                          color:
                                                              textHighlightColor))
                                                ]),
                                          ),
                                          const SizedBox(width: 10),
                                          Icon(
                                            MdiIcons.shieldCheck,
                                            color: iconColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                          search[position].teamCaptaining,
                                          style: GoogleFonts.varela(
                                              color: textColor,
                                              fontStyle: FontStyle.italic)),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }

  _buildProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
      ),
    );
  }
}
