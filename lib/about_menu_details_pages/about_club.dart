import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api/achievement_images_api.dart';
import '../api/club_arial_images_api.dart';
import '../api/coaching_staff_api.dart';
import '../api/first_team_class_api.dart';
import '../api/management_body_api.dart';
import '../api/second_team_class_api.dart';
import '../notifier/achievement_images_notifier.dart';
import '../notifier/all_club_members_notifier.dart';
import '../notifier/club_arial_notifier.dart';
import '../notifier/coaching_staff_notifier.dart';
import '../notifier/first_team_class_notifier.dart';
import '../notifier/management_body_notifier.dart';
import '../notifier/second_team_class_notifier.dart';

String clubName = '';
String aboutClub = "About ${clubName ?? ''}";
String whyClub = "WHY ${clubName ?? ''}?".toUpperCase();

String visionSwipe = "Swipe left on 'OUR VISION STATEMENT'  >>>";
String visionTitle = "OUR VISION STATEMENT";
String missionTitle = "OUR MISSION STATEMENT";

String coreValues = "OUR CORE VALUES";

String populationChart = "$clubName Population Chart **";
String playerBody = "Player Body\n\n";

String playerPopulationChart = "$clubName Players Population Chart";

String trainingSessionSwipe = "Swipe up for all Training exercises offered";

String extraCurricularActs = "Extra-curricular Activities offered in $clubName\n\n";

