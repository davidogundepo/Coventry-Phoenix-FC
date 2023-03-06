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

Color? backgroundColor = const Color.fromRGBO(247, 246, 242, 1);
Color parallaxRainColor = const Color.fromRGBO(221, 212, 212, 1.0);
Color? iconColor = const Color.fromRGBO(196, 174, 137, 1.0);
Color? clubNameColor = const Color.fromRGBO(205, 133, 133, 1);
Color? playerNameColor = const Color.fromRGBO(150, 129, 129, 1.0);
Color? topPlayersColor = const Color.fromRGBO(140, 112, 84, 1.0);
Color? topPlayersEmptyColor = const Color.fromRGBO(205, 133, 133, 1);
Color? keyTextColor = const Color.fromRGBO(188, 105, 66, 1.0);
Color? keyTextTwoColor = const Color.fromRGBO(217, 176, 95, 1.0);
Color? keyTextThreeColor = const Color.fromRGBO(212, 45, 45, 1.0);
Color? clayContainerColor = const Color.fromRGBO(237, 237, 237, 1);
Color? verticalDividerOneColor = const Color.fromRGBO(205, 133, 133, 1);
Color? verticalDividerTwoColor = const Color.fromRGBO(97, 143, 223, 1.0);
Color? verticalDividerThreeColor = const Color.fromRGBO(130, 185, 208, 1.0);
Color? verticalDividerFourColor = const Color.fromRGBO(191, 146, 69, 0.3);
Color? verticalDividerFiveColor = const Color.fromRGBO(125, 179, 140, 1.0);
Color? textColorOne = const Color.fromRGBO(205, 133, 133, 1);
Color? textColorTwo = Colors.black54;
Color? textColorThree = const Color.fromRGBO(65, 63, 63, 1.0);
Color? textColorFour = const Color.fromRGBO(121, 117, 117, 1.0);
Color? containerColor = Colors.white70;
Color shadowColor = const Color.fromRGBO(109, 101, 72, 1.0);
Color? swiperColor = const Color.fromRGBO(109, 101, 72, 1.0);
Color? potmColorOne = Colors.deepOrange[300];
Color potmColorTwo = Colors.deepOrange;
Color? potmColorThree = Colors.deepOrange[500];
Color? potmColorFour = Colors.deepOrange[200];
Color potmColorFive = const Color.fromRGBO(112, 32, 3, 0.38);
Color potmColorSix = const Color.fromRGBO(112, 32, 3, 0.38);
Color? potmColorSeven = Colors.grey[200];
Color? potmColorEight = Colors.deepOrangeAccent;
Color? dialogColor = const Color.fromRGBO(184, 106, 65, 1.0);

String clubName = "Coventry Phoenix FC";
String topGoalScorersTitle = "Top 10 Goal Scorers";
String topGoalScorersEmptyTitle = "No Goals Scored Yet";
String topAssistsPlayersTitle = "Top 10 Most Assists Players";
String topAssistsPlayersEmptyTitle = "No Assists Provided Yet";
String topYellowCardedPlayersTitle = "8 Most Yellow Carded Players";
String topYellowCardedPlayersEmptyTitle = "No Yellow Card Given Yet";
String topRedCardedPlayersTitle = "8 Most Red Carded Players";
String topRedCardedPlayersEmptyTitle = "No Bad Boy or Coach 👀\n Booked Yet";
String topGoalkeepersTitle = "Top Goal Keepers";
String topGoalkeepersEmptyTitle = "No GoalKeepers' Clean Sheet Yet";
String topDefensivePlayersTitle = "Top 10 Defensive Players";
// String topDefensivePlayersEmptyTitle = "No Bad Boy or Coach 👀\n Booked Yet";
String weeklyMOTMPlayersTitle = "Weekly MOTM Players";
String weeklyMOTMPlayersEmptyTitle = "No MOTM Players Yet";
String cumAwardMOTMPlayersTitle = "Most Awarded MOTM Players";
String cumAwardMOTMPlayersEmptyTitle = "No Most Awarded MOTM Players Yet";
String cumMOTMCountPlayersTitle = "MOTM Count";
String cumMOTMCountPlayersEmptyTitle = "No Most Awarded MOTM Players Yet";
String coachesMonthlyCommentsTitle = "Coaches' Monthly Comments";
String coachesMonthlyCommentsEmptyTitle = "No Comment From Any Coach Yet";
String foundersMonthlyCommentsTitle = "Founders' Monthly Comments";
String foundersMonthlyCommentsEmptyTitle =
    "No Comment From Any CPFC Founder Yet";
String potmTitle = "Player Of The Month";
String potmTwoTitle = "PLAYER OF THE MONTH";
String potmEmptyTitle = "No POTM Nominated Yet";

String playerPositionTitle = "Position";
String playerPositionTwoTitle = "Player Position";
String playerPreferredFootTitle = "Preferred Foot";
String playerNameTitle = " Name";
String playerGoalsScoredTitle = " Goals";
String playerGoalsScoredTwoTitle = "Goals Scored";
String playerAssistsTitle = " Assists";
String playerAssistsTwoTitle = " Assists Provided";
String playerMatchesPlayedTitle = " Matches";
String playerYellowCardedTitle = "Yellow Cards 🟨";
String playerRedCardedTitle = "Red Cards 🟥";
String playerGoalsConcededTitle = "Goals Con.";
String playerGoalsConcededTwoTitle = "Goals Conceded";
String playerCleanSheetTitle = "Clean Sheets";
String coachTitle = "Coach ";
String monthReviewTitle = "Month Review  ";
String potmYayTitle = "YAY!";
String matchesPlayedTitle = "Matches Played";
String presentedByTitle = "Presented By";
String nouvellesoftTitle = "Nouvellesoft.io Inc.";

