import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../about_menu_details_pages/about_app.dart';
import '../about_menu_details_pages/about_club.dart';
import '../about_menu_details_pages/acronyms_meanings.dart';
import '../about_menu_details_pages/who_we_are.dart';
import '../api/coaching_staff_api.dart';
import '../bloc_navigation_bloc/navigation_bloc.dart';
import '../bottom_nav_stats_pages/bottom_navigator.dart';
import '../details_pages/coaching_staff_details_page.dart';
import '../notifier/coaching_staff_notifier.dart';
import '../thrown_searches/coaches_thrown_search.dart';

String clubName = "Coventry Phoenix FC";
String thrownName = "Coaching Staff";

String exitAppStatement = "Exit from App";
String exitAppTitle = "Come on!";
String exitAppSubtitle = "Do you really really want to?";
String exitAppNo = "Oh No";
String exitAppYes = "I Have To";

String whoWeAre = "Who We Are";
String aboutClub = "About $clubName";
String tablesAndStats = "Tables and Stats";
String acronymMeanings = "Acronym Meanings";
String aboutApp = "About App";

String fabStats = "Stats";

Color backgroundColor = const Color.fromRGBO(255, 145, 104, 1);
Color appBarTextColor = const Color.fromRGBO(138, 55, 24, 1.0);
Color appBarBackgroundColor = const Color.fromRGBO(255, 145, 104, 1);
Color appBarIconColor = const Color.fromRGBO(138, 55, 24, 1.0);
Color modalColor = Colors.transparent;
Color modalBackgroundColor = const Color.fromRGBO(255, 145, 104, 1);
Color materialBackgroundColor = Colors.transparent;
Color cardBackgroundColor = const Color.fromRGBO(255, 188, 163, 1);
Color splashColor = const Color.fromRGBO(255, 145, 104, 1);
Color splashColorTwo = Colors.black87;
Color modalIconColor = const Color.fromRGBO(138, 55, 24, 1.0);
Color modalTextColor = const Color.fromRGBO(138, 55, 24, 1.0);
Color iconColor = const Color.fromRGBO(255, 188, 163, 1);
Color textColor = const Color.fromRGBO(255, 188, 163, 1);
Color textColorTwo = const Color.fromRGBO(248, 190, 168, 1.0);
Color dialogBackgroundColor = const Color.fromRGBO(255, 145, 104, 1);
Color borderColor = Colors.black;
Color nabColor = const Color.fromRGBO(24, 26, 36, 1.0);

class MyCoachesPage extends StatefulWidget with NavigationStates {
  MyCoachesPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<MyCoachesPage> createState() => _MyCoachesPage();
}