String clubArialViewsSwipe = "Swipe left or right for more photos";
String clubArialViews = "Some Arial views of $clubName";
String clubAchievementsSwipe = "Swipe left or right for more photos";
String clubAchievements = "Some of our Past Achievements";
String moreInfoAboutClubURL = "https://twitter.com/";

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
Color firstRowColor = const Color.fromRGBO(63, 66, 97, 1.0);
Color firstRowColorTwo = const Color.fromRGBO(237, 104, 72, 1.0);
Color secondRowColor = const Color.fromRGBO(40, 142, 133, 1.0);
Color secondRowColorTwo = const Color.fromRGBO(233, 66, 54, 1.0);
Color thirdRowColor = const Color.fromRGBO(48, 50, 74, 1.0);

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

  int touchedIndex = 0;

  @override
  void initState() {
    Fluttertoast.showToast(
      msg: 'Please Note: Not fully updated', // Show success message (you can replace it with actual banner generation logic)
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0,
    );

    ClubArialNotifier clubArialNotifier = Provider.of<ClubArialNotifier>(context, listen: false);
    getClubArial(clubArialNotifier);

    AchievementsNotifier achievementsNotifier = Provider.of<AchievementsNotifier>(context, listen: false);
    getAchievements(achievementsNotifier);

    // Fetch data for the first and second teams using their notifiers
    FirstTeamClassNotifier firstTeamNotifier = Provider.of<FirstTeamClassNotifier>(context, listen: false);
    SecondTeamClassNotifier secondTeamNotifier = Provider.of<SecondTeamClassNotifier>(context, listen: false);
    CoachesNotifier coachesNotifier = Provider.of<CoachesNotifier>(context, listen: false);
    ManagementBodyNotifier managementBodyNotifier = Provider.of<ManagementBodyNotifier>(context, listen: false);

    // Use Future.wait to wait for data to be fetched before building the UI
    Future.wait<void>([
      getFirstTeamClass(firstTeamNotifier),
      getSecondTeamClass(secondTeamNotifier),
      getCoaches(coachesNotifier),
      getManagementBody(managementBodyNotifier),
    ]).then((_) {
      // Set the data after fetching
      AllClubMembersNotifier allClubMembersNotifier = Provider.of<AllClubMembersNotifier>(context, listen: false);
      allClubMembersNotifier.setFirstTeamAllClubMembers(firstTeamNotifier.firstTeamClassList);
      allClubMembersNotifier.setSecondTeamAllClubMembers(secondTeamNotifier.secondTeamClassList);
      allClubMembersNotifier.setCoaches(coachesNotifier.coachesList);
      allClubMembersNotifier.setMGMTBody(managementBodyNotifier.managementBodyList);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String collectionName = 'SliversPages';
    final String documentId = 'non_slivers_pages';

    AchievementsNotifier achievementsNotifier = Provider.of<AchievementsNotifier>(context);

    // Use the AllClubMembersNotifier to access the combined list of allClubMembers
    AllClubMembersNotifier allClubMembersNotifier = Provider.of<AllClubMembersNotifier>(context);

    // Calculate counts for Players, Coaches, and Managers
    int playersCount = allClubMembersNotifier.firstTeamClassList.length + allClubMembersNotifier.secondTeamClassList.length;
    int coachesCount = allClubMembersNotifier.coachesClassList.length;
    int managersCount = allClubMembersNotifier.mgmtBodyClassList.length;

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('AboutClub').doc('about_club_page').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else {
            clubName = snapshot.data!.data()!['club_name'];

            // Update whyClub after fetching clubName
            whyClub = "WHY ${clubName ?? ''}?".toUpperCase();
            aboutClub = "About ${clubName ?? ''}";
            populationChart = "$clubName Population Chart";
          }
          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              centerTitle: true,
              title: Text(aboutClub, style: TextStyle(color: appBarIconColor)),
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
                      decoration: BoxDecoration(color: boxDecorationColor.withAlpha(50), borderRadius: BorderRadius.circular(5)),
                      child: Material(
                        color: materialColor,
                        child: InkWell(
                          splashColor: cardTextColor,
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text(
                                visionSwipe,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: cardTextColor, fontSize: 13, fontWeight: FontWeight.bold),
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
                                    snapshot.data?.data()!['vision_statement'],
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(color: cardTextColor, fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
                                    snapshot.data?.data()!['mission_statement'],
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(color: cardTextColor, fontWeight: FontWeight.w400, fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
                                  child: Text(
                                    (snapshot.data?.data()!['core_values'] as String?)?.replaceAll(r'\n', '\n') ?? '',
                                    // textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: cardTextColor,
                                      fontSize: 20,
                                      // fontWeight: FontWeight.w400,
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
                                    (snapshot.data?.data()!['why_club'] as String?)?.replaceAll(r'\n', '\n') ?? '',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(color: cardTextColor, fontWeight: FontWeight.w400, fontSize: 16),
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
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: boxDecorationColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Material(
                        color: materialColor,
                        child: InkWell(
                          splashColor: cardTextColor,
                          onTap: () {
                            // Handle onTap event
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 15, bottom: 30, left: 10),
                                child: Text(
                                  populationChart,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: cardTextColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              IgnorePointer(
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  height: MediaQuery.of(context).size.width * 0.4,
                                  color: Colors.transparent,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        // Handle inner InkWell onTap event
                                      },
                                      child: PieChart(
                                        PieChartData(
                                          pieTouchData: PieTouchData(
                                            touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                              setState(() {
                                                if (!event.isInterestedForInteractions ||
                                                    pieTouchResponse == null ||
                                                    pieTouchResponse.touchedSection == null) {
                                                  touchedIndex = -1;
                                                  return;
                                                }
                                                touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                                              });
                                            },
                                          ),
                                          borderData: FlBorderData(
                                            show: false,
                                          ),
                                          sectionsSpace: 0,
                                          centerSpaceRadius: 0,
                                          sections: showingSections(playersCount, coachesCount, managersCount),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Players: $playersCount',
                                    style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Coaches: $coachesCount',
                                    style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Managers: $managersCount',
                                    style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(color: boxDecorationColor.withAlpha(50), borderRadius: BorderRadius.circular(5)),
                      child: Material(
                        color: materialColor,
                        child: InkWell(
                          splashColor: cardTextColor,
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text(
                                trainingSessionSwipe,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: cardTextColor, fontSize: 19, fontWeight: FontWeight.bold),
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
                      decoration: BoxDecoration(color: boxDecorationColor.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                      child: Material(
                        color: materialColor,
                        child: InkWell(
                          splashColor: cardTextColor,
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15, top: 15, left: 10, right: 10),
                            child: SingleChildScrollView(
                                child: Text((snapshot.data?.data()!['training_types'] as String?)?.replaceAll(r'\n', '\n') ?? '',
                                    style: TextStyle(
                                      color: cardTextColor,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w300,
                                    ))),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(color: boxDecorationColor.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                      child: Material(
                        color: materialColor,
                        child: InkWell(
                          splashColor: cardTextColor,
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15, top: 15, left: 10, right: 10),
                            child: SingleChildScrollView(
                              child: RichText(
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: extraCurricularActs,
                                        style: TextStyle(
                                          color: cardTextColor,
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    TextSpan(
                                        text: (snapshot.data?.data()!['ext_activities'] as String?)?.replaceAll(r'\n', '\n') ?? '',
                                        style: TextStyle(
                                          color: cardTextColor,
                                          fontSize: 19,
                                          fontWeight: FontWeight.w300,
                                        )),
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
                    child: Text(
                      clubAchievements,
                      style: TextStyle(fontSize: 20, color: cardTextColor, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(color: boxDecorationColor.withAlpha(50), borderRadius: BorderRadius.circular(5)),
                      child: Material(
                        color: materialColor,
                        child: InkWell(
                          splashColor: cardTextColor,
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text(
                                clubArialViewsSwipe,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: cardTextColor, fontSize: 15, fontWeight: FontWeight.bold),
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
                              )),
                          Text(
                            "No Past Achievements Found",
                            style: TextStyle(
                              color: cardTextColor,
                            ),
                          )
                        ],
                      ),
                    )
                  ] else ...[
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
                                      // colorFilter: const ColorFilter.linearToSrgbGamma(),
                                      image: CachedNetworkImageProvider(achievementsNotifier.achievementsList[index].image!),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                    color: cardColor),
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

                  StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance.collection(collectionName).doc(documentId).snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      var data = snapshot.data?.data() as Map<String, dynamic>?;

                      // Access the 'twitter' field from the document
                      var twitterField = data?['twitter_handle'];

                      return Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 30, top: 20),
                        child: RichText(
                          text: TextSpan(
                            text: 'More info about the club: Coventry Phoenix FC',
                            style: TextStyle(
                              fontSize: 15,
                              color: cardTextColor, // Change color as needed
                              fontWeight: FontWeight.w800,
                              fontStyle: FontStyle.italic,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Handle URL launch here
                                launchURL(moreInfoAboutClubURL + twitterField);
                              },
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Future launchURL(String url) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text("The required app is not installed.")),
      );
    }
  }

  List<PieChartSectionData> showingSections(int playersCount, int coachesCount, int managersCount) {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? MediaQuery.of(context).size.width * 0.35 : MediaQuery.of(context).size.width * 0.35 - 20;
      // final widgetSize = isTouched ? 55.0 : 40.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.deepOrangeAccent,
            value: playersCount.toDouble(),
            title: 'Players',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.red,
            value: coachesCount.toDouble(),
            title: 'Coaches',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.teal,
            value: managersCount.toDouble(),
            title: 'Managers',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
          );
        default:
          throw Exception('Oh no');
      }
    });
  }
}
