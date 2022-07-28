
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../api/club_arial_images_api.dart';
import '../api/achievement_images_api.dart';
import '../notifier/club_arial_notifier.dart';
import '../notifier/achievement_images_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:pie_chart/pie_chart.dart';


String clubName = "Coventry Phoenix FC";
String aboutClub = "About $clubName";

String visionSwipe = "Swipe left on 'OUR VISION STATEMENT'  >>>";
String visionTitle = "OUR VISION STATEMENT";
String visionStatement = "Raising the total youth through comprehensive education.";
String missionTitle = "OUR MISSION STATEMENT";
String missionStatement = "Mobilizing Academic, Moral, Social, Political and Religious tools, by dedicated and vision driven educators in a proactive environment of coaching and learning, which is geared towards impacting and equipping our players to be THE TOTAL YOUTH the world will be proud of.";

String coreValues = "OUR CORE VALUES";
String cvStatement1 = "1. Discipline \n\n";
String cvStatement2 = "2. Unity and Teamwork\n\n";
String cvStatement3 = "3. Hard-Work and Commitment\n\n";
String cvStatement4 = "4. Compete and Reliability.";
String cvStatement5 = "5. Creativity.";

String whyClub = "WHY $clubName?".toUpperCase();
String whyClubStatement = "$clubName was established on the 3rd of October 2015 out of the vision and passion of Dr. Edwin Greaves to empower today’s youth for tomorrows challenges.\n\nWe offer players (both domestic and international) the opportunity to earn an unparalleled high-quality educational experience. With passionate and  qualified coaching staff, a clean and caring club atmosphere, and the resources to supply players with the skills necessary for their continued personal success, our club looks to help players to realize their potential.";
String staffBody = "Staff Body\n\n";
String staffBodyStatement = "We have $coachesPopulation coaching staff and $nonCoachesPopulation non-coaching staff (including management body) in $clubName.";
String populationChart = "$clubName Population Chart **";
String playerBody = "Player Body\n\n";
String playerBodyStatement = "We currently have $totalPlayersPopulation players in $clubName, $malePlayersPopulation male players and $femalePlayersPopulation female players. $graduatedPlayersPopulation players have graduated from $clubName.";
String playerPopulationChart = "$clubName Players Population Chart **";

String trainingSessionSwipe = "Swipe up for all Training exercises offered";
String trainingSessionsOffered = "Some of the training exercises in $clubName are:\n\n";
String trainingSessionsOffered1 = "1. Cone exercise\n";
String trainingSessionsOffered2 = "2. Advanced cone exercise\n";
String trainingSessionsOffered3 = "3. Cut-backs\n";
String trainingSessionsOffered4 = "4. Shooting from a square pass\n";
String trainingSessionsOffered5 = "5. One-touch shooting\n";
String trainingSessionsOffered6 = "6. Three goal drill\n";
String trainingSessionsOffered7 = "7. Lay-offs, turns, and chest control\n";
String trainingSessionsOffered8 = "8. Basic short passes\n";
String trainingSessionsOffered9 = "9. Tackling\n";
String trainingSessionsOffered10 = "10. Small-sided game; and many more.\n\n";


String extraCurricularActs = "Extra-curricular Activities offered in $clubName\n\n";
String extraCurricularActsStatement1 = "1. After football match refreshments for all teams\n";
String extraCurricularActsStatement2 = "2. Horse race betting and similar competitions\n";
String extraCurricularActsStatement3 = "3. Snooker playing and loud music\n";
String extraCurricularActsStatement4 = "4. Semi-competitions on sundays\n";
String extraCurricularActsStatement5 = "5. Local and Foreign excursions\n";
String extraCurricularActsStatement6 = "6. Awards and prices night.\n";

String clubArialViewsSwipe = "Swipe left or right for more photos";
String clubArialViews = "Some Arial views of $clubName";
String clubAchievementsSwipe = "Swipe left or right for more photos";
String clubAchievements = "Some of our Past Achievements";
String moreInfoAboutClub = "For more information about $clubName please trust and click me :)";
String moreInfoAboutClubURL = "https://afcbinley.uk/";