String lottieJsonGoalTitle = "assets/json/goal_gif.json";
String lottieJsonAssistsTitle = "assets/json/assists_gif.json";
String lottieJsonYellowCardTitle = "assets/json/yellowcard_gif.json";
String lottieJsonRedCardTitle = "assets/json/redcard_two_gif.json";
String lottieJsonGoalKeeperTitle = "assets/json/top_goal_keeper_gif.json";
String lottieJsonMOTMTitle = "assets/json/motm_award.json";
String lottieJsonCumAwardMOTMTitle = "assets/json/cum_motm_award.json";
String lottieJsonCoachesCommentMOTMTitle =
    "assets/json/coaches_comment_gif.json";
String lottieJsonFoundersCommentMOTMTitle =
    "assets/json/founders_comment_gif.json";
String lottieJsonPOTMTitle = "assets/json/potm_award.json";

String assetPOTMBackgroundTitle = "assets/images/back_field.png";
String assetPOTMMVPTitle = "assets/images/MVP_Blooded_3.png";

late Map<int, Widget> playersTGPAndMAP;

class PlayersStatsAndInfoPage extends StatefulWidget {
  const PlayersStatsAndInfoPage({Key? key}) : super(key: key);

  @override
  State<PlayersStatsAndInfoPage> createState() =>
      _PlayersStatsAndInfoPageState();
}

