import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coventry_phoenix_fc/api/second_team_class_api.dart';
import 'package:coventry_phoenix_fc/notifier/achievement_images_notifier.dart';
import 'package:coventry_phoenix_fc/notifier/club_arial_notifier.dart';
import 'package:coventry_phoenix_fc/notifier/club_captains_notifier.dart';
import 'package:coventry_phoenix_fc/notifier/coaching_staff_notifier.dart';
import 'package:coventry_phoenix_fc/notifier/management_body_notifier.dart';
import 'package:coventry_phoenix_fc/notifier/most_assists_players_stats_info_notifier.dart';
import 'package:coventry_phoenix_fc/notifier/second_team_class_notifier.dart';
import 'package:coventry_phoenix_fc/notifier/sidebar_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../about_menu_details_pages/about_app.dart';
import '../about_menu_details_pages/about_club.dart';
import '../about_menu_details_pages/acronyms_meanings.dart';
import '../about_menu_details_pages/who_we_are.dart';
import '../api/achievement_images_api.dart';
import '../api/club_arial_images_api.dart';
import '../api/club_captains_api.dart';
import '../api/coaching_staff_api.dart';
import '../api/cum_motm_players_stats_info_api.dart';
import '../api/first_team_class_api.dart';
import '../api/founders_reviews_comment_api.dart';
import '../api/management_body_api.dart';
import '../api/most_assists_players_stats_info_api.dart';
import '../api/most_fouled_rc_players_stats_info_api.dart';
import '../api/most_fouled_yc_players_stats_info_api.dart';
import '../api/motm_players_stats_info_api.dart';
import '../api/player_of_the_month_stats_info_api.dart';
import '../api/third_team_class_api.dart';
import '../api/top_defensive_players_stats_info_api.dart';
import '../api/top_gk_players_stats_info_api.dart';
import '../api/top_goals_players_stats_info_api.dart';
import '../api/trainings_games_reels_api.dart';
import '../bloc_navigation_bloc/navigation_bloc.dart';
import '../bottom_nav_stats_pages/bottom_navigator.dart';
import '../details_pages/first_team_details_page.dart';
import '../notifier/cum_motm_players_stats_info_notifier.dart';
import '../notifier/first_team_class_notifier.dart';
import '../notifier/founders_reviews_comment_notifier.dart';
import '../notifier/most_fouled_rc_players_stats_info_notifier.dart';
import '../notifier/most_fouled_yc_players_stats_info_notifier.dart';
import '../notifier/motm_players_stats_info_notifier.dart';
import '../notifier/player_of_the_month_stats_info_notifier.dart';
import '../notifier/third_team_class_notifier.dart';
import '../notifier/top_defensive_players_stats_info_notifier.dart';
import '../notifier/top_gk_players_stats_info_notifier.dart';
import '../notifier/top_goals_players_stats_info_notifier.dart';
import '../notifier/trainings_games_reels_notifier.dart';
import '../thrown_searches/first_team_thrown_search.dart';

String clubName = "Coventry Phoenix FC";
// String postcode = "CV1 3WQ";
String city = "Coventry";
String stateName = "West Midlands";
String countryName = "The UK";
String thrownName = "Returning Players";

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

String networkSharedPreferencesKey = "first_time";
String networkSharedPreferencesTitle = "Bienvenue! 😎";
String networkSharedPreferencesContent = "Enjoy and Stay Awesome :)";
String networkSharedPreferencesButton = "Okies";

String welcomeOverviewSharedPreferencesKey = "toast_initial";

String appOverviewSharedPreferencesKey = "overview_time";
String appOverviewSharedPreferencesTitle = "APP OVERVIEW";
String appOverviewSharedPreferencesContentOne =
    "This App was developed for $clubName, a Football Club in $city, $stateName. $countryName.\n";
// String appOverviewSharedPreferencesContentTwo = "Our vision is to raise the total youth through comprehensive education.\n";
String appOverviewSharedPreferencesContentThree =
    "Welcome to our app, do check through and know more!";
String appOverviewSharedPreferencesButton = "Awesome";