dynamic coachesPopulation;
dynamic nonCoachesPopulation;
dynamic malePlayersPopulation = attackingPlayersPopulation + midfieldingPlayersPopulation + defendingPlayersPopulation + goalkeepingPlayersPopulation;
dynamic femalePlayersPopulation;
dynamic graduatedPlayersPopulation;
dynamic attackingPlayersPopulation;
dynamic midfieldingPlayersPopulation;
dynamic defendingPlayersPopulation;
dynamic goalkeepingPlayersPopulation;
dynamic totalPlayersPopulation = malePlayersPopulation + femalePlayersPopulation;

double malePlayerPopulation = 871;
double femalePlayerPopulation = 655;
double coachingStaffPopulation = 85;
double nonCoachingStaffPopulation = 32;


Color backgroundColor = const Color.fromRGBO(207, 118, 90, 1.0);
Color cardBackgroundColor = const Color.fromRGBO(207, 116, 87, 1.0);
Color appBarIconColor = Colors.white;
Color appBarTextColor = Colors.white;
Color appBarBackgroundColor = const Color.fromRGBO(207, 118, 90, 1.0);
Color cardTextColor = Colors.white;
Color cardColor = const Color.fromRGBO(234, 156, 130, 1.0);
Color boxDecorationColor = const Color.fromRGBO(236, 189, 174, 1.0);
Color chartBackgroundColor = const Color.fromRGBO(28, 26, 26, 1.0);
Color materialColor = Colors.transparent;
Color textColor = Colors.white;
Color firstClubChartColor = const Color.fromRGBO(164, 82, 56, 1.0);
Color secondClubChartColor = const Color.fromRGBO(207, 116, 87, 1.0);
Color thirdClubChartColor = const Color.fromRGBO(234, 156, 130, 1.0);
Color fourthClubChartColor = const Color.fromRGBO(153, 90, 61, 1.0);
Color firstPlayerChartColor = const Color.fromRGBO(164, 82, 56, 1.0);
Color secondPlayerChartColor = const Color.fromRGBO(207, 116, 87, 1.0);
Color thirdPlayerChartColor = const Color.fromRGBO(153, 90, 61, 1.0);
Color fourthPlayerChartColor = const Color.fromRGBO(195, 81, 44, 1.0);


class AboutClubDetails extends StatefulWidget {

