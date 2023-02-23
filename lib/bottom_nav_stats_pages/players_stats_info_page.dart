import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:parallax_rain/parallax_rain.dart';
import 'package:provider/provider.dart';

import '../api/coaches_reviews_comment_api.dart';
import '../api/cum_motm_players_stats_info_api.dart';
import '../api/founders_reviews_comment_api.dart';
import '../api/most_assists_players_stats_info_api.dart';
import '../api/most_fouled_rc_players_stats_info_api.dart';
import '../api/most_fouled_yc_players_stats_info_api.dart';
import '../api/motm_players_stats_info_api.dart';
import '../api/player_of_the_month_stats_info_api.dart';
import '../api/top_defensive_players_stats_info_api.dart';
import '../api/top_gk_players_stats_info_api.dart';
import '../api/top_goals_players_stats_info_api.dart';
import '../notifier/coaches_reviews_comment_notifier.dart';
import '../notifier/cum_motm_players_stats_info_notifier.dart';
import '../notifier/founders_reviews_comment_notifier.dart';
import '../notifier/most_assists_players_stats_info_notifier.dart';
import '../notifier/most_fouled_rc_players_stats_info_notifier.dart';
import '../notifier/most_fouled_yc_players_stats_info_notifier.dart';
import '../notifier/motm_players_stats_info_notifier.dart';
import '../notifier/player_of_the_month_stats_info_notifier.dart';
import '../notifier/top_defensive_players_stats_info_notifier.dart';
import '../notifier/top_gk_players_stats_info_notifier.dart';
import '../notifier/top_goals_players_stats_info_notifier.dart';

late TopGoalsPlayersStatsAndInfoNotifier? topGoalsPlayersStatsAndInfoNotifier;
late MostAssistsPlayersStatsAndInfoNotifier
    mostAssistsPlayersStatsAndInfoNotifier;
late MostFouledYCPlayersStatsAndInfoNotifier
    mostFouledYCPlayersStatsAndInfoNotifier;
late MostFouledRCPlayersStatsAndInfoNotifier
    mostFouledRCPlayersStatsAndInfoNotifier;
late PlayerOfTheMonthStatsAndInfoNotifier playerOfTheMonthStatsAndInfoNotifier;
late TopGKPlayersStatsAndInfoNotifier topGKPlayersStatsAndInfoNotifier;
late TopDefensivePlayersStatsAndInfoNotifier
    topDefensivePlayersStatsAndInfoNotifier;
late MOTMPlayersStatsAndInfoNotifier motmPlayersStatsAndInfoNotifier;
late CumMOTMPlayersStatsAndInfoNotifier cumMOTMPlayersStatsAndInfoNotifier;
late CoachesReviewsCommentNotifier coachesReviewsCommentNotifier;
late FoundersReviewsCommentNotifier foundersReviewsCommentNotifier;

Color? backgroundColor = const Color.fromRGBO(21, 29, 59, 1);
Color? appBarTextColor = Colors.white;
Color? appBarBackgroundColor = const Color.fromRGBO(21, 29, 59, 2);
Color? appBarIconColor = Colors.white;
Color? modalColor = Colors.transparent;
Color? modalBackgroundColor = const Color.fromRGBO(21, 29, 59, 1);
Color? materialBackgroundColor = Colors.transparent;
Color? cardBackgroundColor = Colors.white;
Color? splashColor = const Color.fromRGBO(49, 63, 117, 1.0);
Color? iconColor = Colors.white;
Color? textColor = Colors.white;
Color? textColorTwo = Colors.white70;
Color? dialogBackgroundColor = const Color.fromRGBO(21, 29, 59, 1);
Color? borderColor = Colors.black;

late Map<int, Widget> playersTGPAndMAP;

class PlayersStatsAndInfoPage extends StatefulWidget {
  const PlayersStatsAndInfoPage({Key? key}) : super(key: key);

  @override
  State<PlayersStatsAndInfoPage> createState() =>
      _PlayersStatsAndInfoPageState();
}

class _PlayersStatsAndInfoPageState extends State<PlayersStatsAndInfoPage> {
  late ConfettiController _controllerTopCenter;

  Color shadowColor = const Color.fromRGBO(109, 101, 72, 1.0);
  bool isTextPressed = false;

  bool isPressed = false;
  bool _isVisible = true;

  void showToast() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  late SwiperController swiperController;

  int sharedValue = 0;