Color backgroundColor = const Color.fromRGBO(33, 37, 41, 1.0);
Color appBarTextColor = const Color.fromRGBO(255, 107, 53, 1.0);
Color appBarBackgroundColor = const Color.fromRGBO(33, 37, 41, 1.0);
Color appBarIconColor = const Color.fromRGBO(255, 107, 53, 1.0);
Color modalColor = Colors.transparent;
Color modalBackgroundColor = const Color.fromRGBO(33, 37, 41, 1.0);
Color materialBackgroundColor = Colors.transparent;
Color cardBackgroundColor = const Color.fromRGBO(255, 107, 53, 1.0);
Color splashColor = const Color.fromRGBO(33, 37, 41, 1.0);
Color splashColorTwo = const Color.fromRGBO(215, 145, 119, 1.0);
Color iconColor = const Color.fromRGBO(255, 107, 53, 1.0);
Color textColor = const Color.fromRGBO(255, 107, 53, 1.0);
Color textColorTwo = Colors.white70;
Color dialogBackgroundColor = const Color.fromRGBO(33, 37, 41, 1.0);
Color borderColor = Colors.black;

class MyFirstTeamClassPage extends StatefulWidget with NavigationStates {
  MyFirstTeamClassPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<MyFirstTeamClassPage> createState() => _MyFirstTeamClassPage();
}

class _MyFirstTeamClassPage extends State<MyFirstTeamClassPage> {
  late String? documentId;

  bool _isVisible = true;

  bool isLoading = true;

  void showToast() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  Widget _buildProductItem(BuildContext context, int index) {
    FirstTeamClassNotifier firstTeamClassNotifier =
        Provider.of<FirstTeamClassNotifier>(context);
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
              firstTeamClassNotifier.currentFirstTeamClass =
                  firstTeamClassNotifier.firstTeamClassList[index];
              navigateToSubPage(context);
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
                                firstTeamClassNotifier
                                    .firstTeamClassList[index].image!),
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
                              Text(
                                  firstTeamClassNotifier
                                      .firstTeamClassList[index].name!,
                                  style: GoogleFonts.tenorSans(
                                      color: textColor,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600)),
                              (() {
                                if (firstTeamClassNotifier
                                        .firstTeamClassList[index].captain ==
                                    "Yes") {
                                  return Row(
                                    children: <Widget>[
                                      const SizedBox(width: 10),
                                      Icon(
                                        MdiIcons.shieldCheck,
                                        color: iconColor,
                                      ),
                                    ],
                                  );
                                } else {
                                  return Visibility(
                                    visible: !_isVisible,
                                    child: Icon(
                                      MdiIcons.shieldCheck,
                                      color: iconColor,
                                    ),
                                  );
                                }
                              }()),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                              firstTeamClassNotifier
                                  .firstTeamClassList[index].positionPlaying!,
                              style: GoogleFonts.varela(
                                  color: textColorTwo,
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

  Future navigateToSubPage(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SubPage()));
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

  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? firstTime = prefs.getBool('first_time');

