import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../api/coaching_staff_api.dart';
import '../../api/first_team_class_api.dart';
import '../../api/management_body_api.dart';
import '../../api/second_team_class_api.dart';
import '../../bloc_navigation_bloc/navigation_bloc.dart';
import 'package:provider/provider.dart';
import '../../notifier/all_club_members_notifier.dart';
import '../../notifier/coaching_staff_notifier.dart';
import '../../notifier/first_team_class_notifier.dart';
import '../../notifier/management_body_notifier.dart';
import '../../notifier/second_team_class_notifier.dart';

Color backgroundColor = const Color.fromRGBO(78, 80, 106, 1.0);
Color appBarBackgroundColor = const Color.fromRGBO(48, 50, 74, 1.0);
Color appBarArrowColor = const Color.fromRGBO(187, 192, 195, 1.0);
Color firstRowColor = const Color.fromRGBO(63, 66, 97, 1.0);
Color firstRowColorTwo = const Color.fromRGBO(237, 104, 72, 1.0);
Color secondRowColor = const Color.fromRGBO(40, 142, 133, 1.0);
Color secondRowColorTwo = const Color.fromRGBO(233, 66, 54, 1.0);
Color thirdRowColor = const Color.fromRGBO(48, 50, 74, 1.0);

class MyViewClubPopulationPage extends StatefulWidget {
  const MyViewClubPopulationPage({Key? key}) : super(key: key);

  @override
  State<MyViewClubPopulationPage> createState() => MyViewClubPopulationPageState();
}

class MyViewClubPopulationPageState extends State<MyViewClubPopulationPage> {
  int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Use the AllClubMembersNotifier to access the combined list of allClubMembers
    AllClubMembersNotifier allClubMembersNotifier = Provider.of<AllClubMembersNotifier>(context);

    // Calculate counts for Players, Coaches, and Managers
    int playersCount = allClubMembersNotifier.firstTeamClassList.length + allClubMembersNotifier.secondTeamClassList.length;
    int coachesCount = allClubMembersNotifier.coachesClassList.length;
    int managersCount = allClubMembersNotifier.mgmtBodyClassList.length;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: appBarBackgroundColor,
        title: const Text(
          'Club Population',
          style: TextStyle(color: Colors.white70),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: appBarArrowColor),
          onPressed: () {
            navigateMyApp(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            // First Row: Two containers for Players
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Container 1
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 20,
                  height: MediaQuery.of(context).size.width / 2 - 20,
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance.collection('SliversPages').doc('non_slivers_pages').snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }
                          return CachedNetworkImage(
                            imageUrl: snapshot.data?.data()!['club_icon'] ?? '',
                            width: MediaQuery.of(context).size.width / 4, // Adjust the width
                            height: MediaQuery.of(context).size.width / 4, // Adjust the height
                            placeholder: (context, url) => const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          );
                        }),
                  ),
                ),

                const SizedBox(width: 10),
                // Container 2
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 20,
                  height: MediaQuery.of(context).size.width / 2 - 20,
                  color: firstRowColorTwo,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Column(
                            children: [
                              Icon(
                                Icons.sports_soccer,
                                color: Colors.white,
                                size: 30,
                              ),
                              Text(
                                'Players',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '$playersCount',
                            style: const TextStyle(
                              fontSize: 40, // Adjust the font size
                              fontWeight: FontWeight.bold, // Make it bold
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Second Row: Two containers for Coaches and Managers
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Container 3
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 20,
                  height: MediaQuery.of(context).size.width / 2 - 20,
                  color: secondRowColor,
                  child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Column(children: [
                              Icon(
                                Icons.people,
                                color: Colors.white,
                                size: 30,
                              ),
                              Text(
                                'Coaches',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ]),
                            Text(
                              '$coachesCount',
                              style: const TextStyle(
                                fontSize: 40, // Adjust the font size
                                fontWeight: FontWeight.bold, // Make it bold
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
                const SizedBox(width: 10),
                // Container 4
                Container(
                    width: MediaQuery.of(context).size.width / 2 - 20,
                    height: MediaQuery.of(context).size.width / 2 - 20,
                    color: secondRowColorTwo,
                    child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Column(children: [
                                Icon(
                                  Icons.business,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                Text(
                                  'Managers',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ]),
                              Text(
                                '$managersCount',
                                style: const TextStyle(
                                  fontSize: 40, // Adjust the font size
                                  fontWeight: FontWeight.bold, // Make it bold
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ))),
              ],
            ),
            const SizedBox(height: 10),

            // Third Row: Biggest rectangle for the Pie Chart
            Container(
                width: MediaQuery.of(context).size.width - 30,
                height: MediaQuery.of(context).size.width - 80,
                color: thirdRowColor,
                child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {},
                      child: Center(
                        child: PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(
                              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                setState(() {
                                  if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
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
                    ))),
          ],
        ),
      ),
    );
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

  @override
  void initState() {
    super.initState();

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
  }
}

Future navigateMyApp(context) async {
  Navigator.of(context).pop(false);
}