  const AboutClubDetails({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<AboutClubDetails> createState() => _AboutClubDetailsState();
}

class _AboutClubDetailsState extends State<AboutClubDetails> {

  final controlla = PageController(
    initialPage: 0,
  );

  var scrollDirection = Axis.horizontal;


  @override
  void initState() {
    ClubArialNotifier clubArialNotifier = Provider.of<ClubArialNotifier>(context, listen: false);
    getClubArial(clubArialNotifier);

    AchievementsNotifier achievementsNotifier = Provider.of<AchievementsNotifier>(context, listen: false);
    getAchievements(achievementsNotifier);

    clubMap.putIfAbsent("Total Male Players", () => 33);
    clubMap.putIfAbsent("Total Female Players", () => 33);
    clubMap.putIfAbsent("Coaching Staff", () => 33);
    clubMap.putIfAbsent("Non Coaching Staff", () => 33);

    playerMap.putIfAbsent("Male Attackers", () => 33);
    playerMap.putIfAbsent("Male Midfielders", () => 33);
    playerMap.putIfAbsent("Male Defenders", () => 33);
    playerMap.putIfAbsent("Male GoalKeepers", () => 33);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ClubArialNotifier clubArialNotifier = Provider.of<ClubArialNotifier>(context);
    AchievementsNotifier achievementsNotifier = Provider.of<AchievementsNotifier>(context);



    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('ClubPopulation')
          .doc('about_club_page').snapshots(),

      builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return Container();
        }
        else {
          coachesPopulation = snapshot.data!.data()!['coaches_population'];
          nonCoachesPopulation =
          snapshot.data!.data()!['non_coaches_population'];
          // malePlayersPopulation = snapshot.data!.data()!['male_players_population'];
          femalePlayersPopulation =
          snapshot.data!.data()!['female_players_population'];
          graduatedPlayersPopulation =
          snapshot.data!.data()!['graduated_players_population'];
          attackingPlayersPopulation =
          snapshot.data!.data()!['attacking_male_players_population'];
          midfieldingPlayersPopulation =
          snapshot.data!.data()!['midfielding_male_players_population'];
          defendingPlayersPopulation =
          snapshot.data!.data()!['defending_male_players_population'];
          goalkeepingPlayersPopulation =
          snapshot.data!.data()!['goalkeepers_male_players_population'];
        }
        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            centerTitle: true,
            title: Text(aboutClub,
              style: TextStyle(
                color: appBarIconColor
              )
            ),
            leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: appBarIconColor),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
            elevation: 10,
            backgroundColor: appBarBackgroundColor,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: boxDecorationColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Material (
                      color: materialColor,
                      child: InkWell(
                        splashColor: cardTextColor,
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Text(visionSwipe,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: cardTextColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 500,
                  child: PageView(
                    controller: controlla,
                    scrollDirection: scrollDirection,
                    pageSnapping: true,
                    children: <Widget>[
                      Card(
                        color: cardBackgroundColor,
                        elevation: 4,
                        margin: const EdgeInsets.all(24),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Center(
                                  child: Text(
                                    visionTitle,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: cardTextColor,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30, left: 8, right: 8, bottom: 8),
                                child: Text(
                                  visionStatement,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: cardTextColor,
                                    fontSize: 18
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: cardBackgroundColor,
                        elevation: 4,
                        margin:   const EdgeInsets.all(24),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Center(
                                  child: Text(
                                    missionTitle,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: cardTextColor,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30, left: 8, right: 8, bottom: 8),
                                child: Text(
                                  missionStatement,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: cardTextColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: cardBackgroundColor,
                        elevation: 4,
                        margin:   const EdgeInsets.all(24),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Center(
                                  child: Text(
                                    coreValues,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: cardTextColor,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30, left: 8, right: 8, bottom: 8),
                                child: RichText(
                                  textAlign: TextAlign.justify,
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: cvStatement1,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: cardTextColor,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: cvStatement2,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: cardTextColor,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: cvStatement3,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: cardTextColor,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: cvStatement4,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: cardTextColor,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: cardBackgroundColor,
                        elevation: 4,
                        margin:   const EdgeInsets.all(24),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Center(
                                  child: Text(
                                    whyClub,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: cardTextColor,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30, left: 8, right: 8, bottom: 8),
                                child: Text(
                                  whyClubStatement,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: cardTextColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                  child: Container(
                    decoration: BoxDecoration(
                        color: boxDecorationColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Material (
                      color: materialColor,
                      child: InkWell(
                        splashColor: cardTextColor,
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15, top: 15, left: 10, right: 10),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: RichText(
                              textAlign: TextAlign.justify,
                              text:TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text: staffBody,
                                      style: TextStyle(
                                        color: cardTextColor,
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                      )
                                  ),
                                  TextSpan(
                                      text: staffBodyStatement,// + snapshot.data?.data()!['coaches_population'],
                                      style: TextStyle(
                                        color: cardTextColor,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w300,
                                      )
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                  child: Container(
                    height:400,
                    decoration: BoxDecoration(
                        color: boxDecorationColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Material(
                      color: materialColor,
                      child: InkWell(
                        splashColor: cardTextColor,
                        onTap: () {},
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 15, bottom: 30, left: 10),
                                child: Text(populationChart,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: cardTextColor,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                              PieChart(
                                dataMap: clubMap,
                                animationDuration: const Duration(milliseconds: 8000),
                                chartLegendSpacing: 42,
                                chartRadius: MediaQuery.of(context).size.width / 2.7,
                                colorList: clubColorList,
                                initialAngleInDegree: 0,
                                chartType: ChartType.disc,
                                legendOptions: LegendOptions(
                                  showLegendsInRow: false,
                                  legendPosition: LegendPosition.bottom,
                                  showLegends: true,
                                  legendShape: BoxShape.circle,
                                  legendTextStyle: TextStyle(
                                    color: cardTextColor,
                                  ),
                                ),
                                chartValuesOptions: ChartValuesOptions(
                                  showChartValueBackground: true,
                                  showChartValues: true,
                                  // showChartValueLabel: true,
                                  chartValueStyle: defaultChartValueStyle.copyWith(
                                    color: textColor.withOpacity(0.9),
                                  ),
                                  showChartValuesInPercentage: false,
                                  showChartValuesOutside: false,
                                  decimalPlaces: 0,
                                  chartValueBackgroundColor: chartBackgroundColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                  child: Container(
                    decoration: BoxDecoration(
                        color: boxDecorationColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Material (
                      color: materialColor,
                      child: InkWell(
                        splashColor: cardTextColor,
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15, top: 15, left: 10, right: 10),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: RichText(
                              textAlign: TextAlign.justify,
                              text:TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text: playerBody,
                                      style: TextStyle(
                                        color: cardTextColor,
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                      )
                                  ),
                                  TextSpan(
                                      text: playerBodyStatement,
                                      style: TextStyle(
                                        color: cardTextColor,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w300,
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                  child: Container(
                    // height: 370,
                    decoration: BoxDecoration(
                        color: boxDecorationColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Material(
                      color: materialColor,
                      child: InkWell(
                        splashColor: cardTextColor,
                        onTap: () {},
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 15, bottom: 30, left: 30, right: 30),
                                child: Text(playerPopulationChart,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: cardTextColor,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                              PieChart(
                                dataMap: playerMap,
                                animationDuration: const Duration(milliseconds: 8000),
                                chartLegendSpacing: 42,
                                chartRadius: MediaQuery.of(context).size.width / 2.7,
                                colorList: playerColorList,
                                initialAngleInDegree: 0,
                                chartType: ChartType.ring,
                                legendOptions: LegendOptions(
                                  showLegendsInRow: false,
                                  legendPosition: LegendPosition.bottom,
                                  showLegends: true,
                                  legendShape: BoxShape.circle,
                                  legendTextStyle: TextStyle(
                                    color: cardTextColor,
                                  ),
                                ),
                                chartValuesOptions: ChartValuesOptions(
                                  showChartValueBackground: true,
                                  showChartValues: true,
                                  // showChartValueLabel: true,
                                  chartValueStyle: defaultChartValueStyle.copyWith(
                                    color: textColor.withOpacity(0.9),
                                  ),
                                  showChartValuesInPercentage: false,
                                  showChartValuesOutside: false,
                                  decimalPlaces: 0,
                                  chartValueBackgroundColor: chartBackgroundColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 10),
                  child: Text(trainingSessionsOffered,
                    style: TextStyle(
                        fontSize: 20,
                        color: cardTextColor,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: boxDecorationColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Material (
                      color: materialColor,
                      child: InkWell(
                        splashColor: cardTextColor,
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Text(trainingSessionSwipe,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: cardTextColor,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                        color: boxDecorationColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Material (
                      color: materialColor,
                      child: InkWell(
                        splashColor: cardTextColor,
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15, top: 15, left: 10, right: 10),
                          child: SingleChildScrollView(
                            child: RichText(
                              textAlign: TextAlign.justify,
                              text:TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text: trainingSessionsOffered,
                                      style: TextStyle(
                                        color: cardTextColor,
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                      )
                                  ),
                                  TextSpan(
                                      text: trainingSessionsOffered1,
                                      style: TextStyle(
                                        color: cardTextColor,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w300,
                                      )
                                  ),
                                  TextSpan(
                                      text: trainingSessionsOffered2,
                                      style: TextStyle(
                                        color: cardTextColor,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w300,
                                      )
                                  ),
                                  TextSpan(
                                      text: trainingSessionsOffered3,
                                      style: TextStyle(
                                        color: cardTextColor,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w300,
                                      )
                                  ),
                                  TextSpan(
                                      text: trainingSessionsOffered4,
                                      style: TextStyle(
                                        color: cardTextColor,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w300,
                                      )
                                  ),
                                  TextSpan(
                                      text: trainingSessionsOffered5,
                                      style: TextStyle(
                                        color: cardTextColor,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w300,
                                      )
                                  ),
                                  TextSpan(
                                      text: trainingSessionsOffered6,
                                      style: TextStyle(
                                        color: cardTextColor,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w300,
                                      )
                                  ),
                                  TextSpan(
                                      text: trainingSessionsOffered7,
                                      style: TextStyle(
                                        color: cardTextColor,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w300,
                                      )
                                  ),
                                  TextSpan(
                                      text: trainingSessionsOffered8,
                                      style: TextStyle(
                                        color: cardTextColor,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w300,
                                      )
                                  ),
                                  TextSpan(
                                      text: trainingSessionsOffered9,
                                      style: TextStyle(
                                        color: cardTextColor,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w300,
                                      )
                                  ),
                                  TextSpan(
                                      text: trainingSessionsOffered10,
                                      style: TextStyle(
                                        color: cardTextColor,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w300,
                                      )
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                        color: boxDecorationColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Material (
                      color: materialColor,
                      child: InkWell(
                        splashColor: cardTextColor,
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15, top: 15, left: 10, right: 10),
                          child: SingleChildScrollView(
                            child: RichText(
                              textAlign: TextAlign.justify,
                              text:TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text: extraCurricularActs,
                                      style: TextStyle(
                                        color: cardTextColor,
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                      )
                                  ),
                                  TextSpan(
                                      text: extraCurricularActsStatement1,
                                      style: TextStyle(
                                        color: cardTextColor,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w300,
                                      )
                                  ),
                                  TextSpan(
                                      text: extraCurricularActsStatement2,
                                      style: TextStyle(
                                        color: cardTextColor,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w300,
                                      )
                                  ),
                                  TextSpan(
                                      text: extraCurricularActsStatement3,
                                      style: TextStyle(
                                        color: cardTextColor,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w300,
                                      )
                                  ),
                                  TextSpan(
                                      text: extraCurricularActsStatement4,
                                      style: TextStyle(
                                        color: cardTextColor,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w300,
                                      )
                                  ),
                                  TextSpan(
                                      text: extraCurricularActsStatement5,
                                      style: TextStyle(
                                        color: cardTextColor,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w300,
                                      )
                                  ),
                                  TextSpan(
                                      text: extraCurricularActsStatement6,
                                      style: TextStyle(
                                        color: cardTextColor,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w300,
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 20, bottom: 10),
                //   child: Text(clubArialViews,
                //   style: TextStyle(
                //     fontSize: 15,
                //     color: cardTextColor,
                //     fontWeight: FontWeight.w500
                //   ),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                //   child: Container(
                //     decoration: BoxDecoration(
                //         color: boxDecorationColor.withAlpha(50),
                //         borderRadius: BorderRadius.circular(5)
                //     ),
                //     child: Material (
                //       color: materialColor,
                //       child: InkWell(
                //         splashColor: cardTextColor,
                //         onTap: () {},
                //         child: Padding(
                //           padding: const EdgeInsets.only(top: 5, bottom: 5),
                //           child: SingleChildScrollView(
                //             scrollDirection: Axis.vertical,
                //             child: Text(clubArialViewsSwipe,
                //               textAlign: TextAlign.center,
                //               style: TextStyle(
                //                   color: cardTextColor,
                //                   fontSize: 15,
                //                   fontWeight: FontWeight.bold
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 340,
                //   child: Swiper(
                //     autoplay: true,
                //     viewportFraction: 0.8,
                //     scale: 0.9,
                //     itemCount: clubArialNotifier.clubArialList.length,
                //     itemBuilder: (context, index) => Column(
                //       children: <Widget>[
                //         Container(
                //           height: 250,
                //           decoration: BoxDecoration(
                //             borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                //             image: DecorationImage(
                //               image: CachedNetworkImageProvider(
                //                   clubArialNotifier.clubArialList[index].image!
                //               ),
                //               fit: BoxFit.cover,
                //             )
                //           ),
                //         ),
                //         Container(
                //           decoration: BoxDecoration(
                //             borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                //             color: cardColor
                //           ),
                //           child: ListTile(
                //             title: Center(
                //               child: SingleChildScrollView(
                //                 scrollDirection: Axis.horizontal,
                //                 child: Text(
                //                   clubArialNotifier.clubArialList[index].toastName!,
                //                   style: TextStyle(
                //                     color: textColor,
                //                     fontWeight: FontWeight.w800,
                //                     fontSize: 17.0,
                //                   ),
                //                   textAlign: TextAlign.center,
                //                 ),
                //               ),
                //             ),
                //           ),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 10),
                  child: Text(clubAchievements,
                  style: TextStyle(
                    fontSize: 20,
                    color: cardTextColor,
                    fontWeight: FontWeight.w500
                  ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: boxDecorationColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Material (
                      color: materialColor,
                      child: InkWell(
                        splashColor: cardTextColor,
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Text(clubArialViewsSwipe,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: cardTextColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                if (achievementsNotifier.achievementsList.isEmpty) ...[
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.85,
                            child: Lottie.asset(
                              'assets/json/searching.json',
                              // width: MediaQuery.of(context).size.width * 0.80,
                              height: 150,
                              fit: BoxFit.contain,
                            )
                        ),

                        Text(
                          "No Past Achievements Found",
                          style: TextStyle(
                            color: cardTextColor,
                          ),


                        )
                      ],
                    ),
                  )
                ]
                else ...[
                  SizedBox(
                    height: 340,
                    child: Swiper(
                      autoplay: true,
                      viewportFraction: 0.8,
                      scale: 0.9,
                      itemCount: achievementsNotifier.achievementsList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: <Widget>[
                            Container(
                              height: 250,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                  image: DecorationImage(
//                            colorFilter: ColorFilter.linearToSrgbGamma(),
                                    image: CachedNetworkImageProvider(
                                        achievementsNotifier.achievementsList[index].image!
                                    ),
                                    fit: BoxFit.cover,
                                  )
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                  color: cardColor
                              ),
                              child: ListTile(
                                title: Center(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      achievementsNotifier.achievementsList[index].toastName!,
                                      style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                      itemWidth: 350,
                      layout: SwiperLayout.STACK,
//                    pagination: SwiperPagination(),
                    ),
                  ),
                ],



                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 30, top: 20),
                  child: RichText(
                    text: TextSpan(
                      text: moreInfoAboutClub,
                      style: TextStyle(
                        fontSize: 17,
                        color: cardTextColor,
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.italic,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {
                        launch(moreInfoAboutClubURL);
                      }
                    ),
                  )
                ),

              ],
            ),
          ),
        );
      }
    );

  }
}

class ClubPlayerPopulation{
  String x;
  double y;
  ClubPlayerPopulation(this.x,this.y);
}

dynamic getPlayerPopulationData(){
  List<ClubPlayerPopulation> playerPopulationData = <ClubPlayerPopulation>[
    ClubPlayerPopulation('Attackers', attackingPlayersPopulation),
    ClubPlayerPopulation('Midfielders', midfieldingPlayersPopulation),
    ClubPlayerPopulation('Defenders', defendingPlayersPopulation),
    ClubPlayerPopulation('GoalKeepers', goalkeepingPlayersPopulation),
  ];
  return playerPopulationData;
}

class ClubPopulation{
  String x;
  double y;
  ClubPopulation(this.x,this.y);
}

dynamic getClubPopulationData(){
  List<ClubPopulation> clubPopulationData = <ClubPopulation>[
    ClubPopulation('Total Male Players', malePlayersPopulation),
    ClubPopulation('Total Female Players', femalePlayersPopulation),
    ClubPopulation('Coaching Staff', coachesPopulation),
    ClubPopulation('Non Coaching Staff', nonCoachesPopulation),
  ];
  return clubPopulationData;
}


bool toggle = false;
Map<String, double> clubMap = {};

Map<String, double> playerMap = {};

List<Color> clubColorList = [
  firstClubChartColor,
  secondClubChartColor,
  thirdClubChartColor,
  fourthClubChartColor,
];

List<Color> playerColorList = [
  firstPlayerChartColor,
  secondPlayerChartColor,
  thirdPlayerChartColor,
  fourthPlayerChartColor,
];