    if (firstTime != null && !firstTime) {
      // Not first time
    } else {
      // First time
      prefs.setBool(networkSharedPreferencesKey, false);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          backgroundColor: dialogBackgroundColor,
          title: Text(
            networkSharedPreferencesTitle,
            style: TextStyle(color: textColor),
          ),
          content: Text(
            networkSharedPreferencesContent,
            style: TextStyle(color: textColor),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                networkSharedPreferencesButton,
                style: TextStyle(color: textColor),
              ),
            )
          ],
        ),
      );
    }
  }

  aboutAppWelcomeDialog() async {
    SharedPreferences appOverviewPrefs = await SharedPreferences.getInstance();
    bool? appOverviewChecked = appOverviewPrefs.getBool('overview_time');

    if (appOverviewChecked != null && !appOverviewChecked) {
      // Not first time
    } else {
      // First time
      appOverviewPrefs.setBool(appOverviewSharedPreferencesKey, false);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          backgroundColor: dialogBackgroundColor,
          title: Text(
            appOverviewSharedPreferencesTitle,
            style: TextStyle(color: textColor),
          ),
          content: SizedBox(
            // height: 220,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: <Widget>[
                  Text(
                    appOverviewSharedPreferencesContentOne,
                    style: TextStyle(color: textColor),
                  ),
                  // Text(
                  //   appOverviewSharedPreferencesContentTwo,
                  //   style: TextStyle(
                  //       color: textColor
                  //   ),
                  // ),
                  Text(
                    appOverviewSharedPreferencesContentThree,
                    style: TextStyle(color: textColor),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                appOverviewSharedPreferencesButton,
                style: TextStyle(color: textColor),
              ),
            )
          ],
        ),
      );
    }
  }

  // toastInitial() async {
  //   SharedPreferences appInitialPrefs = await SharedPreferences.getInstance();
  //   bool? appInitialChecked = appInitialPrefs.getBool('toast_initial');
  //
  //   if (appInitialChecked != null && !appInitialChecked) {
  //     // Not first time
  //   }
  //   else {
  //     // First time
  //     appInitialPrefs.setBool(welcomeOverviewSharedPreferencesKey, false);
  //     Toast.show("You are awesome, welcome. 😎",
  //         duration: Toast.lengthLong,
  //         gravity: Toast.bottom,
  //         webTexColor: cardBackgroundColor,
  //         backgroundColor: textColorTwo,
  //         backgroundRadius: 10
  //     );
  //   }
  // }

  @override
  void initState() {
    FirstTeamClassNotifier firstTeamClassNotifier =
        Provider.of<FirstTeamClassNotifier>(context, listen: false);
    getFirstTeamClass(firstTeamClassNotifier);

    SecondTeamClassNotifier secondTeamClassNotifier =
        Provider.of<SecondTeamClassNotifier>(context, listen: false);
    getSecondTeamClass(secondTeamClassNotifier);

    ThirdTeamClassNotifier thirdTeamClassNotifier =
        Provider.of<ThirdTeamClassNotifier>(context, listen: false);
    getThirdTeamClass(thirdTeamClassNotifier);

    CaptainsNotifier captainsNotifier =
        Provider.of<CaptainsNotifier>(context, listen: false);
    getCaptains(captainsNotifier);

    CoachesNotifier coachesNotifier =
        Provider.of<CoachesNotifier>(context, listen: false);
    getCoaches(coachesNotifier);

    ManagementBodyNotifier managementBodyNotifier =
        Provider.of<ManagementBodyNotifier>(context, listen: false);
    getManagementBody(managementBodyNotifier);

    ClubArialNotifier clubArialNotifier =
        Provider.of<ClubArialNotifier>(context, listen: false);
    getClubArial(clubArialNotifier);

    AchievementsNotifier achievementsNotifier =
        Provider.of<AchievementsNotifier>(context, listen: false);
    getAchievements(achievementsNotifier);

    SideBarNotifier sideBarNotifier =
        Provider.of<SideBarNotifier>(context, listen: false);

    MostAssistsPlayersStatsAndInfoNotifier
        mostAssistsPlayersStatsAndInfoNotifier =
        Provider.of<MostAssistsPlayersStatsAndInfoNotifier>(context,
            listen: false);
    getMostAssistsPlayersStatsAndInfo(mostAssistsPlayersStatsAndInfoNotifier);

    MostFouledYCPlayersStatsAndInfoNotifier
        mostFouledYCPlayersStatsAndInfoNotifier =
        Provider.of<MostFouledYCPlayersStatsAndInfoNotifier>(context,
            listen: false);
    getMostFouledYCPlayersStatsAndInfo(mostFouledYCPlayersStatsAndInfoNotifier);

    MostFouledRCPlayersStatsAndInfoNotifier
        mostFouledRCPlayersStatsAndInfoNotifier =
        Provider.of<MostFouledRCPlayersStatsAndInfoNotifier>(context,
            listen: false);
    getMostFouledRCPlayersStatsAndInfo(mostFouledRCPlayersStatsAndInfoNotifier);

    TopGoalsPlayersStatsAndInfoNotifier topGoalsPlayersStatsAndInfoNotifier =
        Provider.of<TopGoalsPlayersStatsAndInfoNotifier>(context,
            listen: false);
    getTopGoalsPlayersStatsAndInfo(topGoalsPlayersStatsAndInfoNotifier);

    TopGKPlayersStatsAndInfoNotifier topGKPlayersStatsAndInfoNotifier =
        Provider.of<TopGKPlayersStatsAndInfoNotifier>(context, listen: false);
    getTopGKPlayersStatsAndInfo(topGKPlayersStatsAndInfoNotifier);

    TopDefensivePlayersStatsAndInfoNotifier
        topDefensivePlayersStatsAndInfoNotifier =
        Provider.of<TopDefensivePlayersStatsAndInfoNotifier>(context,
            listen: false);
    getTopDefensivePlayersStatsAndInfo(topDefensivePlayersStatsAndInfoNotifier);

    MOTMPlayersStatsAndInfoNotifier mOTMPlayersStatsAndInfoNotifier =
        Provider.of<MOTMPlayersStatsAndInfoNotifier>(context, listen: false);
    getMOTMPlayersStatsAndInfo(mOTMPlayersStatsAndInfoNotifier);

    CumMOTMPlayersStatsAndInfoNotifier cumMOTMPlayersStatsAndInfoNotifier =
        Provider.of<CumMOTMPlayersStatsAndInfoNotifier>(context, listen: false);
    getCumMOTMPlayersStatsAndInfo(cumMOTMPlayersStatsAndInfoNotifier);

    TrainingsAndGamesReelsNotifier trainingsAndGamesReelsNotifier =
        Provider.of<TrainingsAndGamesReelsNotifier>(context, listen: false);
    getTrainingsAndGamesReels(trainingsAndGamesReelsNotifier);

    PlayerOfTheMonthStatsAndInfoNotifier playerOfTheMonthStatsAndInfoNotifier =
        Provider.of<PlayerOfTheMonthStatsAndInfoNotifier>(context,
            listen: false);
    getPlayerOfTheMonthStatsAndInfo(playerOfTheMonthStatsAndInfoNotifier);

    FoundersReviewsCommentNotifier foundersReviewsCommentNotifier =
        Provider.of<FoundersReviewsCommentNotifier>(context, listen: false);
    getFoundersReviewsComment(foundersReviewsCommentNotifier);

    startTime();

    setState(() {
      isLoading = false;
    });

    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    FirstTeamClassNotifier firstTeamClassNotifier =
        Provider.of<FirstTeamClassNotifier>(context);

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
                      icon: Icon(MdiIcons.formatFloatLeft, color: iconColor),
                      onPressed: () {
                        showModalBottomSheet(
                            backgroundColor: modalColor,
                            context: context,
                            builder: (context) => Container(
                                  // height: 250,
                                  decoration: BoxDecoration(
                                    color: modalBackgroundColor,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15)),
                                  ),
                                  child: Material(
                                    color: materialBackgroundColor,
                                    child: InkWell(
                                      splashColor: splashColor,
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
                                                  color: iconColor,
                                                ),
                                                title: Text(
                                                  tablesAndStats,
                                                  style: GoogleFonts.zillaSlab(
                                                      color: textColor),
                                                ),
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .pop(false);
                                                  navigateTablesAndStatsDetails(
                                                      context);
                                                }),
                                            ListTile(
                                                leading: Icon(MdiIcons.atom,
                                                    color: iconColor),
                                                title: Text(
                                                  whoWeAre,
                                                  style: GoogleFonts.zillaSlab(
                                                    color: textColor,
                                                  ),
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
                                                  color: iconColor),
                                              title: Text(
                                                aboutClub,
                                                style: GoogleFonts.zillaSlab(
                                                  color: textColor,
                                                ),
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
                                                    color: iconColor),
                                                title: Text(
                                                  acronymMeanings,
                                                  style: GoogleFonts.zillaSlab(
                                                    color: textColor,
                                                  ),
                                                ),
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .pop(false);
                                                  navigateToAcronymsMeaningsPage(
                                                      context);
                                                }),
                                            ListTile(
                                              leading: Icon(MdiIcons.opacity,
                                                  color: iconColor),
                                              title: Text(
                                                aboutApp,
                                                style: GoogleFonts.zillaSlab(
                                                  color: textColor,
                                                ),
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
                      icon: Icon(MdiIcons.magnify, color: iconColor),
                      onPressed: () {
                        showSearch(
                          context: context,
                          delegate: MyFirstTeamClassSearch(
                              all: firstTeamClassNotifier.firstTeamClassList),
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
                            textAlign: TextAlign.center,
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
                                      snapshot.data
                                              ?.data()!['slivers_page_1'] ??
                                          0,
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
                  itemCount: firstTeamClassNotifier.firstTeamClassList.length,
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            navigateTablesAndStatsDetails(context);
          },
          label: Text(
            fabStats,
            style: TextStyle(color: iconColor),
          ),
          icon: Icon(MdiIcons.alphaSBoxOutline, color: iconColor),
          splashColor: splashColorTwo,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