  @override
  Widget build(BuildContext context) {
    Offset distance = isPressed ? const Offset(2, -2) : const Offset(2, -2);
    double blur = isPressed ? 7.0 : 24.0;

    _controllerTopCenter.play();

    TopGoalsPlayersStatsAndInfoNotifier topGoalsPlayersStatsAndInfoNotifier =
        Provider.of<TopGoalsPlayersStatsAndInfoNotifier>(context);

    MostAssistsPlayersStatsAndInfoNotifier
        mostAssistsPlayersStatsAndInfoNotifier =
        Provider.of<MostAssistsPlayersStatsAndInfoNotifier>(context);

    TopGKPlayersStatsAndInfoNotifier topGKPlayersStatsAndInfoNotifier =
        Provider.of<TopGKPlayersStatsAndInfoNotifier>(context);

    TopDefensivePlayersStatsAndInfoNotifier
        topDefensivePlayersStatsAndInfoNotifier =
        Provider.of<TopDefensivePlayersStatsAndInfoNotifier>(context);

    MostFouledYCPlayersStatsAndInfoNotifier
        mostFouledYCPlayersStatsAndInfoNotifier =
        Provider.of<MostFouledYCPlayersStatsAndInfoNotifier>(context,
            listen: true);

    MostFouledRCPlayersStatsAndInfoNotifier
        mostFouledRCPlayersStatsAndInfoNotifier =
        Provider.of<MostFouledRCPlayersStatsAndInfoNotifier>(context,
            listen: true);

    PlayerOfTheMonthStatsAndInfoNotifier playerOfTheMonthStatsAndInfoNotifier =
        Provider.of<PlayerOfTheMonthStatsAndInfoNotifier>(context);

    MOTMPlayersStatsAndInfoNotifier motmPlayersStatsAndInfoNotifier =
        Provider.of<MOTMPlayersStatsAndInfoNotifier>(context);

    CumMOTMPlayersStatsAndInfoNotifier cumMOTMPlayersStatsAndInfoNotifier =
        Provider.of<CumMOTMPlayersStatsAndInfoNotifier>(context);

    CoachesReviewsCommentNotifier coachesReviewsCommentNotifier =
        Provider.of<CoachesReviewsCommentNotifier>(context);

    FoundersReviewsCommentNotifier foundersReviewsCommentNotifier =
        Provider.of<FoundersReviewsCommentNotifier>(context);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 246, 242, 1),
      body: ParallaxRain(
        dropColors: const [Color.fromRGBO(221, 212, 212, 1.0)],
        trail: true,
        numberOfLayers: 3,
        dropFallSpeed: 2,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Material(
                        shape: Border.all(
                          width: 2,
                        ),
                        color: const Color.fromRGBO(196, 174, 137, 1.0),
                        child: IconButton(
                            onPressed: () {
                              navigateMyApp(context);
                            },
                            icon:
                                const Icon(Icons.arrow_back_ios_new_outlined)),
                      ),
                      const SizedBox(
                        width: 60,
                      ),
                      NeumorphicText(
                        'Coventry Phoenix FC',
                        style: const NeumorphicStyle(
                          depth: 4,
                          color: Color.fromRGBO(205, 133, 133, 1),
                        ),
                        textStyle: NeumorphicTextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(left: 22),
                                    child: Listener(
                                      onPointerDown: (_) => setState(() {
                                        isTextPressed = true;
                                      }),
                                      onPointerUp: (_) => setState(() {
                                        isTextPressed = false;
                                      }),
                                      child: Text(
                                        'Top 10 Goal Scorers',
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                140, 112, 84, 1.0),
                                            shadows: [
                                              for (double i = 1;
                                                  i < (isTextPressed ? 1 : 2);
                                                  i++)
                                                Shadow(
                                                  color: shadowColor,
                                                  blurRadius: 3 * i,
                                                ),
                                            ]),
                                      ),
                                    )),
                                if (topGoalsPlayersStatsAndInfoNotifier
                                    .topGoalsPlayersStatsAndInfoList
                                    .isEmpty) ...[
                                  Center(
                                    child: Container(
                                      height: 330,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 18,
                                            bottom: 18,
                                            left: 8,
                                            right: 8),
                                        child: ClayContainer(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.80,
                                          emboss: true,
                                          spread: 2,
                                          color: const Color.fromRGBO(
                                              237, 237, 237, 1),
                                          depth: 20,
                                          curveType: CurveType.concave,
                                          customBorderRadius:
                                              const BorderRadius.only(
                                                  topRight:
                                                      Radius.elliptical(70, 70),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  topLeft: Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Stack(children: <Widget>[
                                              Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                        // height: 70,
                                                        child: Lottie.asset(
                                                      'assets/json/goal_gif.json',
                                                      // width: MediaQuery.of(context).size.width * 0.80,
                                                      height: 200,
                                                      fit: BoxFit.contain,
                                                    )),
                                                    const SizedBox(height: 20),
                                                    const Text(
                                                      "No Goals Scored Yet",
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            205, 133, 133, 1),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                ] else ...[
                                  Container(
                                    height: 330,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Swiper(
                                      autoplay: true,
                                      viewportFraction: 0.8,
                                      scale: 0.9,
                                      itemCount:
                                          topGoalsPlayersStatsAndInfoNotifier
                                              .topGoalsPlayersStatsAndInfoList
                                              .length,
                                      itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.only(
                                            top: 18,
                                            bottom: 18,
                                            left: 8,
                                            right: 8),
                                        child: ClayContainer(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.90,
                                          emboss: true,
                                          spread: 2,
                                          color: const Color.fromRGBO(
                                              237, 237, 237, 1),
                                          depth: 20,
                                          curveType: CurveType.concave,
                                          customBorderRadius:
                                              const BorderRadius.only(
                                                  topRight:
                                                      Radius.elliptical(70, 70),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  topLeft: Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Stack(
                                              children: <Widget>[
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: Container(
                                                      width: 100.0,
                                                      height: 100.0,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            alignment:
                                                                const Alignment(
                                                                    0, -1),
                                                            image: CachedNetworkImageProvider(
                                                                (topGoalsPlayersStatsAndInfoNotifier
                                                                    .topGoalsPlayersStatsAndInfoList[
                                                                        index]
                                                                    .image)!),
                                                            fit: BoxFit.cover),
                                                            borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10),
                                                        ),
                                                        shape:
                                                            BoxShape.rectangle,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 50.0, top: 40),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Colors
                                                                  .white70),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          (index + 1)
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    205,
                                                                    133,
                                                                    133,
                                                                    1),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        const SizedBox(
                                                          height: 50,
                                                          child:
                                                              VerticalDivider(
                                                            // width: 14,
                                                            thickness: 3,
                                                            color:
                                                                Color.fromRGBO(
                                                                    205,
                                                                    133,
                                                                    133,
                                                                    1),
                                                          ),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            const Text(
                                                              'Position',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black54),
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                            Text(
                                                              '       ${(topGoalsPlayersStatsAndInfoNotifier.topGoalsPlayersStatsAndInfoList[index].playerPosition?.toUpperCase())!}',
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 50),
                                                    Row(
                                                      children: [
                                                        const SizedBox(
                                                          height: 50,
                                                          child:
                                                          VerticalDivider(
                                                            thickness: 3,
                                                            color:
                                                                Color.fromRGBO(
                                                                    97,
                                                                    143,
                                                                    223,
                                                                    1.0),
                                                          ),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            const Text(
                                                              'Preferred Foot',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black54),
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                            Text(
                                                              '       ${(topGoalsPlayersStatsAndInfoNotifier.topGoalsPlayersStatsAndInfoList[index].preferredFoot)!}',
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 20),
                                                    const Divider(
                                                      thickness: 2,
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: <Widget>[
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            const Text(
                                                              '  Name',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            const SizedBox(
                                                              width: 70,
                                                              child: Divider(
                                                                indent: 5,
                                                                thickness: 3,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        130,
                                                                        185,
                                                                        208,
                                                                        1.0),
                                                              ),
                                                            ),
                                                            Text(
                                                              topGoalsPlayersStatsAndInfoNotifier
                                                                  .topGoalsPlayersStatsAndInfoList[
                                                                      index]
                                                                  .playerName!,
                                                              style:
                                                              const TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        150,
                                                                        129,
                                                                        129,
                                                                        1.0),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            const Text(
                                                              '  Goals',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        188,
                                                                        105,
                                                                        66,
                                                                        1.0),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 70,
                                                              child: Divider(
                                                                indent: 5,
                                                                thickness: 3,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        191,
                                                                        146,
                                                                        69,
                                                                        0.3),
                                                              ),
                                                            ),
                                                            Text(
                                                              '      ${topGoalsPlayersStatsAndInfoNotifier.topGoalsPlayersStatsAndInfoList[index].goalsScored}',
                                                              style:
                                                                  const TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        188,
                                                                        105,
                                                                        66,
                                                                        1.0),
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            const Text(
                                                              '  Matches',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            const SizedBox(
                                                              width: 70,
                                                              child: Divider(
                                                                indent: 15,
                                                                thickness: 3,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        125,
                                                                        179,
                                                                        140,
                                                                        1.0),
                                                              ),
                                                            ),
                                                            Text(
                                                              '   ${topGoalsPlayersStatsAndInfoNotifier.topGoalsPlayersStatsAndInfoList[index].matchesPlayed} played',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black54),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      itemWidth:
                                          MediaQuery.of(context).size.width *
                                              0.9,
                                      layout: SwiperLayout.DEFAULT,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                ],
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(left: 22),
                                    child: Listener(
                                      onPointerDown: (_) => setState(() {
                                        isTextPressed = true;
                                      }),
                                      onPointerUp: (_) => setState(() {
                                        isTextPressed = false;
                                      }),
                                      child: Text(
                                        'Top 10 Most Assists Players',
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                140, 112, 84, 1.0),
                                            shadows: [
                                              for (double i = 1;
                                                  i < (isTextPressed ? 1 : 2);
                                                  i++)
                                                Shadow(
                                                  color: shadowColor,
                                                  blurRadius: 3 * i,
                                                ),
                                            ]),
                                      ),
                                    )),
                                if (mostAssistsPlayersStatsAndInfoNotifier
                                    .mostAssistsPlayersStatsAndInfoList
                                    .isEmpty) ...[
                                  Center(
                                    child: Container(
                                      height: 330,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 18,
                                            bottom: 18,
                                            left: 8,
                                            right: 8),
                                        child: ClayContainer(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.80,
                                          emboss: true,
                                          spread: 2,
                                          color: const Color.fromRGBO(
                                              237, 237, 237, 1),
                                          depth: 20,
                                          curveType: CurveType.concave,
                                          customBorderRadius:
                                              const BorderRadius.only(
                                                  topRight:
                                                      Radius.elliptical(70, 70),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  topLeft: Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Stack(children: <Widget>[
                                              Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                        // height: 70,
                                                        child: Lottie.asset(
                                                      'assets/json/assists_gif.json',
                                                      // width: MediaQuery.of(context).size.width * 0.80,
                                                      height: 200,
                                                      fit: BoxFit.contain,
                                                    )),
                                                    const SizedBox(height: 20),
                                                    const Text(
                                                      "No Assists Provided Yet",
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            205, 133, 133, 1),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                ] else ...[
                                  Container(
                                    height: 330,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Swiper(
                                      autoplay: true,
                                      viewportFraction: 0.8,
                                      scale: 0.9,
                                      itemCount:
                                          mostAssistsPlayersStatsAndInfoNotifier
                                              .mostAssistsPlayersStatsAndInfoList
                                              .length,
                                      itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.only(
                                            top: 18,
                                            bottom: 18,
                                            left: 8,
                                            right: 8),
                                        child: ClayContainer(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.90,
                                          emboss: true,
                                          spread: 2,
                                          color: const Color.fromRGBO(
                                              237, 237, 237, 1),
                                          depth: 20,
                                          curveType: CurveType.concave,
                                          customBorderRadius:
                                              const BorderRadius.only(
                                                  topRight:
                                                      Radius.elliptical(70, 70),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  topLeft: Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Stack(
                                              children: <Widget>[
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: Container(
                                                      width: 100.0,
                                                      height: 100.0,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            alignment:
                                                                const Alignment(
                                                                    0, -1),
                                                            image: CachedNetworkImageProvider(
                                                                mostAssistsPlayersStatsAndInfoNotifier
                                                                    .mostAssistsPlayersStatsAndInfoList[
                                                                        index]
                                                                    .image!),
                                                            fit: BoxFit.cover),
                                                            borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10),
                                                        ),
                                                        shape:
                                                            BoxShape.rectangle,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 50.0, top: 40),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Colors
                                                                  .white70),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          (index + 1)
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    205,
                                                                    133,
                                                                    133,
                                                                    1),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Row(
                                                      children: [
                                                        const SizedBox(
                                                          height: 50,
                                                          child:
                                                              VerticalDivider(
                                                            // width: 14,
                                                            thickness: 3,
                                                            color:
                                                                Color.fromRGBO(
                                                                    205,
                                                                    133,
                                                                    133,
                                                                    1),
                                                          ),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            const Text(
                                                              'Position',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black54),
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                            Text(
                                                              '       ${mostAssistsPlayersStatsAndInfoNotifier.mostAssistsPlayersStatsAndInfoList[index].playerPosition?.toUpperCase()}',
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 50),
                                                    Row(
                                                      children: [
                                                        const SizedBox(
                                                          height: 50,
                                                          child:
                                                          VerticalDivider(
                                                            thickness: 3,
                                                            color:
                                                                Color.fromRGBO(
                                                                    97,
                                                                    143,
                                                                    223,
                                                                    1.0),
                                                          ),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            const Text(
                                                              'Preferred Foot',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black54),
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                            Text(
                                                              '       ${mostAssistsPlayersStatsAndInfoNotifier.mostAssistsPlayersStatsAndInfoList[index].preferredFoot!}',
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 20),
                                                    const Divider(
                                                      thickness: 2,
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: <Widget>[
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            const Text(
                                                              '  Name',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            const SizedBox(
                                                              width: 70,
                                                              child: Divider(
                                                                indent: 5,
                                                                thickness: 3,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        130,
                                                                        185,
                                                                        208,
                                                                        1.0),
                                                              ),
                                                            ),
                                                            Text(
                                                              mostAssistsPlayersStatsAndInfoNotifier
                                                                  .mostAssistsPlayersStatsAndInfoList[
                                                                      index]
                                                                  .playerName!,
                                                              style:
                                                              const TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        150,
                                                                        129,
                                                                        129,
                                                                        1.0),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            const Text(
                                                              '  Assists',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        188,
                                                                        105,
                                                                        66,
                                                                        1.0),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 70,
                                                              child: Divider(
                                                                indent: 5,
                                                                thickness: 3,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        191,
                                                                        146,
                                                                        69,
                                                                        0.3),
                                                              ),
                                                            ),
                                                            Text(
                                                              '      ${mostAssistsPlayersStatsAndInfoNotifier.mostAssistsPlayersStatsAndInfoList[index].assists}',
                                                              style:
                                                                  const TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        188,
                                                                        105,
                                                                        66,
                                                                        1.0),
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            const Text(
                                                              '  Matches',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            const SizedBox(
                                                              width: 70,
                                                              child: Divider(
                                                                indent: 15,
                                                                thickness: 3,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        125,
                                                                        179,
                                                                        140,
                                                                        1.0),
                                                              ),
                                                            ),
                                                            Text(
                                                              '   ${mostAssistsPlayersStatsAndInfoNotifier.mostAssistsPlayersStatsAndInfoList[index].matchesPlayed} played',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black54),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      itemWidth:
                                          MediaQuery.of(context).size.width *
                                              0.9,
                                      layout: SwiperLayout.DEFAULT,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                ],
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 22, bottom: 15),
                                    child: Listener(
                                      onPointerDown: (_) => setState(() {
                                        isTextPressed = true;
                                      }),
                                      onPointerUp: (_) => setState(() {
                                        isTextPressed = false;
                                      }),
                                      child: Text(
                                        '8 Most Yellow Carded Players',
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                140, 112, 84, 1.0),
                                            shadows: [
                                              for (double i = 1;
                                                  i < (isTextPressed ? 1 : 2);
                                                  i++)
                                                Shadow(
                                                  color: shadowColor,
                                                  blurRadius: 3 * i,
                                                ),
                                            ]),
                                      ),
                                    )),
                                if (mostFouledYCPlayersStatsAndInfoNotifier
                                    .mostFouledYCPlayersStatsAndInfoList
                                    .isEmpty) ...[
                                  Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      height: 250,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClayContainer(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.35,
                                          emboss: true,
                                          spread: 2,
                                          color: const Color.fromRGBO(
                                              237, 237, 237, 1),
                                          depth: 30,
                                          curveType: CurveType.concave,
                                          customBorderRadius:
                                              const BorderRadius.only(
                                                  topRight: Radius.circular(70),
                                                  bottomLeft:
                                                      Radius.circular(7),
                                                  topLeft: Radius.circular(7),
                                                  bottomRight:
                                                      Radius.circular(7)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Stack(children: <Widget>[
                                              Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                        // height: 70,
                                                        child: Lottie.asset(
                                                      'assets/json/yellowcard_gif.json',
                                                      // width: MediaQuery.of(context).size.width * 0.80,
                                                      height: 150,
                                                      fit: BoxFit.contain,
                                                    )),
                                                    const SizedBox(height: 20),
                                                    const Text(
                                                      "No Yellow Card Given Yet",
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            205, 133, 133, 1),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                ] else ...[
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    width: MediaQuery.of(context).size.width,
                                    height: 250,
                                    child: Center(
                                      child: Swiper(
                                        autoplay: true,
                                        viewportFraction: 0.8,
                                        scale: 0.9,
                                        itemCount:
                                            mostFouledYCPlayersStatsAndInfoNotifier
                                                .mostFouledYCPlayersStatsAndInfoList
                                                .length,
                                        itemBuilder: (context, index) => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Stack(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ClayContainer(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.35,
                                                      emboss: true,
                                                      spread: 2,
                                                      color: const Color.fromRGBO(
                                                          237, 237, 237, 1),
                                                      depth: 30,
                                                      curveType: CurveType
                                                          .concave,
                                                      customBorderRadius:
                                                          const BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(70),
                                                              bottomLeft: Radius
                                                                  .circular(7),
                                                              topLeft: Radius
                                                                  .circular(7),
                                                              bottomRight:
                                                                  Radius.circular(
                                                                      7)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8,
                                                                right: 8,
                                                                top: 70),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: <Widget>[
                                                            const Text(
                                                              'Yellow Cards 🟨',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        217,
                                                                        176,
                                                                        95,
                                                                        1.0),
                                                              ),
                                                            ),
                                                            Text(
                                                                mostFouledYCPlayersStatsAndInfoNotifier
                                                                .mostFouledYCPlayersStatsAndInfoList[
                                                                    index]
                                                                .yellowCard
                                                                .toString()),
                                                            const SizedBox(
                                                                height: 5),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          40.0),
                                                              child: Container(
                                                                decoration: const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Colors
                                                                        .white70),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    (index + 1)
                                                                        .toString(),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 15),
                                                            Center(
                                                              child: Text(
                                                                mostFouledYCPlayersStatsAndInfoNotifier
                                                                    .mostFouledYCPlayersStatsAndInfoList[
                                                                        index]
                                                                    .playerName!,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          150,
                                                                          129,
                                                                          129,
                                                                          1.0),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            )
                                                          ],
                                                        ),
                                                      )),
                                                ),
                                                ClayContainer(
                                                  emboss: true,
                                                  spread: 2,
                                                  color: const Color.fromRGBO(
                                                      237, 237, 237, 1),
                                                  depth: 49,
                                                  // borderRadius: 75,
                                                  curveType: CurveType.concave,
                                                  customBorderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(40)),
                                                  child: Container(
                                                    width: 70.0,
                                                    height: 70.0,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Colors.transparent,
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                            colorFilter:
                                                                const ColorFilter
                                                                        .mode(
                                                                    Colors.grey,
                                                                    BlendMode
                                                                        .saturation),
                                                            alignment:
                                                                const Alignment(
                                                                    0, -1),
                                                            image: CachedNetworkImageProvider(
                                                                mostFouledYCPlayersStatsAndInfoNotifier
                                                                    .mostFouledYCPlayersStatsAndInfoList[
                                                                        index]
                                                                    .image!),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 20),
                                          ],
                                        ),
                                        control: const SwiperControl(
                                            color: Color.fromRGBO(
                                                109, 101, 72, 1.0)),
                                        itemWidth: 250,
                                        layout: SwiperLayout.STACK,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                ],
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 22, bottom: 15),
                                    child: Listener(
                                      onPointerDown: (_) => setState(() {
                                        isTextPressed = true;
                                      }),
                                      onPointerUp: (_) => setState(() {
                                        isTextPressed = false;
                                      }),
                                      child: Text(
                                        '8 Most Red Carded Players',
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                140, 112, 84, 1.0),
                                            shadows: [
                                              for (double i = 1;
                                                  i < (isTextPressed ? 1 : 2);
                                                  i++)
                                                Shadow(
                                                  color: shadowColor,
                                                  blurRadius: 3 * i,
                                                ),
                                            ]),
                                      ),
                                    )),
                                if (mostFouledRCPlayersStatsAndInfoNotifier
                                    .mostFouledRCPlayersStatsAndInfoList
                                    .isEmpty) ...[
                                  Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      height: 270,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClayContainer(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.35,
                                          emboss: true,
                                          spread: 2,
                                          color: const Color.fromRGBO(
                                              237, 237, 237, 1),
                                          depth: 30,
                                          curveType: CurveType.concave,
                                          customBorderRadius:
                                              const BorderRadius.only(
                                                  topRight: Radius.circular(70),
                                                  bottomLeft:
                                                      Radius.circular(7),
                                                  topLeft: Radius.circular(7),
                                                  bottomRight:
                                                      Radius.circular(7)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Stack(children: <Widget>[
                                              Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                        // height: 70,
                                                        child: Lottie.asset(
                                                      'assets/json/redcard_two_gif.json',
                                                      // width: MediaQuery.of(context).size.width * 0.80,
                                                      height: 120,
                                                      fit: BoxFit.contain,
                                                    )),
                                                    const SizedBox(height: 20),
                                                    const Text(
                                                      "No Bad Boy or Coach 👀\n Booked Yet",
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            205, 133, 133, 1),
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    )
                                                  ],
                                                ),
                                              )
                                            ]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                ] else ...[
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    width: MediaQuery.of(context).size.width,
                                    height: 250,
                                    child: Center(
                                      child: Swiper(
                                        autoplay: true,
                                        viewportFraction: 0.8,
                                        scale: 0.9,
                                        itemCount:
                                            mostFouledRCPlayersStatsAndInfoNotifier
                                                .mostFouledRCPlayersStatsAndInfoList
                                                .length,
                                        itemBuilder: (context, index) => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Stack(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ClayContainer(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.35,
                                                      emboss: true,
                                                      spread: 2,
                                                      color: const Color.fromRGBO(
                                                          237, 237, 237, 1),
                                                      depth: 49,
                                                      curveType: CurveType
                                                          .concave,
                                                      customBorderRadius:
                                                          const BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(70),
                                                              bottomLeft: Radius
                                                                  .circular(7),
                                                              topLeft: Radius
                                                                  .circular(7),
                                                              bottomRight:
                                                                  Radius.circular(
                                                                      7)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8,
                                                                right: 8,
                                                                top: 70),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: <Widget>[
                                                            const Text(
                                                              'Red Cards 🟥',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        212,
                                                                        45,
                                                                        45,
                                                                        1.0),
                                                              ),
                                                            ),
                                                            Text(
                                                                mostFouledRCPlayersStatsAndInfoNotifier
                                                                .mostFouledRCPlayersStatsAndInfoList[
                                                                    index]
                                                                .redCard
                                                                .toString()),
                                                            const SizedBox(
                                                                height: 5),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          40.0),
                                                              child: Container(
                                                                decoration: const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Colors
                                                                        .white70),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    (index + 1)
                                                                        .toString(),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 15),
                                                            Center(
                                                              child: Text(
                                                                mostFouledRCPlayersStatsAndInfoNotifier
                                                                    .mostFouledRCPlayersStatsAndInfoList[
                                                                        index]
                                                                    .playerName!,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          150,
                                                                          129,
                                                                          129,
                                                                          1.0),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            )
                                                          ],
                                                        ),
                                                      )),
                                                ),
                                                ClayContainer(
                                                  emboss: true,
                                                  spread: 2,
                                                  color: const Color.fromRGBO(
                                                      237, 237, 237, 1),
                                                  depth: 49,
                                                  // borderRadius: 75,
                                                  curveType: CurveType.concave,
                                                  customBorderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(40)),
                                                  child: Container(
                                                    width: 70.0,
                                                    height: 70.0,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Colors.transparent,
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                            colorFilter:
                                                                const ColorFilter
                                                                        .mode(
                                                                    Colors.grey,
                                                                    BlendMode
                                                                        .saturation),
                                                            alignment:
                                                                const Alignment(
                                                                    0, -1),
                                                            image: CachedNetworkImageProvider(
                                                                mostFouledRCPlayersStatsAndInfoNotifier
                                                                    .mostFouledRCPlayersStatsAndInfoList[
                                                                        index]
                                                                    .image!),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 20),
                                          ],
                                        ),
                                        control: const SwiperControl(
                                          color:
                                              Color.fromRGBO(109, 101, 72, 1.0),
                                        ),
                                        itemWidth: 250,
                                        layout: SwiperLayout.STACK,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                ],
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(left: 22),
                                    child: Listener(
                                      onPointerDown: (_) => setState(() {
                                        isTextPressed = true;
                                      }),
                                      onPointerUp: (_) => setState(() {
                                        isTextPressed = false;
                                      }),
                                      child: Text(
                                        'Top Goal Keepers',
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                140, 112, 84, 1.0),
                                            shadows: [
                                              for (double i = 1;
                                                  i < (isTextPressed ? 1 : 2);
                                                  i++)
                                                Shadow(
                                                  color: shadowColor,
                                                  blurRadius: 3 * i,
                                                ),
                                            ]),
                                      ),
                                    )),
                                if (topGKPlayersStatsAndInfoNotifier
                                    .topGKPlayersStatsAndInfoList.isEmpty) ...[
                                  Center(
                                    child: Container(
                                      height: 330,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 18,
                                            bottom: 18,
                                            left: 8,
                                            right: 8),
                                        child: ClayContainer(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.80,
                                          emboss: true,
                                          spread: 2,
                                          color: const Color.fromRGBO(
                                              237, 237, 237, 1),
                                          depth: 20,
                                          curveType: CurveType.concave,
                                          customBorderRadius:
                                              const BorderRadius.only(
                                                  topRight:
                                                      Radius.elliptical(70, 70),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  topLeft: Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Stack(children: <Widget>[
                                              Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                        // height: 70,
                                                        child: Lottie.asset(
                                                      'assets/json/top_goal_keeper_gif.json',
                                                      // width: MediaQuery.of(context).size.width * 0.80,
                                                      height: 200,
                                                      fit: BoxFit.contain,
                                                    )),
                                                    const SizedBox(height: 20),
                                                    const Text(
                                                      "No GoalKeepers' Clean Sheet Yet",
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            205, 133, 133, 1),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                ] else ...[
                                  Container(
                                    height: 330,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Swiper(
                                      autoplay: true,
                                      viewportFraction: 0.8,
                                      scale: 0.9,
                                      itemCount:
                                          topGKPlayersStatsAndInfoNotifier
                                              .topGKPlayersStatsAndInfoList
                                              .length,
                                      itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.only(
                                            top: 18,
                                            bottom: 18,
                                            left: 8,
                                            right: 8),
                                        child: ClayContainer(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.90,
                                          emboss: true,
                                          spread: 2,
                                          color: const Color.fromRGBO(
                                              237, 237, 237, 1),
                                          depth: 20,
                                          curveType: CurveType.concave,
                                          customBorderRadius:
                                              const BorderRadius.only(
                                                  topRight:
                                                      Radius.elliptical(70, 70),
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  topLeft: Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Stack(
                                              children: <Widget>[
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: Container(
                                                      width: 100.0,
                                                      height: 100.0,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            alignment:
                                                                const Alignment(
                                                                    0, -1),
                                                            image: CachedNetworkImageProvider(
                                                                topGKPlayersStatsAndInfoNotifier
                                                                    .topGKPlayersStatsAndInfoList[
                                                                        index]
                                                                    .image!),
                                                            fit: BoxFit.cover),
                                                            borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10),
                                                        ),
                                                        shape:
                                                            BoxShape.rectangle,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 50.0, top: 40),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Colors
                                                                  .white70),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          (index + 1)
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    205,
                                                                    133,
                                                                    133,
                                                                    1),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Row(
                                                      children: [
                                                        const SizedBox(
                                                          height: 50,
                                                          child:
                                                              VerticalDivider(
                                                            // width: 14,
                                                            thickness: 3,
                                                            color:
                                                                Color.fromRGBO(
                                                                    205,
                                                                    133,
                                                                    133,
                                                                    1),
                                                          ),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            const Text(
                                                              'Position',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black54),
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                            Text(
                                                              '       ${topGKPlayersStatsAndInfoNotifier.topGKPlayersStatsAndInfoList[index].playerPosition?.toUpperCase()}',
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 50),
                                                    Row(
                                                      children: [
                                                        const SizedBox(
                                                          height: 50,
                                                          child:
                                                          VerticalDivider(
                                                            thickness: 3,
                                                            color:
                                                                Color.fromRGBO(
                                                                    97,
                                                                    143,
                                                                    223,
                                                                    1.0),
                                                          ),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            const Text(
                                                              'Name',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black54),
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                            Text(
                                                              '       ${topGKPlayersStatsAndInfoNotifier.topGKPlayersStatsAndInfoList[index].playerName!}',
                                                              style:
                                                              const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        150,
                                                                        129,
                                                                        129,
                                                                        1.0),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 20),
                                                    const Divider(
                                                      thickness: 2,
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: <Widget>[
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            const Text(
                                                              'Goals Con.',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            const SizedBox(
                                                              width: 70,
                                                              child: Divider(
                                                                indent: 5,
                                                                thickness: 3,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        130,
                                                                        185,
                                                                        208,
                                                                        1.0),
                                                              ),
                                                            ),
                                                            Text(
                                                              '      ${topGKPlayersStatsAndInfoNotifier.topGKPlayersStatsAndInfoList[index].goalsConcededGkDef.toString()}',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black54),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            const Text(
                                                              'Clean Sheets',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        188,
                                                                        105,
                                                                        66,
                                                                        1.0),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 70,
                                                              child: Divider(
                                                                indent: 5,
                                                                thickness: 3,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        191,
                                                                        146,
                                                                        69,
                                                                        0.3),
                                                              ),
                                                            ),
                                                            Text(
                                                              '      ${topGKPlayersStatsAndInfoNotifier.topGKPlayersStatsAndInfoList[index].cleanSheetGk}',
                                                              style:
                                                                  const TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        188,
                                                                        105,
                                                                        66,
                                                                        1.0),
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .right,
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            const Text(
                                                              'Matches',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            const SizedBox(
                                                              width: 60,
                                                              child: Divider(
                                                                indent: 10,
                                                                thickness: 3,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        125,
                                                                        179,
                                                                        140,
                                                                        1.0),
                                                              ),
                                                            ),
                                                            Text(
                                                              '${topGKPlayersStatsAndInfoNotifier.topGKPlayersStatsAndInfoList[index].matchesPlayed} played',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black54),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      itemWidth:
                                          MediaQuery.of(context).size.width *
                                              0.9,
                                      layout: SwiperLayout.DEFAULT,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                ],
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(left: 22),
                                    child: Listener(
                                      onPointerDown: (_) => setState(() {
                                        isTextPressed = true;
                                      }),
                                      onPointerUp: (_) => setState(() {
                                        isTextPressed = false;
                                      }),
                                      child: Text(
                                        'Top 10 Defensive Players',
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                140, 112, 84, 1.0),
                                            shadows: [
                                              for (double i = 1;
                                                  i < (isTextPressed ? 1 : 2);
                                                  i++)
                                                Shadow(
                                                  color: shadowColor,
                                                  blurRadius: 3 * i,
                                                ),
                                            ]),
                                      ),
                                    )),
                                Container(
                                  height: 330,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Swiper(
                                    autoplay: true,
                                    viewportFraction: 0.8,
                                    scale: 0.9,
                                    itemCount:
                                        topDefensivePlayersStatsAndInfoNotifier
                                            .topDefensivePlayersStatsAndInfoList
                                            .length,
                                    itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.only(
                                          top: 18,
                                          bottom: 18,
                                          left: 8,
                                          right: 8),
                                      child: ClayContainer(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.90,
                                        emboss: true,
                                        spread: 2,
                                        color: const Color.fromRGBO(
                                            237, 237, 237, 1),
                                        depth: 20,
                                        curveType: CurveType.concave,
                                        customBorderRadius:
                                            const BorderRadius.only(
                                                topRight:
                                                    Radius.elliptical(70, 70),
                                                bottomLeft: Radius.circular(10),
                                                topLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Stack(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Container(
                                                    width: 100.0,
                                                    height: 100.0,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          alignment:
                                                              const Alignment(
                                                                  0, -1),
                                                          image: CachedNetworkImageProvider(
                                                              topDefensivePlayersStatsAndInfoNotifier
                                                                  .topDefensivePlayersStatsAndInfoList[
                                                                      index]
                                                                  .image!),
                                                          fit: BoxFit.cover),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                      ),
                                                      shape: BoxShape.rectangle,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 50.0, top: 40),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color:
                                                                Colors.white70),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        (index + 1).toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          color: Color.fromRGBO(
                                                              205, 133, 133, 1),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(
                                                    children: [
                                                      const SizedBox(
                                                        height: 50,
                                                        child: VerticalDivider(
                                                          // width: 14,
                                                          thickness: 3,
                                                          color: Color.fromRGBO(
                                                              205, 133, 133, 1),
                                                        ),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: <Widget>[
                                                          const Text(
                                                            'Position',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          Text(
                                                            '       ${topDefensivePlayersStatsAndInfoNotifier
                                                                .topDefensivePlayersStatsAndInfoList[index]
                                                                .playerPosition
                                                                ?.toUpperCase()}',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 50),
                                                  Row(
                                                    children: [
                                                      const SizedBox(
                                                        height: 50,
                                                        child: VerticalDivider(
                                                          thickness: 3,
                                                          color: Color.fromRGBO(
                                                              97,
                                                              143,
                                                              223,
                                                              1.0),
                                                        ),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: <Widget>[
                                                          const Text(
                                                            'Preferred Foot',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          Text(
                                                            '       ${topDefensivePlayersStatsAndInfoNotifier
                                                                .topDefensivePlayersStatsAndInfoList[index]
                                                                .preferredFoot!}',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 20),
                                                  const Divider(
                                                    thickness: 2,
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                    children: <Widget>[
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: <Widget>[
                                                          const Text(
                                                            'Name',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                          ),
                                                          const SizedBox(
                                                            width: 70,
                                                            child: Divider(
                                                              indent: 5,
                                                              thickness: 3,
                                                              color: Color
                                                                  .fromRGBO(
                                                                  130,
                                                                  185,
                                                                  208,
                                                                  1.0),
                                                            ),
                                                          ),
                                                          Text(
                                                            '   ${topDefensivePlayersStatsAndInfoNotifier.topDefensivePlayersStatsAndInfoList[index].playerName!}',
                                                            style:
                                                            const TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                  150,
                                                                  129,
                                                                  129,
                                                                  1.0),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: <Widget>[
                                                          const Text(
                                                            'Goals Con.',
                                                            style: TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              color: Color
                                                                  .fromRGBO(
                                                                  188,
                                                                  105,
                                                                  66,
                                                                  1.0),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 70,
                                                            child: Divider(
                                                              indent: 5,
                                                              thickness: 3,
                                                              color: Color
                                                                  .fromRGBO(
                                                                  191,
                                                                  146,
                                                                  69,
                                                                  0.3),
                                                            ),
                                                          ),
                                                          Text(
                                                            '      ${topDefensivePlayersStatsAndInfoNotifier.topDefensivePlayersStatsAndInfoList[index].goalsConcededGkDef}',
                                                            style:
                                                            const TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                  188,
                                                                  105,
                                                                  66,
                                                                  1.0),
                                                            ),
                                                            textAlign:
                                                            TextAlign.right,
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: <Widget>[
                                                          const Text(
                                                            'Matches',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                          ),
                                                          const SizedBox(
                                                            width: 60,
                                                            child: Divider(
                                                              indent: 10,
                                                              thickness: 3,
                                                              color: Color
                                                                  .fromRGBO(
                                                                  125,
                                                                  179,
                                                                  140,
                                                                  1.0),
                                                            ),
                                                          ),
                                                          Text(
                                                            '${topDefensivePlayersStatsAndInfoNotifier.topDefensivePlayersStatsAndInfoList[index].matchesPlayed} played',
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                    itemWidth:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.9,
                                    layout: SwiperLayout.DEFAULT,
                                  ),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(left: 22),
                                    child: Listener(
                                      onPointerDown: (_) => setState(() {
                                        isTextPressed = true;
                                      }),
                                      onPointerUp: (_) => setState(() {
                                        isTextPressed = false;
                                      }),
                                      child: Text(
                                        'Weekly MOTM Players',
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                140, 112, 84, 1.0),
                                            shadows: [
                                              for (double i = 1;
                                              i < (isTextPressed ? 1 : 2);
                                              i++)
                                                Shadow(
                                                  color: shadowColor,
                                                  blurRadius: 3 * i,
                                                ),
                                            ]),
                                      ),
                                    )),
                                if (motmPlayersStatsAndInfoNotifier
                                    .mOTMPlayersStatsAndInfoList.isEmpty) ...[
                                  Center(
                                    child: Container(
                                      height: 330,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 18,
                                            bottom: 18,
                                            left: 8,
                                            right: 8),
                                        child: ClayContainer(
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width *
                                              0.80,
                                          emboss: true,
                                          spread: 2,
                                          color: const Color.fromRGBO(
                                              237, 237, 237, 1),
                                          depth: 20,
                                          curveType: CurveType.concave,
                                          customBorderRadius:
                                          const BorderRadius.only(
                                              topRight:
                                              Radius.elliptical(70, 70),
                                              bottomLeft:
                                              Radius.circular(10),
                                              topLeft: Radius.circular(10),
                                              bottomRight:
                                              Radius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Stack(children: <Widget>[
                                              Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      // height: 70,
                                                        child: Lottie.asset(
                                                          'assets/json/motm_award.json',
                                                          // width: MediaQuery.of(context).size.width * 0.80,
                                                          height: 200,
                                                          fit: BoxFit.contain,
                                                        )),
                                                    const SizedBox(height: 20),
                                                    const Text(
                                                      "No MOTM Players Yet",
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            205, 133, 133, 1),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                ] else ...[
                                  Container(
                                    height: 330,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    child: Swiper(
                                      autoplay: true,
                                      viewportFraction: 0.8,
                                      scale: 0.9,
                                      itemCount: motmPlayersStatsAndInfoNotifier
                                          .mOTMPlayersStatsAndInfoList.length,
                                      itemBuilder: (context, index) =>
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 18,
                                                bottom: 18,
                                            left: 8,
                                            right: 8),
                                        child: ClayContainer(
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width *
                                              0.90,
                                          emboss: true,
                                          spread: 2,
                                          color: const Color.fromRGBO(
                                              237, 237, 237, 1),
                                          depth: 20,
                                          curveType: CurveType.concave,
                                          customBorderRadius:
                                          const BorderRadius.only(
                                              topRight:
                                              Radius.elliptical(70, 70),
                                              bottomLeft:
                                              Radius.circular(10),
                                              topLeft: Radius.circular(10),
                                              bottomRight:
                                              Radius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Stack(
                                              children: <Widget>[
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.all(
                                                        15.0),
                                                    child: Container(
                                                      width: 100.0,
                                                      height: 100.0,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            alignment:
                                                            const Alignment(
                                                                0, -1),
                                                            image: CachedNetworkImageProvider(
                                                                (motmPlayersStatsAndInfoNotifier
                                                                    .mOTMPlayersStatsAndInfoList[
                                                                index]
                                                                    .image)!),
                                                            fit: BoxFit.cover),
                                                        borderRadius:
                                                        const BorderRadius
                                                            .only(
                                                          topLeft:
                                                          Radius.circular(
                                                              10),
                                                          bottomLeft:
                                                          Radius.circular(
                                                              10),
                                                          topRight:
                                                          Radius.circular(
                                                              10),
                                                          bottomRight:
                                                          Radius.circular(
                                                              10),
                                                        ),
                                                        shape:
                                                        BoxShape.rectangle,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      right: 50.0, top: 40),
                                                  child: Align(
                                                    alignment:
                                                    Alignment.centerRight,
                                                    child: Container(
                                                      decoration:
                                                      const BoxDecoration(
                                                          shape: BoxShape
                                                              .circle,
                                                          color: Colors
                                                              .white70),
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .all(8.0),
                                                        child: Text(
                                                          (index + 1)
                                                              .toString(),
                                                          textAlign:
                                                          TextAlign.center,
                                                          style:
                                                          const TextStyle(
                                                            color:
                                                            Color.fromRGBO(
                                                                205,
                                                                133,
                                                                133,
                                                                1),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Row(
                                                      children: [
                                                        const SizedBox(
                                                          height: 50,
                                                          child:
                                                          VerticalDivider(
                                                            // width: 14,
                                                            thickness: 3,
                                                            color:
                                                            Color.fromRGBO(
                                                                205,
                                                                133,
                                                                133,
                                                                1),
                                                          ),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: <Widget>[
                                                            const Text(
                                                              'Position',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black54),
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                            Text(
                                                              '       ${motmPlayersStatsAndInfoNotifier
                                                                  .mOTMPlayersStatsAndInfoList[index]
                                                                  .playerPosition
                                                                  ?.toUpperCase()}',
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 50),
                                                    Row(
                                                      children: [
                                                        const SizedBox(
                                                          height: 50,
                                                          child:
                                                          VerticalDivider(
                                                            thickness: 3,
                                                            color:
                                                            Color.fromRGBO(
                                                                97,
                                                                143,
                                                                223,
                                                                1.0),
                                                          ),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: <Widget>[
                                                            const Text(
                                                              'Preferred Foot',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black54),
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                            Text(
                                                              '       ${(motmPlayersStatsAndInfoNotifier
                                                                  .mOTMPlayersStatsAndInfoList[index]
                                                                  .preferredFoot)!}',
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 20),
                                                    const Divider(
                                                      thickness: 2,
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: <Widget>[
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: <Widget>[
                                                            const Text(
                                                              'Name',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                            ),
                                                            const SizedBox(
                                                              width: 70,
                                                              child: Divider(
                                                                indent: 5,
                                                                thickness: 3,
                                                                color: Color
                                                                    .fromRGBO(
                                                                    130,
                                                                    185,
                                                                    208,
                                                                    1.0),
                                                              ),
                                                            ),
                                                            Text(
                                                              '   ${motmPlayersStatsAndInfoNotifier.mOTMPlayersStatsAndInfoList[index].playerName!}',
                                                              style:
                                                              const TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                    150,
                                                                    129,
                                                                    129,
                                                                    1.0),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: <Widget>[
                                                            const Text(
                                                              'Matches',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                            ),
                                                            const SizedBox(
                                                              width: 60,
                                                              child: Divider(
                                                                indent: 10,
                                                                thickness: 3,
                                                                color: Color
                                                                    .fromRGBO(
                                                                    125,
                                                                    179,
                                                                    140,
                                                                    1.0),
                                                              ),
                                                            ),
                                                            Text(
                                                              '${motmPlayersStatsAndInfoNotifier.mOTMPlayersStatsAndInfoList[index].matchesPlayed} played',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black54),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                          ),
                                      itemWidth:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .width *
                                          0.9,
                                      layout: SwiperLayout.DEFAULT,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                ],
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(left: 22),
                                    child: Listener(
                                      onPointerDown: (_) => setState(() {
                                        isTextPressed = true;
                                      }),
                                      onPointerUp: (_) => setState(() {
                                        isTextPressed = false;
                                      }),
                                      child: Text(
                                        'Most Awarded MOTM Players',
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                140, 112, 84, 1.0),
                                            shadows: [
                                              for (double i = 1;
                                              i < (isTextPressed ? 1 : 2);
                                              i++)
                                                Shadow(
                                                  color: shadowColor,
                                                  blurRadius: 3 * i,
                                                ),
                                            ]),
                                      ),
                                    )),
                                if (cumMOTMPlayersStatsAndInfoNotifier
                                    .cumMOTMPlayersStatsAndInfoList
                                    .isEmpty) ...[
                                  Center(
                                    child: Container(
                                      height: 330,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 18,
                                            bottom: 18,
                                            left: 8,
                                            right: 8),
                                        child: ClayContainer(
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width *
                                              0.80,
                                          emboss: true,
                                          spread: 2,
                                          color: const Color.fromRGBO(
                                              237, 237, 237, 1),
                                          depth: 20,
                                          curveType: CurveType.concave,
                                          customBorderRadius:
                                          const BorderRadius.only(
                                              topRight:
                                              Radius.elliptical(70, 70),
                                              bottomLeft:
                                              Radius.circular(10),
                                              topLeft: Radius.circular(10),
                                              bottomRight:
                                              Radius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Stack(children: <Widget>[
                                              Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      // height: 70,
                                                        child: Lottie.asset(
                                                          'assets/json/cum_motm_award.json',
                                                          // width: MediaQuery.of(context).size.width * 0.80,
                                                          height: 200,
                                                          fit: BoxFit.contain,
                                                        )),
                                                    const SizedBox(height: 20),
                                                    const Text(
                                                      "No MOTM Players Yet",
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            205, 133, 133, 1),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                ] else ...[
                                  Container(
                                    height: 330,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    child: Swiper(
                                      autoplay: true,
                                      viewportFraction: 0.8,
                                      scale: 0.9,
                                      itemCount:
                                      cumMOTMPlayersStatsAndInfoNotifier
                                          .cumMOTMPlayersStatsAndInfoList
                                          .length,
                                      itemBuilder: (context, index) =>
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 18,
                                                bottom: 18,
                                                left: 8,
                                                right: 8),
                                            child: ClayContainer(
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width *
                                                  0.90,
                                              emboss: true,
                                              spread: 2,
                                              color: const Color.fromRGBO(
                                                  237, 237, 237, 1),
                                              depth: 20,
                                              curveType: CurveType.concave,
                                              customBorderRadius:
                                              const BorderRadius.only(
                                                  topRight:
                                                  Radius.elliptical(70, 70),
                                                  bottomLeft:
                                                  Radius.circular(10),
                                                  topLeft: Radius.circular(10),
                                                  bottomRight:
                                                  Radius.circular(10)),
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                    15.0),
                                                child: Stack(
                                                  children: <Widget>[
                                                    Align(
                                                      alignment: Alignment
                                                          .topRight,
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                        child: Container(
                                                          width: 100.0,
                                                          height: 100.0,
                                                          decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                                alignment:
                                                                const Alignment(
                                                                    0, -1),
                                                                image: CachedNetworkImageProvider(
                                                                    cumMOTMPlayersStatsAndInfoNotifier
                                                                        .cumMOTMPlayersStatsAndInfoList[
                                                                    index]
                                                                        .image!),
                                                                fit: BoxFit
                                                                    .cover),
                                                            borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                              topLeft:
                                                              Radius.circular(
                                                                  10),
                                                              bottomLeft:
                                                              Radius.circular(
                                                                  10),
                                                              topRight:
                                                              Radius.circular(
                                                                  10),
                                                              bottomRight:
                                                              Radius.circular(
                                                                  10),
                                                            ),
                                                            shape:
                                                            BoxShape.rectangle,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      right: 50.0, top: 40),
                                                  child: Align(
                                                    alignment:
                                                    Alignment.centerRight,
                                                    child: Container(
                                                      decoration:
                                                      const BoxDecoration(
                                                          shape: BoxShape
                                                              .circle,
                                                          color: Colors
                                                              .white70),
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .all(8.0),
                                                        child: Text(
                                                          (index + 1)
                                                              .toString(),
                                                          textAlign:
                                                          TextAlign.center,
                                                          style:
                                                          const TextStyle(
                                                            color:
                                                            Color.fromRGBO(
                                                                205,
                                                                133,
                                                                133,
                                                                1),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Row(
                                                      children: [
                                                        const SizedBox(
                                                          height: 50,
                                                          child:
                                                          VerticalDivider(
                                                            // width: 14,
                                                            thickness: 3,
                                                            color:
                                                            Color.fromRGBO(
                                                                205,
                                                                133,
                                                                133,
                                                                1),
                                                          ),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: <Widget>[
                                                            const Text(
                                                              'Position',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black54),
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                            Text(
                                                              '       ${cumMOTMPlayersStatsAndInfoNotifier
                                                                  .cumMOTMPlayersStatsAndInfoList[index]
                                                                  .playerPosition
                                                                  ?.toUpperCase()}',
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 50),
                                                    Row(
                                                      children: [
                                                        const SizedBox(
                                                          height: 50,
                                                          child:
                                                          VerticalDivider(
                                                            thickness: 3,
                                                            color:
                                                            Color.fromRGBO(
                                                                97,
                                                                143,
                                                                223,
                                                                1.0),
                                                          ),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: <Widget>[
                                                            const Text(
                                                              'Preferred Foot',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black54),
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                            Text(
                                                              '       ${cumMOTMPlayersStatsAndInfoNotifier
                                                                  .cumMOTMPlayersStatsAndInfoList[index]
                                                                  .preferredFoot!}',
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 20),
                                                    const Divider(
                                                      thickness: 2,
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                      children: <Widget>[
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: <Widget>[
                                                            const Text(
                                                              'Name',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                            ),
                                                            const SizedBox(
                                                              width: 70,
                                                              child: Divider(
                                                                indent: 5,
                                                                thickness: 3,
                                                                color: Color
                                                                    .fromRGBO(
                                                                    130,
                                                                    185,
                                                                    208,
                                                                    1.0),
                                                              ),
                                                            ),
                                                            Text(
                                                                '   ${cumMOTMPlayersStatsAndInfoNotifier.cumMOTMPlayersStatsAndInfoList[index].playerName!}',
                                                                style:
                                                                const TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                      150,
                                                                      129,
                                                                      129,
                                                                      1.0),
                                                                ),
                                                                overflow:
                                                                TextOverflow
                                                                    .ellipsis),
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: <Widget>[
                                                            const Text(
                                                              'MOTM Count',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                color: Color
                                                                    .fromRGBO(
                                                                    188,
                                                                    105,
                                                                    66,
                                                                    1.0),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 70,
                                                              child: Divider(
                                                                indent: 5,
                                                                thickness: 3,
                                                                color: Color
                                                                    .fromRGBO(
                                                                    191,
                                                                    146,
                                                                    69,
                                                                    0.3),
                                                              ),
                                                            ),
                                                            Text(
                                                                '      ${cumMOTMPlayersStatsAndInfoNotifier.cumMOTMPlayersStatsAndInfoList[index].cumMOTMCount}',
                                                                style:
                                                                const TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                      188,
                                                                      105,
                                                                      66,
                                                                      1.0),
                                                                ),
                                                                textAlign:
                                                                TextAlign
                                                                    .right,
                                                                overflow:
                                                                TextOverflow
                                                                    .ellipsis),
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: <Widget>[
                                                            const Text(
                                                                'Matches',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                                overflow:
                                                                TextOverflow
                                                                    .ellipsis),
                                                            const SizedBox(
                                                              width: 60,
                                                              child: Divider(
                                                                indent: 10,
                                                                thickness: 3,
                                                                color: Color
                                                                    .fromRGBO(
                                                                    125,
                                                                    179,
                                                                    140,
                                                                    1.0),
                                                              ),
                                                            ),
                                                            Text(
                                                                '${cumMOTMPlayersStatsAndInfoNotifier
                                                                    .cumMOTMPlayersStatsAndInfoList[index]
                                                                    .matchesPlayed} played',
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black54),
                                                                overflow:
                                                                TextOverflow
                                                                    .ellipsis),
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                      itemWidth:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .width *
                                          0.9,
                                      layout: SwiperLayout.DEFAULT,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                ],
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(left: 22),
                                    child: Listener(
                                      onPointerDown: (_) => setState(() {
                                        isTextPressed = true;
                                      }),
                                      onPointerUp: (_) => setState(() {
                                        isTextPressed = false;
                                      }),
                                      child: Text(
                                        "Coaches' Monthly Comments",
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                140, 112, 84, 1.0),
                                            shadows: [
                                              for (double i = 1;
                                              i < (isTextPressed ? 1 : 2);
                                              i++)
                                                Shadow(
                                                  color: shadowColor,
                                                  blurRadius: 3 * i,
                                                ),
                                            ]),
                                      ),
                                    )),
                                if (coachesReviewsCommentNotifier
                                    .coachesReviewsCommentList.isEmpty) ...[
                                  Center(
                                    child: Container(
                                      height: 330,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 18,
                                            bottom: 18,
                                            left: 8,
                                            right: 8),
                                        child: ClayContainer(
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width *
                                              0.80,
                                          emboss: true,
                                          spread: 2,
                                          color: const Color.fromRGBO(
                                              237, 237, 237, 1),
                                          depth: 20,
                                          curveType: CurveType.concave,
                                          customBorderRadius:
                                          const BorderRadius.only(
                                              topRight:
                                              Radius.elliptical(70, 70),
                                              bottomLeft:
                                              Radius.circular(10),
                                              topLeft: Radius.circular(10),
                                              bottomRight:
                                              Radius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Stack(children: <Widget>[
                                              Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      // height: 120,
                                                        child: Lottie.asset(
                                                          'assets/json/coaches_comment_gif.json',
                                                          // width: MediaQuery.of(context).size.width * 0.80,
                                                          height: 200,
                                                          fit: BoxFit.contain,
                                                        )),
                                                    const SizedBox(height: 20),
                                                    const Text(
                                                      "No Comment From Any Coach Yet",
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            205, 133, 133, 1),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                ] else ...[
                                  Container(
                                    height: 330,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    child: Swiper(
                                      autoplay: true,
                                      viewportFraction: 0.8,
                                      scale: 0.9,
                                      itemCount: coachesReviewsCommentNotifier
                                          .coachesReviewsCommentList.length,
                                      itemBuilder: (context, index) =>
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 18,
                                                bottom: 18,
                                            left: 8,
                                            right: 8),
                                        child: ClayContainer(
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width *
                                              0.90,
                                          emboss: true,
                                          spread: 2,
                                          color: const Color.fromRGBO(
                                              237, 237, 237, 1),
                                          depth: 20,
                                          curveType: CurveType.concave,
                                          customBorderRadius:
                                          const BorderRadius.only(
                                              topRight:
                                              Radius.elliptical(70, 70),
                                              bottomLeft:
                                              Radius.circular(10),
                                              topLeft: Radius.circular(10),
                                              bottomRight:
                                              Radius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                        Alignment.topLeft,
                                                        child: Container(
                                                          width: 100.0,
                                                          height: 100.0,
                                                          decoration:
                                                          BoxDecoration(
                                                            image: DecorationImage(
                                                                alignment:
                                                                const Alignment(
                                                                    0, -1),
                                                                image: CachedNetworkImageProvider(
                                                                    coachesReviewsCommentNotifier
                                                                        .coachesReviewsCommentList[
                                                                    index]
                                                                        .image!),
                                                                fit: BoxFit
                                                                    .cover),
                                                            shape:
                                                            BoxShape.circle,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 15,
                                                      ),
                                                      Text(
                                                        "Coach ${coachesReviewsCommentNotifier.coachesReviewsCommentList[index].name!.replaceAll(" ", "\n")}",
                                                        style: GoogleFonts
                                                            .kottaOne(
                                                          color: const Color
                                                              .fromRGBO(188,
                                                              105, 66, 1.0),
                                                          fontSize: 25,
                                                          // fontWeight: FontWeight.bold,
                                                          // height: 0.81
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      )
                                                    ],
                                                  ),
                                                  const Divider(
                                                    thickness: 2,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                          "Month Review  [${coachesReviewsCommentNotifier.coachesReviewsCommentList[index].date!}]",
                                                          style: GoogleFonts
                                                              .iceberg(
                                                            color: const Color
                                                                .fromRGBO(
                                                                65,
                                                                63,
                                                                63,
                                                                1.0),
                                                            fontSize: 15,
                                                          ),
                                                          textAlign:
                                                          TextAlign.start),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                          '"${coachesReviewsCommentNotifier
                                                              .coachesReviewsCommentList[index]
                                                              .comment!}"',
                                                          style: GoogleFonts
                                                              .iceberg(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  121,
                                                                  117,
                                                                  117,
                                                                  1.0),
                                                              fontSize: 13,
                                                              fontStyle:
                                                              FontStyle
                                                                  .italic),
                                                          textAlign:
                                                          TextAlign.justify)
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                          ),
                                      itemWidth:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .width *
                                          0.9,
                                      layout: SwiperLayout.DEFAULT,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                ],
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(left: 22),
                                    child: Listener(
                                      onPointerDown: (_) => setState(() {
                                        isTextPressed = true;
                                      }),
                                      onPointerUp: (_) => setState(() {
                                        isTextPressed = false;
                                      }),
                                      child: Text(
                                        "Founders' Monthly Comments",
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                140, 112, 84, 1.0),
                                            shadows: [
                                              for (double i = 1;
                                              i < (isTextPressed ? 1 : 2);
                                              i++)
                                                Shadow(
                                                  color: shadowColor,
                                                  blurRadius: 3 * i,
                                                ),
                                            ]),
                                      ),
                                    )),
                                if (foundersReviewsCommentNotifier
                                    .foundersReviewsCommentList.isEmpty) ...[
                                  Center(
                                    child: Container(
                                      height: 330,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 18,
                                            bottom: 18,
                                            left: 8,
                                            right: 8),
                                        child: ClayContainer(
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width *
                                              0.80,
                                          emboss: true,
                                          spread: 2,
                                          color: const Color.fromRGBO(
                                              237, 237, 237, 1),
                                          depth: 20,
                                          curveType: CurveType.concave,
                                          customBorderRadius:
                                          const BorderRadius.only(
                                              topRight:
                                              Radius.elliptical(70, 70),
                                              bottomLeft:
                                              Radius.circular(10),
                                              topLeft: Radius.circular(10),
                                              bottomRight:
                                              Radius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Stack(children: <Widget>[
                                              Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      // height: 120,
                                                        child: Lottie.asset(
                                                          'assets/json/founders_comment_gif.json',
                                                          // width: MediaQuery.of(context).size.width * 0.80,
                                                          height: 200,
                                                          fit: BoxFit.contain,
                                                        )),
                                                    const SizedBox(height: 20),
                                                    const Text(
                                                      "No Comment From Any CPFC Founder Yet",
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            205, 133, 133, 1),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                ] else ...[
                                  Container(
                                    height: 330,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    child: Swiper(
                                      autoplay: true,
                                      viewportFraction: 0.8,
                                      scale: 0.9,
                                      itemCount: foundersReviewsCommentNotifier
                                          .foundersReviewsCommentList.length,
                                      itemBuilder: (context, index) =>
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 18,
                                                bottom: 18,
                                            left: 8,
                                            right: 8),
                                        child: ClayContainer(
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width *
                                              0.90,
                                          emboss: true,
                                          spread: 2,
                                          color: const Color.fromRGBO(
                                              237, 237, 237, 1),
                                          depth: 20,
                                          curveType: CurveType.concave,
                                          customBorderRadius:
                                          const BorderRadius.only(
                                              topRight:
                                              Radius.elliptical(70, 70),
                                              bottomLeft:
                                              Radius.circular(10),
                                              topLeft: Radius.circular(10),
                                              bottomRight:
                                              Radius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                        Alignment.topLeft,
                                                        child: Container(
                                                          width: 100.0,
                                                          height: 100.0,
                                                          decoration:
                                                          BoxDecoration(
                                                            image: DecorationImage(
                                                                alignment:
                                                                const Alignment(
                                                                    0, -1),
                                                                image: CachedNetworkImageProvider(
                                                                    foundersReviewsCommentNotifier
                                                                        .foundersReviewsCommentList[
                                                                    index]
                                                                        .image!),
                                                                fit: BoxFit
                                                                    .cover),
                                                            shape:
                                                            BoxShape.circle,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 15,
                                                      ),
                                                      Text(
                                                        foundersReviewsCommentNotifier
                                                            .foundersReviewsCommentList[
                                                        index]
                                                            .name!
                                                            .replaceAll(
                                                            " ", "\n"),
                                                        style: GoogleFonts
                                                            .kottaOne(
                                                          color: const Color
                                                              .fromRGBO(188,
                                                              105, 66, 1.0),
                                                          fontSize: 25,
                                                          // fontWeight: FontWeight.bold,
                                                          // height: 0.81
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      )
                                                    ],
                                                  ),
                                                  const Divider(
                                                    thickness: 2,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                          "Month Review  [${foundersReviewsCommentNotifier.foundersReviewsCommentList[index].date!}]",
                                                          style: GoogleFonts
                                                              .iceberg(
                                                            color: const Color
                                                                .fromRGBO(
                                                                65,
                                                                63,
                                                                63,
                                                                1.0),
                                                            fontSize: 15,
                                                          ),
                                                          textAlign:
                                                          TextAlign.start),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                          '"${foundersReviewsCommentNotifier
                                                              .foundersReviewsCommentList[index]
                                                              .comment!}"',
                                                          style: GoogleFonts
                                                              .iceberg(
                                                              color: const Color
                                                                  .fromRGBO(
                                                                  121,
                                                                  117,
                                                                  117,
                                                                  1.0),
                                                              fontSize: 13,
                                                              fontStyle:
                                                              FontStyle
                                                                  .italic),
                                                          textAlign:
                                                          TextAlign.justify)
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                          ),
                                      itemWidth:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .width *
                                          0.9,
                                      layout: SwiperLayout.DEFAULT,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                ],
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 22, bottom: 22),
                                    child: Listener(
                                      onPointerDown: (_) => setState(() {
                                        isTextPressed = true;
                                      }),
                                      onPointerUp: (_) => setState(() {
                                        isTextPressed = false;
                                      }),
                                      child: Text(
                                        'Player Of The Month',
                                        style: TextStyle(
                                            color: const Color.fromRGBO(
                                                140, 112, 84, 1.0),
                                            shadows: [
                                              for (double i = 1;
                                              i < (isTextPressed ? 1 : 2);
                                              i++)
                                                Shadow(
                                                  color: shadowColor,
                                                  blurRadius: 3 * i,
                                                ),
                                            ]),
                                      ),
                                    )),
                                Center(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.90,
                                    height: 300,
                                    decoration: BoxDecoration(
                                        color: Colors.deepOrange[300],
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.deepOrange
                                                  .withAlpha(30),
                                              offset: const Offset(4.0, 2.0),
                                              blurRadius: 1.0,
                                              spreadRadius: 1.0),
                                          BoxShadow(
                                              color: Colors.deepOrange
                                                  .withAlpha(60),
                                              offset: const Offset(-2.0, -1.0),
                                              blurRadius: 1.0,
                                              spreadRadius: 1.0)
                                        ]),
                                    child: GestureDetector(
                                      child: Center(
                                        child: Listener(
                                          onPointerUp: (_) =>
                                              setState(() => isPressed = false),
                                          onPointerDown: (_) =>
                                              setState(() => isPressed = true),
                                          child: AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 200),
                                            width: 200,
                                            height: 120,
                                            decoration: BoxDecoration(
                                              color: Colors.deepOrange[300],
                                              borderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(15)),
                                              boxShadow: [
                                                BoxShadow(
                                                    color:
                                                    Colors.deepOrange[500]!,
                                                    offset: -distance,
                                                    blurRadius: blur,
                                                    spreadRadius: 1.0),
                                                BoxShadow(
                                                    color:
                                                    Colors.deepOrange[200]!,
                                                    offset: distance,
                                                    blurRadius: blur,
                                                    spreadRadius: 1.0),
                                              ],
                                            ),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'YAY!',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 60,
                                                    shadows: [
                                                      const Shadow(
                                                          offset: Offset(3, 3),
                                                          // color: Colors.black38,
                                                          color: Color.fromRGBO(
                                                              112, 32, 3, 0.38),
                                                          blurRadius: 10),
                                                      Shadow(
                                                          offset: const Offset(
                                                              -3, -3),
                                                          color: Colors
                                                              .deepOrange[300]!,
                                                          blurRadius: 10)
                                                    ],
                                                    color:
                                                    Colors.deepOrange[300]),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => Stack(
                                            children: [
                                              if (playerOfTheMonthStatsAndInfoNotifier
                                                  .playerOfTheMonthStatsAndInfoList
                                                  .isEmpty) ...[
                                                Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      Container(
                                                        // height: 120,
                                                          child: Lottie.asset(
                                                            'assets/json/potm_award.json',
                                                            // width: MediaQuery.of(context).size.width * 0.80,
                                                            height: 200,
                                                            fit: BoxFit.contain,
                                                          )),
                                                      const SizedBox(
                                                          height: 20),
                                                      const Text(
                                                        "No POTM Nominated Yet",
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              210,
                                                              201,
                                                              201,
                                                              1.0),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ] else ...[
                                                AlertDialog(
                                                  shape:
                                                  const RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            10.0)),
                                                  ),
                                                  contentPadding:
                                                  const EdgeInsets.all(10),
                                                  backgroundColor:
                                                  const Color.fromRGBO(
                                                      184, 106, 65, 1.0),
                                                  content: ConfettiWidget(
                                                    createParticlePath:
                                                    drawStar,
                                                    confettiController:
                                                    _controllerTopCenter,
                                                    blastDirection: -pi / 2,
                                                    maxBlastForce: 50,
                                                    // set a lower max blast force
                                                    minBlastForce: 20,
                                                    // set a lower min blast force
                                                    emissionFrequency: 0.35,
                                                    blastDirectionality:
                                                        BlastDirectionality
                                                            .explosive,
                                                    numberOfParticles: 50,
                                                    // a lot of particles at once
                                                    gravity: 1,
                                                    child: SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.6,
                                                      child: ListView.builder(
                                                        itemExtent:
                                                        MediaQuery
                                                            .of(
                                                            context)
                                                            .size
                                                            .height *
                                                            0.585,
                                                        shrinkWrap: true,
                                                        itemCount:
                                                        playerOfTheMonthStatsAndInfoNotifier
                                                            .playerOfTheMonthStatsAndInfoList
                                                            .length,
                                                        itemBuilder:
                                                            (context, index) =>
                                                            Stack(
                                                              alignment:
                                                              AlignmentDirectional
                                                                  .topStart,
                                                              // fit: StackFit.loose,
                                                              children: [
                                                                Align(
                                                                  alignment: Alignment
                                                                      .centerLeft,
                                                                  child: SizedBox(
                                                                    width: MediaQuery
                                                                        .of(
                                                                        context)
                                                                        .size
                                                                        .width *
                                                                        .43,
                                                                    height: MediaQuery
                                                                        .of(
                                                                        context)
                                                                        .size
                                                                        .height *
                                                                        2,
                                                                    child: Image(
                                                                      height: double
                                                                          .infinity,
                                                                      width: double
                                                                          .infinity,
                                                                      image:
                                                                      CachedNetworkImageProvider(
                                                                        playerOfTheMonthStatsAndInfoNotifier
                                                                            .playerOfTheMonthStatsAndInfoList[
                                                                        index]
                                                                            .image!,
                                                                        scale: 0.2,
                                                                      ),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      color: Colors
                                                                          .grey,
                                                                      colorBlendMode:
                                                                      BlendMode
                                                                          .softLight,
                                                                      alignment:
                                                                      const Alignment(
                                                                          0.4,
                                                                          -1),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment: Alignment
                                                                      .centerRight,
                                                                  child: SizedBox(
                                                                    // color: Colors.green,
                                                                    height: MediaQuery
                                                                        .of(
                                                                        context)
                                                                        .size
                                                                        .height,
                                                                    // height: 500,
                                                                    width: MediaQuery
                                                                        .of(
                                                                        context)
                                                                        .size
                                                                        .width,
                                                                    child:
                                                                    Image.asset(
                                                                      "assets/images/back_field.png",
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                  Alignment
                                                                      .topRight,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            right:
                                                                            40),
                                                                        child: Image
                                                                            .asset(
                                                                          "assets/images/MVP_Blooded_3.png",
                                                                          width: MediaQuery
                                                                              .of(
                                                                              context)
                                                                              .size
                                                                              .width *
                                                                              0.35,
                                                                        ),
                                                                      ),

                                                                      if (playerOfTheMonthStatsAndInfoNotifier
                                                                          .playerOfTheMonthStatsAndInfoList[
                                                                      index]
                                                                          .playerPosition
                                                                          .toString()
                                                                          .toLowerCase() ==
                                                                          'gk') ...[
                                                                        Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding:
                                                                              const EdgeInsets
                                                                                  .only(
                                                                                  right: 10),
                                                                              child:
                                                                              SizedBox(
                                                                                width:
                                                                                MediaQuery
                                                                                    .of(
                                                                                    context)
                                                                                    .size
                                                                                    .width *
                                                                                    0.35,
                                                                                child:
                                                                                Text(
                                                                                  playerOfTheMonthStatsAndInfoNotifier
                                                                                      .playerOfTheMonthStatsAndInfoList[index]
                                                                                      .playerName!
                                                                                      .replaceAll(
                                                                                      " ",
                                                                                      "\n"),
                                                                                  style: GoogleFonts
                                                                                      .rubikMicrobe(
                                                                                      color: const Color
                                                                                          .fromRGBO(
                                                                                          184,
                                                                                          106,
                                                                                          65,
                                                                                          1.0),
                                                                                      fontSize: 30,
                                                                                      fontWeight: FontWeight
                                                                                          .bold,
                                                                                      height: 0.81),
                                                                                  overflow: TextOverflow
                                                                                      .ellipsis,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(
                                                                                height:
                                                                                40),
                                                                            Column(
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets
                                                                                      .only(
                                                                                      right: 10),
                                                                                  child: SizedBox(
                                                                                    width: MediaQuery
                                                                                        .of(
                                                                                        context)
                                                                                        .size
                                                                                        .width *
                                                                                        0.35,
                                                                                    child: Text(
                                                                                      playerOfTheMonthStatsAndInfoNotifier
                                                                                          .playerOfTheMonthStatsAndInfoList[index]
                                                                                          .goalsConcededGkDef
                                                                                          .toString(),
                                                                                      style: GoogleFonts
                                                                                          .rubikMicrobe(
                                                                                          color: const Color
                                                                                              .fromRGBO(
                                                                                              184,
                                                                                              106,
                                                                                              65,
                                                                                              1.0),
                                                                                          fontSize: 30,
                                                                                          fontWeight: FontWeight
                                                                                              .bold,
                                                                                          fontStyle: FontStyle
                                                                                              .italic),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets
                                                                                      .only(
                                                                                      right: 10),
                                                                                  child: SizedBox(
                                                                                    width: MediaQuery
                                                                                        .of(
                                                                                        context)
                                                                                        .size
                                                                                        .width *
                                                                                        0.35,
                                                                                    child: Text(
                                                                                      'Goals Conceded',
                                                                                      style: GoogleFonts
                                                                                          .arimo(
                                                                                        color: Colors
                                                                                            .white70,
                                                                                        fontSize: 14,
                                                                                        fontWeight: FontWeight
                                                                                            .w200,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(
                                                                                    height: 15),
                                                                              ],
                                                                            ),
                                                                            Column(
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets
                                                                                      .only(
                                                                                      right: 10),
                                                                                  child: SizedBox(
                                                                                    width: MediaQuery
                                                                                        .of(
                                                                                        context)
                                                                                        .size
                                                                                        .width *
                                                                                        0.35,
                                                                                    child: Text(
                                                                                      playerOfTheMonthStatsAndInfoNotifier
                                                                                          .playerOfTheMonthStatsAndInfoList[index]
                                                                                          .cleanSheetGk
                                                                                          .toString(),
                                                                                      style: GoogleFonts
                                                                                          .rubikMicrobe(
                                                                                          color: const Color
                                                                                              .fromRGBO(
                                                                                              184,
                                                                                              106,
                                                                                              65,
                                                                                              1.0),
                                                                                          fontSize: 30,
                                                                                          fontWeight: FontWeight
                                                                                              .bold,
                                                                                          fontStyle: FontStyle
                                                                                              .italic),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets
                                                                                      .only(
                                                                                      right: 10),
                                                                                  child: SizedBox(
                                                                                    width: MediaQuery
                                                                                        .of(
                                                                                        context)
                                                                                        .size
                                                                                        .width *
                                                                                        0.35,
                                                                                    child: Text(
                                                                                      'Clean Sheets',
                                                                                      style: GoogleFonts
                                                                                          .arimo(
                                                                                        color: Colors
                                                                                            .white70,
                                                                                        fontSize: 14,
                                                                                        fontWeight: FontWeight
                                                                                            .w200,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(
                                                                                    height: 15),
                                                                              ],
                                                                            ),
                                                                            Column(
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets
                                                                                      .only(
                                                                                      right: 10),
                                                                                  child: SizedBox(
                                                                                    width: MediaQuery
                                                                                        .of(
                                                                                        context)
                                                                                        .size
                                                                                        .width *
                                                                                        0.35,
                                                                                    child: Text(
                                                                                      playerOfTheMonthStatsAndInfoNotifier
                                                                                          .playerOfTheMonthStatsAndInfoList[index]
                                                                                          .matchesPlayed
                                                                                          .toString(),
                                                                                      style: GoogleFonts
                                                                                          .rubikMicrobe(
                                                                                          color: const Color
                                                                                              .fromRGBO(
                                                                                              184,
                                                                                              106,
                                                                                              65,
                                                                                              1.0),
                                                                                          fontSize: 30,
                                                                                          fontWeight: FontWeight
                                                                                              .bold,
                                                                                          fontStyle: FontStyle
                                                                                              .italic),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets
                                                                                      .only(
                                                                                      right: 10),
                                                                                  child: SizedBox(
                                                                                    width: MediaQuery
                                                                                        .of(
                                                                                        context)
                                                                                        .size
                                                                                        .width *
                                                                                        0.35,
                                                                                    child: Text(
                                                                                      'Matches Played',
                                                                                      style: GoogleFonts
                                                                                          .arimo(
                                                                                        color: Colors
                                                                                            .white70,
                                                                                        fontSize: 14,
                                                                                        fontWeight: FontWeight
                                                                                            .w200,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(
                                                                                    height: 80),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ] else
                                                                        if (playerOfTheMonthStatsAndInfoNotifier
                                                                            .playerOfTheMonthStatsAndInfoList[index]
                                                                            .playerPosition
                                                                            .toString()
                                                                            .toLowerCase() ==
                                                                            'cb' ||
                                                                            playerOfTheMonthStatsAndInfoNotifier
                                                                                .playerOfTheMonthStatsAndInfoList[
                                                                            index]
                                                                                .playerPosition
                                                                                .toString()
                                                                                .toLowerCase() ==
                                                                                'lb' ||
                                                                            playerOfTheMonthStatsAndInfoNotifier
                                                                                .playerOfTheMonthStatsAndInfoList[index]
                                                                                .playerPosition
                                                                                .toString()
                                                                                .toLowerCase() ==
                                                                                'rb') ...[
                                                                          Column(
                                                                            children: [
                                                                              Padding(
                                                                                padding:
                                                                                const EdgeInsets
                                                                                    .only(
                                                                                    right: 10),
                                                                                child:
                                                                                SizedBox(
                                                                                  width:
                                                                                  MediaQuery
                                                                                      .of(
                                                                                      context)
                                                                                      .size
                                                                                      .width *
                                                                                      0.35,
                                                                                  child:
                                                                                  Text(
                                                                                    playerOfTheMonthStatsAndInfoNotifier
                                                                                        .playerOfTheMonthStatsAndInfoList[index]
                                                                                        .playerName!
                                                                                        .replaceAll(
                                                                                        " ",
                                                                                        "\n"),
                                                                                    style: GoogleFonts
                                                                                        .rubikMicrobe(
                                                                                        color: const Color
                                                                                            .fromRGBO(
                                                                                            184,
                                                                                            106,
                                                                                            65,
                                                                                            1.0),
                                                                                        fontSize: 25,
                                                                                        fontWeight: FontWeight
                                                                                            .bold,
                                                                                        height: 0.81),
                                                                                    overflow: TextOverflow
                                                                                        .ellipsis,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              const SizedBox(
                                                                                  height:
                                                                                  40),
                                                                              Column(
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsets
                                                                                        .only(
                                                                                        right: 10),
                                                                                    child: SizedBox(
                                                                                      width: MediaQuery
                                                                                          .of(
                                                                                          context)
                                                                                          .size
                                                                                          .width *
                                                                                          0.35,
                                                                                      child: Text(
                                                                                        playerOfTheMonthStatsAndInfoNotifier
                                                                                            .playerOfTheMonthStatsAndInfoList[index]
                                                                                            .playerPosition
                                                                                            .toString()
                                                                                            .toUpperCase(),
                                                                                        style: GoogleFonts
                                                                                            .rubikMicrobe(
                                                                                            color: const Color
                                                                                                .fromRGBO(
                                                                                                184,
                                                                                                106,
                                                                                                65,
                                                                                                1.0),
                                                                                            fontSize: 30,
                                                                                            fontWeight: FontWeight
                                                                                                .bold,
                                                                                            fontStyle: FontStyle
                                                                                                .italic),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsets
                                                                                        .only(
                                                                                        right: 10),
                                                                                    child: SizedBox(
                                                                                      width: MediaQuery
                                                                                          .of(
                                                                                          context)
                                                                                          .size
                                                                                          .width *
                                                                                          0.35,
                                                                                      child: Text(
                                                                                        'Player Position',
                                                                                        style: GoogleFonts
                                                                                            .arimo(
                                                                                          color: Colors
                                                                                              .white70,
                                                                                          fontSize: 14,
                                                                                          fontWeight: FontWeight
                                                                                              .w200,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                      height: 15),
                                                                                ],
                                                                              ),
                                                                              Column(
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsets
                                                                                        .only(
                                                                                        right: 10),
                                                                                    child: SizedBox(
                                                                                      width: MediaQuery
                                                                                          .of(
                                                                                          context)
                                                                                          .size
                                                                                          .width *
                                                                                          0.35,
                                                                                      child: Text(
                                                                                        playerOfTheMonthStatsAndInfoNotifier
                                                                                            .playerOfTheMonthStatsAndInfoList[index]
                                                                                            .goalsConcededGkDef
                                                                                            .toString(),
                                                                                        style: GoogleFonts
                                                                                            .rubikMicrobe(
                                                                                            color: const Color
                                                                                                .fromRGBO(
                                                                                                184,
                                                                                                106,
                                                                                                65,
                                                                                                1.0),
                                                                                            fontSize: 30,
                                                                                            fontWeight: FontWeight
                                                                                                .bold,
                                                                                            fontStyle: FontStyle
                                                                                                .italic),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsets
                                                                                        .only(
                                                                                        right: 10),
                                                                                    child: SizedBox(
                                                                                      width: MediaQuery
                                                                                          .of(
                                                                                          context)
                                                                                          .size
                                                                                          .width *
                                                                                          0.35,
                                                                                      child: Text(
                                                                                        'Goals Conceded',
                                                                                        style: GoogleFonts
                                                                                            .arimo(
                                                                                          color: Colors
                                                                                              .white70,
                                                                                          fontSize: 14,
                                                                                          fontWeight: FontWeight
                                                                                              .w200,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                      height: 15),
                                                                                ],
                                                                              ),
                                                                              Column(
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsets
                                                                                        .only(
                                                                                        right: 10),
                                                                                    child: SizedBox(
                                                                                      width: MediaQuery
                                                                                          .of(
                                                                                          context)
                                                                                          .size
                                                                                          .width *
                                                                                          0.35,
                                                                                      child: Text(
                                                                                        playerOfTheMonthStatsAndInfoNotifier
                                                                                            .playerOfTheMonthStatsAndInfoList[index]
                                                                                            .matchesPlayed
                                                                                            .toString(),
                                                                                        style: GoogleFonts
                                                                                            .rubikMicrobe(
                                                                                            color: const Color
                                                                                                .fromRGBO(
                                                                                                184,
                                                                                                106,
                                                                                                65,
                                                                                                1.0),
                                                                                            fontSize: 30,
                                                                                            fontWeight: FontWeight
                                                                                                .bold,
                                                                                            fontStyle: FontStyle
                                                                                                .italic),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsets
                                                                                        .only(
                                                                                        right: 10),
                                                                                    child: SizedBox(
                                                                                      width: MediaQuery
                                                                                          .of(
                                                                                          context)
                                                                                          .size
                                                                                          .width *
                                                                                          0.35,
                                                                                      child: Text(
                                                                                        'Matches Played',
                                                                                        style: GoogleFonts
                                                                                            .arimo(
                                                                                          color: Colors
                                                                                              .white70,
                                                                                          fontSize: 14,
                                                                                          fontWeight: FontWeight
                                                                                              .w200,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(
                                                                                      height: 80),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ] else
                                                                          ...[
                                                                            Column(
                                                                              children: [
                                                                                Padding(
                                                                                  padding:
                                                                                  const EdgeInsets
                                                                                      .only(
                                                                                      right: 10),
                                                                                  child:
                                                                                  SizedBox(
                                                                                    width:
                                                                                    MediaQuery
                                                                                        .of(
                                                                                        context)
                                                                                        .size
                                                                                        .width *
                                                                                        0.35,
                                                                                    child:
                                                                                    Text(
                                                                                      playerOfTheMonthStatsAndInfoNotifier
                                                                                          .playerOfTheMonthStatsAndInfoList[index]
                                                                                          .playerName!
                                                                                          .replaceAll(
                                                                                          " ",
                                                                                          "\n"),
                                                                                      style: GoogleFonts
                                                                                          .rubikMicrobe(
                                                                                          color: const Color
                                                                                              .fromRGBO(
                                                                                              184,
                                                                                              106,
                                                                                              65,
                                                                                              1.0),
                                                                                          fontSize: 25,
                                                                                          fontWeight: FontWeight
                                                                                              .bold,
                                                                                          height: 0.81),
                                                                                      overflow: TextOverflow
                                                                                          .ellipsis,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                const SizedBox(
                                                                                    height:
                                                                                    40),
                                                                                Column(
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: const EdgeInsets
                                                                                          .only(
                                                                                          right: 10),
                                                                                      child: SizedBox(
                                                                                        width: MediaQuery
                                                                                            .of(
                                                                                            context)
                                                                                            .size
                                                                                            .width *
                                                                                            0.35,
                                                                                        child: Text(
                                                                                          playerOfTheMonthStatsAndInfoNotifier
                                                                                              .playerOfTheMonthStatsAndInfoList[index]
                                                                                              .goalsScored
                                                                                              .toString(),
                                                                                          style: GoogleFonts
                                                                                              .rubikMicrobe(
                                                                                              color: const Color
                                                                                                  .fromRGBO(
                                                                                                  184,
                                                                                                  106,
                                                                                                  65,
                                                                                                  1.0),
                                                                                              fontSize: 30,
                                                                                              fontWeight: FontWeight
                                                                                                  .bold,
                                                                                              fontStyle: FontStyle
                                                                                                  .italic),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: const EdgeInsets
                                                                                          .only(
                                                                                          right: 10),
                                                                                      child: SizedBox(
                                                                                        width: MediaQuery
                                                                                            .of(
                                                                                            context)
                                                                                            .size
                                                                                            .width *
                                                                                            0.35,
                                                                                        child: Text(
                                                                                          'Goals Scored',
                                                                                          style: GoogleFonts
                                                                                              .arimo(
                                                                                            color: Colors
                                                                                                .white70,
                                                                                            fontSize: 14,
                                                                                            fontWeight: FontWeight
                                                                                                .w200,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    const SizedBox(
                                                                                        height: 15),
                                                                                  ],
                                                                                ),
                                                                                Column(
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: const EdgeInsets
                                                                                          .only(
                                                                                          right: 10),
                                                                                      child: SizedBox(
                                                                                        width: MediaQuery
                                                                                            .of(
                                                                                            context)
                                                                                            .size
                                                                                            .width *
                                                                                            0.35,
                                                                                        child: Text(
                                                                                          playerOfTheMonthStatsAndInfoNotifier
                                                                                              .playerOfTheMonthStatsAndInfoList[index]
                                                                                              .assists
                                                                                              .toString(),
                                                                                          style: GoogleFonts
                                                                                              .rubikMicrobe(
                                                                                              color: const Color
                                                                                                  .fromRGBO(
                                                                                                  184,
                                                                                                  106,
                                                                                                  65,
                                                                                                  1.0),
                                                                                              fontSize: 30,
                                                                                              fontWeight: FontWeight
                                                                                                  .bold,
                                                                                              fontStyle: FontStyle
                                                                                                  .italic),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: const EdgeInsets
                                                                                          .only(
                                                                                          right: 10),
                                                                                      child: SizedBox(
                                                                                        width: MediaQuery
                                                                                            .of(
                                                                                            context)
                                                                                            .size
                                                                                            .width *
                                                                                            0.35,
                                                                                        child: Text(
                                                                                          'Assists Provided',
                                                                                          style: GoogleFonts
                                                                                              .arimo(
                                                                                            color: Colors
                                                                                                .white70,
                                                                                            fontSize: 14,
                                                                                            fontWeight: FontWeight
                                                                                                .w200,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    const SizedBox(
                                                                                        height: 15),
                                                                                  ],
                                                                                ),
                                                                                Column(
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: const EdgeInsets
                                                                                          .only(
                                                                                          right: 10),
                                                                                      child: SizedBox(
                                                                                        width: MediaQuery
                                                                                            .of(
                                                                                            context)
                                                                                            .size
                                                                                            .width *
                                                                                            0.35,
                                                                                        child: Text(
                                                                                          playerOfTheMonthStatsAndInfoNotifier
                                                                                              .playerOfTheMonthStatsAndInfoList[index]
                                                                                              .matchesPlayed
                                                                                              .toString(),
                                                                                          style: GoogleFonts
                                                                                              .rubikMicrobe(
                                                                                              color: const Color
                                                                                                  .fromRGBO(
                                                                                                  184,
                                                                                                  106,
                                                                                                  65,
                                                                                                  1.0),
                                                                                              fontSize: 30,
                                                                                              fontWeight: FontWeight
                                                                                                  .bold,
                                                                                              fontStyle: FontStyle
                                                                                                  .italic),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: const EdgeInsets
                                                                                          .only(
                                                                                          right: 10),
                                                                                      child: SizedBox(
                                                                                        width: MediaQuery
                                                                                            .of(
                                                                                            context)
                                                                                            .size
                                                                                            .width *
                                                                                            0.35,
                                                                                        child: Text(
                                                                                          'Matches Played',
                                                                                          style: GoogleFonts
                                                                                              .arimo(
                                                                                            color: Colors
                                                                                                .white70,
                                                                                            fontSize: 14,
                                                                                            fontWeight: FontWeight
                                                                                                .w200,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    const SizedBox(
                                                                                        height: 80),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],

                                                                      // Column(
                                                                      //   children: [
                                                                      //     Padding(
                                                                      //       padding: const EdgeInsets.only(right: 10),
                                                                      //       child: Container(
                                                                      //         width: MediaQuery.of(context).size.width * 0.35,
                                                                      //         child: Text(
                                                                      //           playerOfTheMonthStatsAndInfoNotifier.playerOfTheMonthStatsAndInfoList[index].playerName!.replaceAll(" ", "\n"),
                                                                      //           style: GoogleFonts.rubikMicrobe(
                                                                      //               color: Color.fromRGBO(184, 106, 65, 1.0),
                                                                      //               fontSize: 30,
                                                                      //             fontWeight: FontWeight.bold,
                                                                      //             height: 0.81
                                                                      //           ),
                                                                      //           overflow: TextOverflow.ellipsis,
                                                                      //         ),
                                                                      //       ),
                                                                      //     ),
                                                                      //     const SizedBox(height: 40),
                                                                      //     Column(
                                                                      //       children: [
                                                                      //         Padding(
                                                                      //           padding: const EdgeInsets.only(right: 10),
                                                                      //           child: Container(
                                                                      //             width: MediaQuery.of(context).size.width * 0.35,
                                                                      //             child: Text(
                                                                      //               playerOfTheMonthStatsAndInfoNotifier.playerOfTheMonthStatsAndInfoList[index].goalsScored.toString(),
                                                                      //               style: GoogleFonts.rubikMicrobe(
                                                                      //                   color: Color.fromRGBO(184, 106, 65, 1.0),
                                                                      //                   fontSize: 30,
                                                                      //                   fontWeight: FontWeight.bold,
                                                                      //                   fontStyle: FontStyle.italic
                                                                      //               ),
                                                                      //             ),
                                                                      //           ),
                                                                      //         ),
                                                                      //         Padding(
                                                                      //           padding: const EdgeInsets.only(right: 10),
                                                                      //           child: Container(
                                                                      //             width: MediaQuery.of(context).size.width * 0.35,
                                                                      //             child: Text(
                                                                      //               'Goals Scored',
                                                                      //               style: GoogleFonts.arimo(
                                                                      //                 color: Colors.white70,
                                                                      //                 fontSize: 14,
                                                                      //                 fontWeight: FontWeight.w200,
                                                                      //
                                                                      //               ),
                                                                      //             ),
                                                                      //           ),
                                                                      //         ),
                                                                      //         const SizedBox(height: 15),
                                                                      //       ],
                                                                      //     ),
                                                                      //     Column(
                                                                      //       children: [
                                                                      //         Padding(
                                                                      //           padding: const EdgeInsets.only(right: 10),
                                                                      //           child: Container(
                                                                      //             width: MediaQuery.of(context).size.width * 0.35,
                                                                      //             child: Text(
                                                                      //               playerOfTheMonthStatsAndInfoNotifier.playerOfTheMonthStatsAndInfoList[index].assists.toString(),
                                                                      //               style: GoogleFonts.rubikMicrobe(
                                                                      //                   color: Color.fromRGBO(184, 106, 65, 1.0),
                                                                      //                   fontSize: 30,
                                                                      //                   fontWeight: FontWeight.bold,
                                                                      //                   fontStyle: FontStyle.italic
                                                                      //               ),
                                                                      //             ),
                                                                      //           ),
                                                                      //         ),
                                                                      //         Padding(
                                                                      //           padding: const EdgeInsets.only(right: 10),
                                                                      //           child: Container(
                                                                      //             width: MediaQuery.of(context).size.width * 0.35,
                                                                      //             child: Text(
                                                                      //               'Assists Provided',
                                                                      //               style: GoogleFonts.arimo(
                                                                      //                 color: Colors.white70,
                                                                      //                 fontSize: 14,
                                                                      //                 fontWeight: FontWeight.w200,
                                                                      //
                                                                      //               ),
                                                                      //             ),
                                                                      //           ),
                                                                      //         ),
                                                                      //         const SizedBox(height: 15),
                                                                      //       ],
                                                                      //     ),
                                                                      //     Column(
                                                                      //       children: [
                                                                      //         Padding(
                                                                      //           padding: const EdgeInsets.only(right: 10),
                                                                      //           child: Container(
                                                                      //             width: MediaQuery.of(context).size.width * 0.35,
                                                                      //             child: Text(
                                                                      //               playerOfTheMonthStatsAndInfoNotifier.playerOfTheMonthStatsAndInfoList[index].matchesPlayed.toString(),
                                                                      //               style: GoogleFonts.rubikMicrobe(
                                                                      //                   color: Color.fromRGBO(184, 106, 65, 1.0),
                                                                      //                   fontSize: 30,
                                                                      //                   fontWeight: FontWeight.bold,
                                                                      //                   fontStyle: FontStyle.italic
                                                                      //               ),
                                                                      //             ),
                                                                      //           ),
                                                                      //         ),
                                                                      //         Padding(
                                                                      //           padding: const EdgeInsets.only(right: 10),
                                                                      //           child: Container(
                                                                      //             width: MediaQuery.of(context).size.width * 0.35,
                                                                      //             child: Text(
                                                                      //               'Matches Played',
                                                                      //               style: GoogleFonts.arimo(
                                                                      //                 color: Colors.white70,
                                                                      //                 fontSize: 14,
                                                                      //                 fontWeight: FontWeight.w200,
                                                                      //
                                                                      //               ),
                                                                      //             ),
                                                                      //           ),
                                                                      //         ),
                                                                      //         const SizedBox(height: 80),
                                                                      //       ],
                                                                      //     ),
                                                                      //   ],
                                                                      // ),

                                                                      Column(
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                            const EdgeInsets
                                                                                .only(
                                                                                right: 10),
                                                                            child:
                                                                            SizedBox(
                                                                              width:
                                                                              MediaQuery
                                                                                  .of(
                                                                                  context)
                                                                                  .size
                                                                                  .width *
                                                                                  0.65,
                                                                              child:
                                                                              Text(
                                                                                "PLAYER OF THE MONTH",
                                                                                style:
                                                                                GoogleFonts
                                                                                    .orbitron(
                                                                                  color: const Color
                                                                                      .fromRGBO(
                                                                                      184,
                                                                                      106,
                                                                                      65,
                                                                                      1.0),
                                                                                  fontSize: 18,
                                                                                  fontWeight: FontWeight
                                                                                      .bold,
                                                                                ),
                                                                                textAlign:
                                                                                TextAlign
                                                                                    .center,
                                                                                overflow:
                                                                                TextOverflow
                                                                                    .ellipsis,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                            const EdgeInsets
                                                                                .only(
                                                                                top: 4),
                                                                            child:
                                                                            SizedBox(
                                                                              width:
                                                                              MediaQuery
                                                                                  .of(
                                                                                  context)
                                                                                  .size
                                                                                  .width *
                                                                                  0.65,
                                                                              child:
                                                                              Text(
                                                                                'Presented By',
                                                                                style:
                                                                                GoogleFonts
                                                                                    .arimo(
                                                                                  color: Colors
                                                                                      .white70,
                                                                                  fontSize: 14,
                                                                                  fontWeight: FontWeight
                                                                                      .w200,
                                                                                ),
                                                                                textAlign:
                                                                                TextAlign
                                                                                    .center,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                            const EdgeInsets
                                                                                .only(
                                                                                top: 5),
                                                                            child:
                                                                            SizedBox(
                                                                              width:
                                                                              MediaQuery
                                                                                  .of(
                                                                                  context)
                                                                                  .size
                                                                                  .width *
                                                                                  0.65,
                                                                              child:
                                                                              Text(
                                                                                'Nouvellesoft.io Inc.',
                                                                                style:
                                                                                GoogleFonts
                                                                                    .gloriaHallelujah(
                                                                                  color: Colors
                                                                                      .white70,
                                                                                  fontSize: 15,
                                                                                  fontWeight: FontWeight
                                                                                      .bold,
                                                                                ),
                                                                                textAlign:
                                                                                TextAlign
                                                                                    .center,
                                                                                overflow:
                                                                                TextOverflow
                                                                                    .ellipsis,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                if (Platform.isAndroid) ...[
                                                  Positioned(
                                                    top: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .height *
                                                        0.19,
                                                    right:
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width *
                                                        0.14,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        width: 30,
                                                        height: 30,
                                                        decoration:
                                                        BoxDecoration(
                                                          color:
                                                          Colors.grey[200],
                                                          shape: BoxShape
                                                              .rectangle,
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              6.0),
                                                        ),
                                                        child: const Align(
                                                          alignment:
                                                          Alignment.center,
                                                          child: Icon(
                                                            Icons.close,
                                                            color: Colors
                                                                .deepOrangeAccent,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ] else if (Platform.isIOS) ...[
                                                  Positioned(
                                                    top: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .height *
                                                        0.165,
                                                    right:
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width *
                                                        0.13,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        width: 30,
                                                        height: 30,
                                                        decoration:
                                                        BoxDecoration(
                                                          color:
                                                          Colors.grey[200],
                                                          shape: BoxShape
                                                              .rectangle,
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              6.0),
                                                        ),
                                                        child: const Align(
                                                          alignment:
                                                          Alignment.center,
                                                          child: Icon(
                                                            Icons.close,
                                                            color: Colors
                                                                .deepOrangeAccent,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ],
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future navigateMyApp(context) async {
    // Navigator.push(context, MaterialPageRoute(builder: (context) => const MyApp()));
    Navigator.of(context).pop(false);
  }

  @override
  initState() {
    TopGoalsPlayersStatsAndInfoNotifier topGoalsPlayersStatsAndInfoNotifier =
    Provider.of<TopGoalsPlayersStatsAndInfoNotifier>(context,
        listen: false);

    MostAssistsPlayersStatsAndInfoNotifier
    mostAssistsPlayersStatsAndInfoNotifier =
    Provider.of<MostAssistsPlayersStatsAndInfoNotifier>(context,
        listen: false);

    MostFouledYCPlayersStatsAndInfoNotifier
    mostFouledYCPlayersStatsAndInfoNotifier =
    Provider.of<MostFouledYCPlayersStatsAndInfoNotifier>(context,
        listen: false);

    MostFouledRCPlayersStatsAndInfoNotifier
    mostFouledRCPlayersStatsAndInfoNotifier =
    Provider.of<MostFouledRCPlayersStatsAndInfoNotifier>(context,
        listen: false);

    PlayerOfTheMonthStatsAndInfoNotifier playerOfTheMonthStatsAndInfoNotifier =
    Provider.of<PlayerOfTheMonthStatsAndInfoNotifier>(context,
        listen: false);

    TopGKPlayersStatsAndInfoNotifier topGKPlayersStatsAndInfoNotifier =
    Provider.of<TopGKPlayersStatsAndInfoNotifier>(context, listen: false);

    TopDefensivePlayersStatsAndInfoNotifier
    topDefensivePlayersStatsAndInfoNotifier =
    Provider.of<TopDefensivePlayersStatsAndInfoNotifier>(context,
        listen: false);

    MOTMPlayersStatsAndInfoNotifier motmPlayersStatsAndInfoNotifier =
    Provider.of<MOTMPlayersStatsAndInfoNotifier>(context, listen: false);

    CumMOTMPlayersStatsAndInfoNotifier cumMOTMPlayersStatsAndInfoNotifier =
    Provider.of<CumMOTMPlayersStatsAndInfoNotifier>(context, listen: false);

    CoachesReviewsCommentNotifier coachesReviewsCommentNotifier =
    Provider.of<CoachesReviewsCommentNotifier>(context, listen: false);

    FoundersReviewsCommentNotifier foundersReviewsCommentNotifier =
    Provider.of<FoundersReviewsCommentNotifier>(context, listen: false);

    getTopGoalsPlayersStatsAndInfo(topGoalsPlayersStatsAndInfoNotifier);
    getMostAssistsPlayersStatsAndInfo(mostAssistsPlayersStatsAndInfoNotifier);
    getMostFouledYCPlayersStatsAndInfo(mostFouledYCPlayersStatsAndInfoNotifier);
    getMostFouledRCPlayersStatsAndInfo(mostFouledRCPlayersStatsAndInfoNotifier);
    getPlayerOfTheMonthStatsAndInfo(playerOfTheMonthStatsAndInfoNotifier);
    getTopGKPlayersStatsAndInfo(topGKPlayersStatsAndInfoNotifier);
    getTopDefensivePlayersStatsAndInfo(topDefensivePlayersStatsAndInfoNotifier);
    getMOTMPlayersStatsAndInfo(motmPlayersStatsAndInfoNotifier);
    getCumMOTMPlayersStatsAndInfo(cumMOTMPlayersStatsAndInfoNotifier);
    getCoachesReviewsComment(coachesReviewsCommentNotifier);
    getFoundersReviewsComment(foundersReviewsCommentNotifier);

    _controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 3));

    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    _controllerTopCenter.dispose();
    super.dispose();
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }
}