class _PlayersStatsAndInfoPageState extends State<PlayersStatsAndInfoPage> {
  late ConfettiController _controllerTopCenter;

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
      backgroundColor: backgroundColor,
      body: ParallaxRain(
        dropColors: [parallaxRainColor],
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
                        color: iconColor,
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
                        clubName,
                        style: NeumorphicStyle(
                          depth: 4,
                          color: clubNameColor,
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
                                        topGoalScorersTitle,
                                        style: TextStyle(
                                            color: topPlayersColor,
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
                                          color: clayContainerColor,
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
                                                      lottieJsonGoalTitle,
                                                      // width: MediaQuery.of(context).size.width * 0.80,
                                                      height: 200,
                                                      fit: BoxFit.contain,
                                                    )),
                                                    const SizedBox(height: 20),
                                                    Text(
                                                      topGoalScorersEmptyTitle,
                                                      style: TextStyle(
                                                          color:
                                                              topPlayersEmptyColor),
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
                                          color: clayContainerColor,
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
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color:
                                                              containerColor),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          (index + 1)
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: textColorOne,
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
                                                        SizedBox(
                                                          height: 50,
                                                          child:
                                                              VerticalDivider(
                                                            // width: 14,
                                                            thickness: 3,
                                                            color:
                                                                verticalDividerOneColor,
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
                                                            Text(
                                                              playerPositionTitle,
                                                              style: TextStyle(
                                                                  color:
                                                                      textColorTwo),
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
                                                        SizedBox(
                                                          height: 50,
                                                          child:
                                                              VerticalDivider(
                                                            thickness: 3,
                                                            color:
                                                                verticalDividerTwoColor,
                                                          ),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text(
                                                              playerPreferredFootTitle,
                                                              style: TextStyle(
                                                                  color:
                                                                      textColorTwo),
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
                                                            Text(
                                                              playerNameTitle,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              width: 70,
                                                              child: Divider(
                                                                indent: 5,
                                                                thickness: 3,
                                                                color:
                                                                    verticalDividerThreeColor,
                                                              ),
                                                            ),
                                                            Text(
                                                              topGoalsPlayersStatsAndInfoNotifier
                                                                  .topGoalsPlayersStatsAndInfoList[
                                                                      index]
                                                                  .playerName!,
                                                              overflow:
                                                                  TextOverflow
                                                                      .fade,
                                                              style: TextStyle(
                                                                color:
                                                                    playerNameColor,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text(
                                                              playerGoalsScoredTitle,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    keyTextColor,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 70,
                                                              child: Divider(
                                                                indent: 5,
                                                                thickness: 3,
                                                                color:
                                                                    verticalDividerFourColor,
                                                              ),
                                                            ),
                                                            Text(
                                                              '      ${topGoalsPlayersStatsAndInfoNotifier.topGoalsPlayersStatsAndInfoList[index].goalsScored}',
                                                              style: TextStyle(
                                                                color:
                                                                    keyTextColor,
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
                                                            Text(
                                                              playerMatchesPlayedTitle,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              width: 70,
                                                              child: Divider(
                                                                indent: 15,
                                                                thickness: 3,
                                                                color:
                                                                    verticalDividerFiveColor,
                                                              ),
                                                            ),
                                                            Text(
                                                              '   ${topGoalsPlayersStatsAndInfoNotifier.topGoalsPlayersStatsAndInfoList[index].matchesPlayed} played',
                                                              style: TextStyle(
                                                                  color:
                                                                      textColorTwo),
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
                                        topAssistsPlayersTitle,
                                        style: TextStyle(
                                            color: topPlayersColor,
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
                                          color: clayContainerColor,
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
                                                      lottieJsonAssistsTitle,
                                                      // width: MediaQuery.of(context).size.width * 0.80,
                                                      height: 200,
                                                      fit: BoxFit.contain,
                                                    )),
                                                    const SizedBox(height: 20),
                                                    Text(
                                                      topAssistsPlayersEmptyTitle,
                                                      style: TextStyle(
                                                        color:
                                                            topPlayersEmptyColor,
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
                                          color: clayContainerColor,
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
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color:
                                                              containerColor),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          (index + 1)
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  textColorOne),
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
                                                        SizedBox(
                                                          height: 50,
                                                          child: VerticalDivider(
                                                              // width: 14,
                                                              thickness: 3,
                                                              color: verticalDividerOneColor),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text(
                                                              playerPositionTitle,
                                                              style: TextStyle(
                                                                  color:
                                                                      textColorTwo),
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
                                                        SizedBox(
                                                          height: 50,
                                                          child: VerticalDivider(
                                                              thickness: 3,
                                                              color:
                                                                  verticalDividerTwoColor),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text(
                                                              playerPreferredFootTitle,
                                                              style: TextStyle(
                                                                  color:
                                                                      textColorTwo),
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
                                                            Text(
                                                              playerNameTitle,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              width: 70,
                                                              child: Divider(
                                                                  indent: 5,
                                                                  thickness: 3,
                                                                  color:
                                                                      verticalDividerThreeColor),
                                                            ),
                                                            Text(
                                                              mostAssistsPlayersStatsAndInfoNotifier
                                                                  .mostAssistsPlayersStatsAndInfoList[
                                                                      index]
                                                                  .playerName!,
                                                              overflow:
                                                                  TextOverflow
                                                                      .fade,
                                                              style: TextStyle(
                                                                  color:
                                                                      textColorOne),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text(
                                                              playerAssistsTitle,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    keyTextColor,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 70,
                                                              child: Divider(
                                                                indent: 5,
                                                                thickness: 3,
                                                                color:
                                                                    verticalDividerFourColor,
                                                              ),
                                                            ),
                                                            Text(
                                                              '      ${mostAssistsPlayersStatsAndInfoNotifier.mostAssistsPlayersStatsAndInfoList[index].assists}',
                                                              style: TextStyle(
                                                                color:
                                                                    keyTextColor,
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
                                                            Text(
                                                              playerMatchesPlayedTitle,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              width: 70,
                                                              child: Divider(
                                                                indent: 15,
                                                                thickness: 3,
                                                                color:
                                                                    verticalDividerFiveColor,
                                                              ),
                                                            ),
                                                            Text(
                                                              '   ${mostAssistsPlayersStatsAndInfoNotifier.mostAssistsPlayersStatsAndInfoList[index].matchesPlayed} played',
                                                              style: TextStyle(
                                                                  color:
                                                                      textColorTwo),
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
                                        topYellowCardedPlayersTitle,
                                        style: TextStyle(
                                            color: topPlayersColor,
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
                                          color: clayContainerColor,
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
                                                      lottieJsonYellowCardTitle,
                                                      // width: MediaQuery.of(context).size.width * 0.80,
                                                      height: 150,
                                                      fit: BoxFit.contain,
                                                    )),
                                                    const SizedBox(height: 20),
                                                    Text(
                                                      topYellowCardedPlayersEmptyTitle,
                                                      style: TextStyle(
                                                        color: clubNameColor,
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
                                                      width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width *
                                                          0.35,
                                                      emboss: true,
                                                      spread: 2,
                                                      color: clayContainerColor,
                                                      depth: 30,
                                                      curveType:
                                                          CurveType.concave,
                                                      customBorderRadius:
                                                          const BorderRadius
                                                                  .only(
                                                              topRight:
                                                                  Radius
                                                                      .circular(
                                                                          70),
                                                              bottomLeft: Radius
                                                                  .circular(7),
                                                              topLeft: Radius
                                                                  .circular(7),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
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
                                                            Text(
                                                              playerYellowCardedTitle,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    keyTextTwoColor,
                                                              ),
                                                            ),
                                                            Text(mostFouledYCPlayersStatsAndInfoNotifier
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
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color:
                                                                        containerColor),
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
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      playerNameColor,
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
                                                  color: clayContainerColor,
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
                                        topRedCardedPlayersTitle,
                                        style: TextStyle(
                                            color: topPlayersColor,
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
                                          color: clayContainerColor,
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
                                                      lottieJsonRedCardTitle,
                                                      // width: MediaQuery.of(context).size.width * 0.80,
                                                      height: 120,
                                                      fit: BoxFit.contain,
                                                    )),
                                                    const SizedBox(height: 20),
                                                    Text(
                                                      topRedCardedPlayersEmptyTitle,
                                                      style: TextStyle(
                                                        color:
                                                            topPlayersEmptyColor,
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
                                                      width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width *
                                                          0.35,
                                                      emboss: true,
                                                      spread: 2,
                                                      color: clayContainerColor,
                                                      depth: 49,
                                                      curveType:
                                                          CurveType.concave,
                                                      customBorderRadius:
                                                          const BorderRadius
                                                                  .only(
                                                              topRight:
                                                                  Radius
                                                                      .circular(
                                                                          70),
                                                              bottomLeft: Radius
                                                                  .circular(7),
                                                              topLeft: Radius
                                                                  .circular(7),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
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
                                                            Text(
                                                              playerRedCardedTitle,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    keyTextThreeColor,
                                                              ),
                                                            ),
                                                            Text(mostFouledRCPlayersStatsAndInfoNotifier
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
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color:
                                                                        containerColor),
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
                                                                TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      playerNameColor,
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
                                                  color: clayContainerColor,
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
                                        control: SwiperControl(
                                          color: swiperColor,
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
                                        topGoalkeepersTitle,
                                        style: TextStyle(
                                            color: topPlayersColor,
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
                                          color: clayContainerColor,
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
                                                      lottieJsonGoalKeeperTitle,
                                                      // width: MediaQuery.of(context).size.width * 0.80,
                                                      height: 200,
                                                      fit: BoxFit.contain,
                                                    )),
                                                    const SizedBox(height: 20),
                                                    Text(
                                                      topGoalkeepersEmptyTitle,
                                                      style: TextStyle(
                                                        color:
                                                            topPlayersEmptyColor,
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
                                          color: clayContainerColor,
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
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color:
                                                              containerColor),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          (index + 1)
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: textColorOne,
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
                                                        SizedBox(
                                                          height: 50,
                                                          child:
                                                              VerticalDivider(
                                                            // width: 14,
                                                            thickness: 3,
                                                            color:
                                                                verticalDividerOneColor,
                                                          ),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text(
                                                              playerPositionTitle,
                                                              style: TextStyle(
                                                                  color:
                                                                      textColorTwo),
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
                                                        SizedBox(
                                                          height: 50,
                                                          child:
                                                              VerticalDivider(
                                                            thickness: 3,
                                                            color:
                                                                verticalDividerTwoColor,
                                                          ),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text(
                                                              playerNameTitle,
                                                              style: TextStyle(
                                                                  color:
                                                                      textColorTwo),
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                            Text(
                                                              '       ${topGKPlayersStatsAndInfoNotifier.topGKPlayersStatsAndInfoList[index].playerName!}',
                                                              overflow:
                                                                  TextOverflow
                                                                      .fade,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    playerNameColor,
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
                                                            Text(
                                                              playerGoalsConcededTitle,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              width: 70,
                                                              child: Divider(
                                                                indent: 5,
                                                                thickness: 3,
                                                                color:
                                                                    verticalDividerThreeColor,
                                                              ),
                                                            ),
                                                            Text(
                                                              '      ${topGKPlayersStatsAndInfoNotifier.topGKPlayersStatsAndInfoList[index].goalsConcededGkDef.toString()}',
                                                              style: TextStyle(
                                                                  color:
                                                                      textColorTwo),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text(
                                                              playerCleanSheetTitle,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      keyTextColor),
                                                            ),
                                                            SizedBox(
                                                              width: 70,
                                                              child: Divider(
                                                                indent: 5,
                                                                thickness: 3,
                                                                color:
                                                                    verticalDividerFourColor,
                                                              ),
                                                            ),
                                                            Text(
                                                              '      ${topGKPlayersStatsAndInfoNotifier.topGKPlayersStatsAndInfoList[index].cleanSheetGk}',
                                                              style: TextStyle(
                                                                color:
                                                                    keyTextColor,
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
                                                            Text(
                                                              playerMatchesPlayedTitle,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              width: 60,
                                                              child: Divider(
                                                                indent: 10,
                                                                thickness: 3,
                                                                color:
                                                                    verticalDividerFiveColor,
                                                              ),
                                                            ),
                                                            Text(
                                                              '${topGKPlayersStatsAndInfoNotifier.topGKPlayersStatsAndInfoList[index].matchesPlayed} played',
                                                              style: TextStyle(
                                                                  color:
                                                                      textColorTwo),
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
                                        topDefensivePlayersTitle,
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
                                        color: clayContainerColor,
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
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: containerColor),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        (index + 1).toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: textColorOne,
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
                                                      SizedBox(
                                                        height: 50,
                                                        child: VerticalDivider(
                                                          // width: 14,
                                                          thickness: 3,
                                                          color:
                                                              verticalDividerOneColor,
                                                        ),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            playerPositionTitle,
                                                            style: TextStyle(
                                                                color:
                                                                    textColorTwo),
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          Text(
                                                            '       ${topDefensivePlayersStatsAndInfoNotifier.topDefensivePlayersStatsAndInfoList[index].playerPosition?.toUpperCase()}',
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
                                                      SizedBox(
                                                        height: 50,
                                                        child: VerticalDivider(
                                                          thickness: 3,
                                                          color:
                                                              verticalDividerTwoColor,
                                                        ),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            playerPreferredFootTitle,
                                                            style: TextStyle(
                                                                color:
                                                                    textColorTwo),
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          Text(
                                                            '       ${topDefensivePlayersStatsAndInfoNotifier.topDefensivePlayersStatsAndInfoList[index].preferredFoot!}',
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
                                                          Text(
                                                            playerNameTitle,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SizedBox(
                                                            width: 70,
                                                            child: Divider(
                                                              indent: 5,
                                                              thickness: 3,
                                                              color:
                                                                  verticalDividerThreeColor,
                                                            ),
                                                          ),
                                                          Text(
                                                            '   ${topDefensivePlayersStatsAndInfoNotifier.topDefensivePlayersStatsAndInfoList[index].playerName!}',
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                            style: TextStyle(
                                                              color:
                                                                  playerNameColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            playerGoalsConcededTitle,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  keyTextColor,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 70,
                                                            child: Divider(
                                                              indent: 5,
                                                              thickness: 3,
                                                              color:
                                                                  verticalDividerFourColor,
                                                            ),
                                                          ),
                                                          Text(
                                                            '      ${topDefensivePlayersStatsAndInfoNotifier.topDefensivePlayersStatsAndInfoList[index].goalsConcededGkDef}',
                                                            style: TextStyle(
                                                              color:
                                                                  keyTextColor,
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
                                                          Text(
                                                            playerMatchesPlayedTitle,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SizedBox(
                                                            width: 60,
                                                            child: Divider(
                                                              indent: 10,
                                                              thickness: 3,
                                                              color:
                                                                  verticalDividerFiveColor,
                                                            ),
                                                          ),
                                                          Text(
                                                            '${topDefensivePlayersStatsAndInfoNotifier.topDefensivePlayersStatsAndInfoList[index].matchesPlayed} played',
                                                            style: TextStyle(
                                                                color:
                                                                    textColorTwo),
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
                                        MediaQuery.of(context).size.width * 0.9,
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
                                        weeklyMOTMPlayersTitle,
                                        style: TextStyle(
                                            color: topPlayersColor,
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.80,
                                          emboss: true,
                                          spread: 2,
                                          color: clayContainerColor,
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
                                                      lottieJsonMOTMTitle,
                                                      // width: MediaQuery.of(context).size.width * 0.80,
                                                      height: 200,
                                                      fit: BoxFit.contain,
                                                    )),
                                                    const SizedBox(height: 20),
                                                    Text(
                                                      weeklyMOTMPlayersEmptyTitle,
                                                      style: TextStyle(
                                                        color: textColorOne,
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
                                          color: clayContainerColor,
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
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color:
                                                              containerColor),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          (index + 1)
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: textColorOne,
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
                                                        SizedBox(
                                                          height: 50,
                                                          child:
                                                              VerticalDivider(
                                                            // width: 14,
                                                            thickness: 3,
                                                            color:
                                                                verticalDividerOneColor,
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
                                                            Text(
                                                              playerPositionTitle,
                                                              style: TextStyle(
                                                                  color:
                                                                      textColorTwo),
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                            Text(
                                                              '       ${motmPlayersStatsAndInfoNotifier.mOTMPlayersStatsAndInfoList[index].playerPosition?.toUpperCase()}',
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
                                                        SizedBox(
                                                          height: 50,
                                                          child:
                                                              VerticalDivider(
                                                            thickness: 3,
                                                            color:
                                                                verticalDividerTwoColor,
                                                          ),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text(
                                                              playerPreferredFootTitle,
                                                              style: TextStyle(
                                                                  color:
                                                                      textColorTwo),
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                            Text(
                                                              '       ${(motmPlayersStatsAndInfoNotifier.mOTMPlayersStatsAndInfoList[index].preferredFoot)!}',
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
                                                            Text(
                                                              playerNameTitle,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              width: 70,
                                                              child: Divider(
                                                                indent: 5,
                                                                thickness: 3,
                                                                color:
                                                                    verticalDividerThreeColor,
                                                              ),
                                                            ),
                                                            Text(
                                                              '   ${motmPlayersStatsAndInfoNotifier.mOTMPlayersStatsAndInfoList[index].playerName!}',
                                                              overflow:
                                                                  TextOverflow
                                                                      .fade,
                                                              style: TextStyle(
                                                                color:
                                                                    playerNameColor,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text(
                                                              playerMatchesPlayedTitle,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              width: 60,
                                                              child: Divider(
                                                                indent: 10,
                                                                thickness: 3,
                                                                color:
                                                                    verticalDividerFiveColor,
                                                              ),
                                                            ),
                                                            Text(
                                                              '${motmPlayersStatsAndInfoNotifier.mOTMPlayersStatsAndInfoList[index].matchesPlayed} played',
                                                              style: TextStyle(
                                                                  color:
                                                                      textColorTwo),
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
                                        cumAwardMOTMPlayersTitle,
                                        style: TextStyle(
                                            color: topPlayersColor,
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.80,
                                          emboss: true,
                                          spread: 2,
                                          color: clayContainerColor,
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
                                                      lottieJsonCumAwardMOTMTitle,
                                                      // width: MediaQuery.of(context).size.width * 0.80,
                                                      height: 200,
                                                      fit: BoxFit.contain,
                                                    )),
                                                    const SizedBox(height: 20),
                                                    Text(
                                                      cumAwardMOTMPlayersEmptyTitle,
                                                      style: TextStyle(
                                                        color: textColorOne,
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
                                          color: clayContainerColor,
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
                                                                cumMOTMPlayersStatsAndInfoNotifier
                                                                    .cumMOTMPlayersStatsAndInfoList[
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
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color:
                                                              containerColor),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          (index + 1)
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: textColorOne,
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
                                                        SizedBox(
                                                          height: 50,
                                                          child:
                                                              VerticalDivider(
                                                            // width: 14,
                                                            thickness: 3,
                                                            color:
                                                                verticalDividerOneColor,
                                                          ),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text(
                                                              playerPositionTitle,
                                                              style: TextStyle(
                                                                  color:
                                                                      textColorTwo),
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                            Text(
                                                              '       ${cumMOTMPlayersStatsAndInfoNotifier.cumMOTMPlayersStatsAndInfoList[index].playerPosition?.toUpperCase()}',
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
                                                        SizedBox(
                                                          height: 50,
                                                          child:
                                                              VerticalDivider(
                                                            thickness: 3,
                                                            color:
                                                                verticalDividerTwoColor,
                                                          ),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text(
                                                              playerPreferredFootTitle,
                                                              style: TextStyle(
                                                                  color:
                                                                      textColorTwo),
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                            Text(
                                                              '       ${cumMOTMPlayersStatsAndInfoNotifier.cumMOTMPlayersStatsAndInfoList[index].preferredFoot!}',
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
                                                            Text(
                                                              playerNameTitle,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              width: 70,
                                                              child: Divider(
                                                                indent: 5,
                                                                thickness: 3,
                                                                color:
                                                                    verticalDividerThreeColor,
                                                              ),
                                                            ),
                                                            Text(
                                                              '   ${cumMOTMPlayersStatsAndInfoNotifier.cumMOTMPlayersStatsAndInfoList[index].playerName!}',
                                                              overflow:
                                                                  TextOverflow
                                                                      .fade,
                                                              style: TextStyle(
                                                                color:
                                                                    playerNameColor,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Text(
                                                              cumMOTMCountPlayersTitle,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    keyTextColor,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 70,
                                                              child: Divider(
                                                                indent: 5,
                                                                thickness: 3,
                                                                color:
                                                                    verticalDividerFourColor,
                                                              ),
                                                            ),
                                                            Text(
                                                                '      ${cumMOTMPlayersStatsAndInfoNotifier.cumMOTMPlayersStatsAndInfoList[index].cumMOTMCount}',
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      keyTextColor,
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
                                                            Text(
                                                                playerMatchesPlayedTitle,
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis),
                                                            SizedBox(
                                                              width: 60,
                                                              child: Divider(
                                                                indent: 10,
                                                                thickness: 3,
                                                                color:
                                                                    verticalDividerFiveColor,
                                                              ),
                                                            ),
                                                            Text(
                                                                '${cumMOTMPlayersStatsAndInfoNotifier.cumMOTMPlayersStatsAndInfoList[index].matchesPlayed} played',
                                                                style: TextStyle(
                                                                    color:
                                                                        textColorTwo),
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
                                        coachesMonthlyCommentsTitle,
                                        style: TextStyle(
                                            color: topPlayersColor,
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.80,
                                          emboss: true,
                                          spread: 2,
                                          color: clayContainerColor,
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
                                                      lottieJsonCoachesCommentMOTMTitle,
                                                      // width: MediaQuery.of(context).size.width * 0.80,
                                                      height: 200,
                                                      fit: BoxFit.contain,
                                                    )),
                                                    const SizedBox(height: 20),
                                                    Text(
                                                      coachesMonthlyCommentsEmptyTitle,
                                                      style: TextStyle(
                                                        color: textColorOne,
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
                                          color: clayContainerColor,
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
                                                        "$coachTitle+${coachesReviewsCommentNotifier.coachesReviewsCommentList[index].name!.replaceAll(" ", "\n")}",
                                                        style: GoogleFonts
                                                            .kottaOne(
                                                          color: keyTextColor,
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
                                                          "$monthReviewTitle+[${coachesReviewsCommentNotifier.coachesReviewsCommentList[index].date!}]",
                                                          style: GoogleFonts
                                                              .iceberg(
                                                            color:
                                                                textColorThree,
                                                            fontSize: 15,
                                                          ),
                                                          textAlign:
                                                              TextAlign.start),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                          '"${coachesReviewsCommentNotifier.coachesReviewsCommentList[index].comment!}"',
                                                          style: GoogleFonts.iceberg(
                                                              color:
                                                                  textColorFour,
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
                                        foundersMonthlyCommentsTitle,
                                        style: TextStyle(
                                            color: topPlayersColor,
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.80,
                                          emboss: true,
                                          spread: 2,
                                          color: clayContainerColor,
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
                                                      lottieJsonFoundersCommentMOTMTitle,
                                                      // width: MediaQuery.of(context).size.width * 0.80,
                                                      height: 200,
                                                      fit: BoxFit.contain,
                                                    )),
                                                    const SizedBox(height: 20),
                                                    Text(
                                                      foundersMonthlyCommentsEmptyTitle,
                                                      style: TextStyle(
                                                        color: textColorOne,
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
                                          color: clayContainerColor,
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
                                                          color: keyTextColor,
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
                                                          "$monthReviewTitle+[${foundersReviewsCommentNotifier.foundersReviewsCommentList[index].date!}]",
                                                          style: GoogleFonts
                                                              .iceberg(
                                                            color:
                                                                textColorThree,
                                                            fontSize: 15,
                                                          ),
                                                          textAlign:
                                                              TextAlign.start),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                          '"${foundersReviewsCommentNotifier.foundersReviewsCommentList[index].comment!}"',
                                                          style: GoogleFonts.iceberg(
                                                              color:
                                                                  textColorFour,
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
                                        left: 22, bottom: 22),
                                    child: Listener(
                                      onPointerDown: (_) => setState(() {
                                        isTextPressed = true;
                                      }),
                                      onPointerUp: (_) => setState(() {
                                        isTextPressed = false;
                                      }),
                                      child: Text(
                                        potmTitle,
                                        style: TextStyle(
                                            color: topPlayersColor,
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
                                        color: potmColorOne,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: potmColorTwo.withAlpha(30),
                                              offset: const Offset(4.0, 2.0),
                                              blurRadius: 1.0,
                                              spreadRadius: 1.0),
                                          BoxShadow(
                                              color: potmColorTwo.withAlpha(60),
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
                                              color: potmColorOne,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(15)),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: potmColorThree!,
                                                    offset: -distance,
                                                    blurRadius: blur,
                                                    spreadRadius: 1.0),
                                                BoxShadow(
                                                    color: potmColorFour!,
                                                    offset: distance,
                                                    blurRadius: blur,
                                                    spreadRadius: 1.0),
                                              ],
                                            ),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                potmYayTitle,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 60,
                                                    shadows: [
                                                      Shadow(
                                                          offset: const Offset(
                                                              3, 3),
                                                          // color: Colors.black38,
                                                          color: potmColorFive,
                                                          blurRadius: 10),
                                                      Shadow(
                                                          offset: const Offset(
                                                              -3, -3),
                                                          color: potmColorOne!,
                                                          blurRadius: 10)
                                                    ],
                                                    color: potmColorOne),
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
                                                        lottieJsonPOTMTitle,
                                                        // width: MediaQuery.of(context).size.width * 0.80,
                                                        height: 200,
                                                        fit: BoxFit.contain,
                                                      )),
                                                      const SizedBox(
                                                          height: 20),
                                                      Text(
                                                        potmEmptyTitle,
                                                        style: TextStyle(
                                                          color: potmColorSix,
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
                                                  backgroundColor: dialogColor,
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
                                                            MediaQuery.of(
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
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    .43,
                                                                height: MediaQuery.of(
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
                                                                height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height,
                                                                // height: 500,
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                child:
                                                                Image.asset(
                                                                  assetPOTMBackgroundTitle,
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
                                                                      assetPOTMMVPTitle,
                                                                      width: MediaQuery.of(context)
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
                                                                              const EdgeInsets.only(right: 10),
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                MediaQuery.of(context).size.width * 0.35,
                                                                            child:
                                                                                Text(
                                                                                  playerOfTheMonthStatsAndInfoNotifier.playerOfTheMonthStatsAndInfoList[index].playerName!.replaceAll(" ", "\n"),
                                                                              style: GoogleFonts.rubikMicrobe(color: dialogColor, fontSize: 30, fontWeight: FontWeight.bold, height: 0.81),
                                                                              overflow: TextOverflow.ellipsis,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                40),
                                                                        Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 10),
                                                                              child: SizedBox(
                                                                                width: MediaQuery.of(context).size.width * 0.35,
                                                                                child: Text(
                                                                                  playerOfTheMonthStatsAndInfoNotifier.playerOfTheMonthStatsAndInfoList[index].goalsConcededGkDef.toString(),
                                                                                  style: GoogleFonts.rubikMicrobe(color: dialogColor, fontSize: 30, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 10),
                                                                              child: SizedBox(
                                                                                width: MediaQuery.of(context).size.width * 0.35,
                                                                                child: Text(
                                                                                  playerGoalsConcededTwoTitle,
                                                                                  style: GoogleFonts.arimo(
                                                                                    color: containerColor,
                                                                                    fontSize: 14,
                                                                                    fontWeight: FontWeight.w200,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(height: 15),
                                                                          ],
                                                                        ),
                                                                        Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 10),
                                                                              child: SizedBox(
                                                                                width: MediaQuery.of(context).size.width * 0.35,
                                                                                child: Text(
                                                                                  playerOfTheMonthStatsAndInfoNotifier.playerOfTheMonthStatsAndInfoList[index].cleanSheetGk.toString(),
                                                                                  style: GoogleFonts.rubikMicrobe(color: dialogColor, fontSize: 30, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 10),
                                                                              child: SizedBox(
                                                                                width: MediaQuery.of(context).size.width * 0.35,
                                                                                child: Text(
                                                                                  playerCleanSheetTitle,
                                                                                  style: GoogleFonts.arimo(
                                                                                    color: containerColor,
                                                                                    fontSize: 14,
                                                                                    fontWeight: FontWeight.w200,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(height: 15),
                                                                          ],
                                                                        ),
                                                                        Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 10),
                                                                              child: SizedBox(
                                                                                width: MediaQuery.of(context).size.width * 0.35,
                                                                                child: Text(
                                                                                  playerOfTheMonthStatsAndInfoNotifier.playerOfTheMonthStatsAndInfoList[index].matchesPlayed.toString(),
                                                                                  style: GoogleFonts.rubikMicrobe(color: dialogColor, fontSize: 30, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 10),
                                                                              child: SizedBox(
                                                                                width: MediaQuery.of(context).size.width * 0.35,
                                                                                child: Text(
                                                                                  matchesPlayedTitle,
                                                                                  style: GoogleFonts.arimo(
                                                                                    color: containerColor,
                                                                                    fontSize: 14,
                                                                                    fontWeight: FontWeight.w200,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(height: 80),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ] else if (playerOfTheMonthStatsAndInfoNotifier.playerOfTheMonthStatsAndInfoList[index].playerPosition.toString().toLowerCase() == 'cb' ||
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
                                                                              const EdgeInsets.only(right: 10),
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                MediaQuery.of(context).size.width * 0.35,
                                                                            child:
                                                                                Text(
                                                                                  playerOfTheMonthStatsAndInfoNotifier.playerOfTheMonthStatsAndInfoList[index].playerName!.replaceAll(" ", "\n"),
                                                                              style: GoogleFonts.rubikMicrobe(color: dialogColor, fontSize: 25, fontWeight: FontWeight.bold, height: 0.81),
                                                                              overflow: TextOverflow.ellipsis,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                40),
                                                                        Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 10),
                                                                              child: SizedBox(
                                                                                width: MediaQuery.of(context).size.width * 0.35,
                                                                                child: Text(
                                                                                  playerOfTheMonthStatsAndInfoNotifier.playerOfTheMonthStatsAndInfoList[index].playerPosition.toString().toUpperCase(),
                                                                                  style: GoogleFonts.rubikMicrobe(color: dialogColor, fontSize: 30, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 10),
                                                                              child: SizedBox(
                                                                                width: MediaQuery.of(context).size.width * 0.35,
                                                                                child: Text(
                                                                                  playerPositionTwoTitle,
                                                                                  style: GoogleFonts.arimo(
                                                                                    color: containerColor,
                                                                                    fontSize: 14,
                                                                                    fontWeight: FontWeight.w200,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(height: 15),
                                                                          ],
                                                                        ),
                                                                        Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 10),
                                                                              child: SizedBox(
                                                                                width: MediaQuery.of(context).size.width * 0.35,
                                                                                child: Text(
                                                                                  playerOfTheMonthStatsAndInfoNotifier.playerOfTheMonthStatsAndInfoList[index].goalsConcededGkDef.toString(),
                                                                                  style: GoogleFonts.rubikMicrobe(color: dialogColor, fontSize: 30, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 10),
                                                                              child: SizedBox(
                                                                                width: MediaQuery.of(context).size.width * 0.35,
                                                                                child: Text(
                                                                                  playerGoalsConcededTwoTitle,
                                                                                  style: GoogleFonts.arimo(
                                                                                    color: containerColor,
                                                                                    fontSize: 14,
                                                                                    fontWeight: FontWeight.w200,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(height: 15),
                                                                          ],
                                                                        ),
                                                                        Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 10),
                                                                              child: SizedBox(
                                                                                width: MediaQuery.of(context).size.width * 0.35,
                                                                                child: Text(
                                                                                  playerOfTheMonthStatsAndInfoNotifier.playerOfTheMonthStatsAndInfoList[index].matchesPlayed.toString(),
                                                                                  style: GoogleFonts.rubikMicrobe(color: dialogColor, fontSize: 30, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 10),
                                                                              child: SizedBox(
                                                                                width: MediaQuery.of(context).size.width * 0.35,
                                                                                child: Text(
                                                                                  matchesPlayedTitle,
                                                                                  style: GoogleFonts.arimo(
                                                                                    color: containerColor,
                                                                                    fontSize: 14,
                                                                                    fontWeight: FontWeight.w200,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(height: 80),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ] else ...[
                                                                    Column(
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(right: 10),
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                MediaQuery.of(context).size.width * 0.35,
                                                                            child:
                                                                                Text(
                                                                                  playerOfTheMonthStatsAndInfoNotifier.playerOfTheMonthStatsAndInfoList[index].playerName!.replaceAll(" ", "\n"),
                                                                              style: GoogleFonts.rubikMicrobe(color: dialogColor, fontSize: 25, fontWeight: FontWeight.bold, height: 0.81),
                                                                              overflow: TextOverflow.ellipsis,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                40),
                                                                        Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 10),
                                                                              child: SizedBox(
                                                                                width: MediaQuery.of(context).size.width * 0.35,
                                                                                child: Text(
                                                                                  playerOfTheMonthStatsAndInfoNotifier.playerOfTheMonthStatsAndInfoList[index].goalsScored.toString(),
                                                                                  style: GoogleFonts.rubikMicrobe(color: dialogColor, fontSize: 30, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 10),
                                                                              child: SizedBox(
                                                                                width: MediaQuery.of(context).size.width * 0.35,
                                                                                child: Text(
                                                                                  playerGoalsScoredTwoTitle,
                                                                                  style: GoogleFonts.arimo(
                                                                                    color: containerColor,
                                                                                    fontSize: 14,
                                                                                    fontWeight: FontWeight.w200,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(height: 15),
                                                                          ],
                                                                        ),
                                                                        Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 10),
                                                                              child: SizedBox(
                                                                                width: MediaQuery.of(context).size.width * 0.35,
                                                                                child: Text(
                                                                                  playerOfTheMonthStatsAndInfoNotifier.playerOfTheMonthStatsAndInfoList[index].assists.toString(),
                                                                                  style: GoogleFonts.rubikMicrobe(color: dialogColor, fontSize: 30, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 10),
                                                                              child: SizedBox(
                                                                                width: MediaQuery.of(context).size.width * 0.35,
                                                                                child: Text(
                                                                                  playerAssistsTwoTitle,
                                                                                  style: GoogleFonts.arimo(
                                                                                    color: containerColor,
                                                                                    fontSize: 14,
                                                                                    fontWeight: FontWeight.w200,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(height: 15),
                                                                          ],
                                                                        ),
                                                                        Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 10),
                                                                              child: SizedBox(
                                                                                width: MediaQuery.of(context).size.width * 0.35,
                                                                                child: Text(
                                                                                  playerOfTheMonthStatsAndInfoNotifier.playerOfTheMonthStatsAndInfoList[index].matchesPlayed.toString(),
                                                                                  style: GoogleFonts.rubikMicrobe(color: dialogColor, fontSize: 30, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(right: 10),
                                                                              child: SizedBox(
                                                                                width: MediaQuery.of(context).size.width * 0.35,
                                                                                child: Text(
                                                                                  matchesPlayedTitle,
                                                                                  style: GoogleFonts.arimo(
                                                                                    color: containerColor,
                                                                                    fontSize: 14,
                                                                                    fontWeight: FontWeight.w200,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(height: 80),
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
                                                                            const EdgeInsets.only(right: 10),
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              MediaQuery.of(context).size.width * 0.65,
                                                                          child:
                                                                          Text(
                                                                            potmTwoTitle,
                                                                            style:
                                                                                GoogleFonts.orbitron(
                                                                              color: dialogColor,
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(top: 4),
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              MediaQuery.of(context).size.width * 0.65,
                                                                          child:
                                                                          Text(
                                                                            presentedByTitle,
                                                                            style:
                                                                                GoogleFonts.arimo(
                                                                              color: containerColor,
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w200,
                                                                            ),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(top: 5),
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              MediaQuery.of(context).size.width * 0.65,
                                                                          child:
                                                                          Text(
                                                                            nouvellesoftTitle,
                                                                            style:
                                                                                GoogleFonts.gloriaHallelujah(
                                                                              color: containerColor,
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
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
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.19,
                                                    right:
                                                        MediaQuery.of(context)
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
                                                              color: potmColorSeven,
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
                                                                  .deepOrangeAccent),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ] else if (Platform.isIOS) ...[
                                                  Positioned(
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.165,
                                                    right:
                                                        MediaQuery.of(context)
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
                                                              color: potmColorSeven,
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

  /// A custom Path to paint stars with letters.
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

    // Draw the "M"
    path.lineTo(halfWidth - externalRadius * cos(degToRad(18)),
        halfWidth + externalRadius * sin(degToRad(18)));
    path.lineTo(halfWidth - externalRadius * cos(degToRad(54)),
        halfWidth - externalRadius * sin(degToRad(54)));
    path.lineTo(halfWidth - internalRadius * cos(degToRad(54)),
        halfWidth - internalRadius * sin(degToRad(54)));
    path.lineTo(halfWidth - internalRadius * cos(degToRad(18)),
        halfWidth + internalRadius * sin(degToRad(18)));
    path.lineTo(halfWidth + externalRadius * cos(degToRad(18)),
        halfWidth + externalRadius * sin(degToRad(18)));

    // Draw the "V"
    path.moveTo(halfWidth + internalRadius * cos(degToRad(54)),
        halfWidth - internalRadius * sin(degToRad(54)));
    path.lineTo(halfWidth + externalRadius * cos(degToRad(54)),
        halfWidth + externalRadius * sin(degToRad(54)));
    path.lineTo(halfWidth + internalRadius * cos(degToRad(54)),
        halfWidth + internalRadius * sin(degToRad(54)));

    // Draw the "P"
    path.moveTo(halfWidth + internalRadius * cos(degToRad(54)),
        halfWidth - internalRadius * sin(degToRad(54)));
    path.lineTo(halfWidth + externalRadius * cos(degToRad(54)),
        halfWidth - externalRadius * sin(degToRad(54)));
    path.lineTo(halfWidth + externalRadius * cos(degToRad(90)),
        halfWidth - externalRadius * sin(degToRad(90)));
    path.lineTo(halfWidth + internalRadius * cos(degToRad(90)),
        halfWidth - internalRadius * sin(degToRad(90)));

    path.close();
    return path;
  }
}