class _MyCoachesPage extends State<MyCoachesPage> {
  Widget _buildProductItem(BuildContext context, int index) {
    CoachesNotifier coachesNotifier = Provider.of<CoachesNotifier>(context);
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
              coachesNotifier.currentCoaches =
                  coachesNotifier.coachesList[index];
              navigateToCoachesDetailsPage(context);
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
                            coachesNotifier.coachesList[index].image!),
                        fit: BoxFit.cover,
                      ),
                    ),
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
                              Text(coachesNotifier.coachesList[index].name!,
                                  style: GoogleFonts.tenorSans(
                                      color: textColor,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600)),
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
                              coachesNotifier.coachesList[index].staffPosition!,
                              style: GoogleFonts.varela(
                                color: textColorTwo,
                                fontStyle: FontStyle.italic,
                              )),
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
  }

  Future<bool> _onWillPop() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            backgroundColor: dialogBackgroundColor,
            title: Text(
              exitAppTitle,
              style: TextStyle(color: textColor),
            ),
            content: Text(
              exitAppSubtitle,
              style: TextStyle(color: textColor),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  exitAppNo,
                  style: TextStyle(color: textColor),
                ),
              ),
              TextButton(
                onPressed: () => exit(0),
                /*Navigator.of(context).pop(true)*/
                child: Text(
                  exitAppYes,
                  style: TextStyle(color: textColor),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future navigateToCoachesDetailsPage(context) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const CoachesDetailsPage()));
  }

  Future navigateTablesAndStatsDetails(context) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const BottomNavigator()));
  }

  Future navigateToAboutAppDetailsPage(context) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AboutAppDetails()));
  }

  Future navigateToAcronymsMeaningsPage(context) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AcronymsMeanings()));
  }

  Future navigateToAboutClubDetailsPage(context) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AboutClubDetails()));
  }

  Future navigateToWhoWeArePage(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const WhoWeAre()));
  }

  @override
  void initState() {
    CoachesNotifier coachesNotifier =
        Provider.of<CoachesNotifier>(context, listen: false);
    getCoaches(coachesNotifier);
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    CoachesNotifier coachesNotifier = Provider.of<CoachesNotifier>(context);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Container(
          color: backgroundColor,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(MdiIcons.formatFloatLeft,
                          color: appBarIconColor),
                      onPressed: () {
                        showModalBottomSheet(
                            backgroundColor: modalColor,
                            context: context,
                            builder: (context) => Container(
                                  decoration: BoxDecoration(
                                    color: modalBackgroundColor,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15)),
                                  ),
                                  child: Material(
                                    color: materialBackgroundColor,
                                    child: InkWell(
                                      splashColor: splashColorTwo,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0,
                                            bottom: 35.0,
                                            right: 8.0,
                                            left: 8.0),
                                        child: Wrap(
                                          children: <Widget>[
                                            ListTile(
                                                leading: Icon(
                                                  MdiIcons.tableMultiple,
                                                  color: modalIconColor,
                                                ),
                                                title: Text(
                                                  tablesAndStats,
                                                  style: GoogleFonts.zillaSlab(
                                                      color: modalTextColor),
                                                ),
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .pop(false);
                                                  navigateTablesAndStatsDetails(
                                                      context);
                                                }),
                                            ListTile(
                                                leading: Icon(MdiIcons.atom,
                                                    color: modalIconColor),
                                                title: Text(
                                                  whoWeAre,
                                                  style: GoogleFonts.zillaSlab(
                                                      color: modalTextColor),
                                                ),
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .pop(false);
                                                  navigateToWhoWeArePage(
                                                      context);
                                                }),
                                            ListTile(
                                              leading: Icon(
                                                  MdiIcons.accountGroup,
                                                  color: modalIconColor),
                                              title: Text(
                                                aboutClub,
                                                style: GoogleFonts.zillaSlab(
                                                    color: modalTextColor),
                                              ),
                                              onTap: () {
                                                Navigator.of(context)
                                                    .pop(false);
                                                navigateToAboutClubDetailsPage(
                                                    context);
                                              },
                                            ),
                                            ListTile(
                                                leading: Icon(
                                                    MdiIcons
                                                        .sortAlphabeticalAscending,
                                                    color: modalIconColor),
                                                title: Text(
                                                  acronymMeanings,
                                                  style: GoogleFonts.zillaSlab(
                                                      color: modalTextColor),
                                                ),
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .pop(false);
                                                  navigateToAcronymsMeaningsPage(
                                                      context);
                                                }),
                                            ListTile(
                                              leading: Icon(MdiIcons.opacity,
                                                  color: modalIconColor),
                                              title: Text(
                                                aboutApp,
                                                style: GoogleFonts.zillaSlab(
                                                    color: modalTextColor),
                                              ),
                                              onTap: () {
                                                Navigator.of(context)
                                                    .pop(false);
                                                navigateToAboutAppDetailsPage(
                                                    context);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ));
                      },
                    ),
                    IconButton(
                      icon: Icon(MdiIcons.magnify, color: appBarIconColor),
                      onPressed: () {
                        showSearch(
                          context: context,
                          delegate:
                              MyCoachesSearch(all: coachesNotifier.coachesList),
                        );
                      },
                      tooltip: "Search",
                    ),
                  ],
                  backgroundColor: appBarBackgroundColor,
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Center(
                        heightFactor: 0.6,
                        child: Text(thrownName,
                            style: GoogleFonts.abel(
                                color: appBarTextColor,
                                fontSize: 26.0,
                                fontWeight: FontWeight.bold)),
                      ),
                      background:
                          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection('SliversPages')
                            .doc('slivers_pages')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }
                          return Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      snapshot.data?.data()!['slivers_page_5'],
                                    ),
                                    fit: BoxFit.cover)),
                          );
                        },
                      )),
                ),
              ];
            },
            body: Padding(
              padding: const EdgeInsets.only(left: 25, right: 10),
              child: Container(
                margin: const EdgeInsets.only(bottom: 15),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: ListView.builder(
                  itemBuilder: _buildProductItem,
                  itemCount: coachesNotifier.coachesList.length,
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Navigator.of(context).pop(true);
            navigateTablesAndStatsDetails(context);
          },
          label: Text(
            fabStats,
            style: TextStyle(color: appBarIconColor),
          ),
          icon: Icon(MdiIcons.alphaSBoxOutline, color: appBarIconColor),
          splashColor: splashColorTwo,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
