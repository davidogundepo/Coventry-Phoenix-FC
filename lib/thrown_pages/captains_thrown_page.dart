import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:launch_review/launch_review.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../about_menu_details_pages/about_app.dart';
import '../about_menu_details_pages/about_club.dart';
import '../about_menu_details_pages/acronyms_meanings.dart';
import '../about_menu_details_pages/who_we_are.dart';
import '../api/club_captains_api.dart';
import '../bloc_navigation_bloc/navigation_bloc.dart';
import '../bottom_nav_stats_pages/bottom_navigator.dart';
import '../club_admin/club_admin_page.dart';
import '../details_pages/club_captains_details_page.dart';
import '../main.dart';
import '../notifier/club_captains_notifier.dart';
import 'club_sponsors_thrown_page.dart';
import '../thrown_searches/captains_thrown_search.dart';

String clubName = "Coventry Phoenix FC";
String thrownName = "CPFC Captains";

String exitAppStatement = "Exit from App";
String exitAppTitle = "Come on!";
String exitAppSubtitle = "Do you really really want to?";
String exitAppNo = "Oh No";
String exitAppYes = "I Have To";

String whoWeAre = "Who We Are";
String aboutClub = "About $clubName";
// String tablesAndStats = "Tables and Stats";
String clubAdmin = "Go to Club Admin";
String acronymMeanings = "Acronym Meanings";
String aboutApp = "About Developer";

String fabStats = "Stats";

Color backgroundColor = const Color.fromRGBO(56, 56, 60, 1);
Color appBarTextColor = Colors.white70;
Color appBarBackgroundColor = const Color.fromRGBO(56, 56, 60, 1);
Color appBarIconColor = Colors.white70;
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
Color nabColor = const Color.fromRGBO(56, 56, 60, 1);

class MyCaptainsPage extends StatefulWidget with NavigationStates {
  MyCaptainsPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<MyCaptainsPage> createState() => _MyCaptainsPage();
}

class _MyCaptainsPage extends State<MyCaptainsPage> {

  final TextEditingController bugController = TextEditingController();

  Widget _buildProductItem(BuildContext context, int index) {
    late CaptainsNotifier captainsNotifier =
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
              captainsNotifier.currentCaptains =
                  captainsNotifier.captainsList[index];
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
                                captainsNotifier.captainsList[index].image!),
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
                              Text(captainsNotifier.captainsList[index].name!,
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
                              captainsNotifier
                                  .captainsList[index].teamCaptaining!,
                              style: GoogleFonts.tenorSans(
                                  color: textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
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
              style: TextStyle(color: textColorTwo),
            ),
            content: Text(
              exitAppSubtitle,
              style: TextStyle(color: textColorTwo),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  exitAppNo,
                  style: TextStyle(color: textColorTwo),
                ),
              ),
              TextButton(
                onPressed: () => exit(0),
                child: Text(
                  exitAppYes,
                  style: TextStyle(color: textColorTwo),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future navigateToCaptainsDetailsPage(context) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const CaptainsDetailsPage()));
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


  void navigateToAppStore(context) async {
    LaunchReview.launch(
        androidAppId: 'com.icdatinnovations.coventry_phoenix_fc',
        iOSAppId: '1637554276'
    );
    Navigator.of(context).pop(false);
  }

  void openReportAppBugDialog(context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: const Color.fromRGBO(57, 62, 70, 1),
        title: const Text(
          'Enter the Bug found please',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: bugController,
              decoration: const InputDecoration(
                hintText: 'Describe the bug...',
                hintStyle: TextStyle(color: Colors.white70),
              ),
              style: const TextStyle(
                color: Colors.white70,
              ),
              maxLines: 2, // Allow multiple lines for bug description
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String bugDescription = bugController.text.trim();

                bugController.clear();

                // Check if bugDescription is not empty before storing
                if (bugDescription.isNotEmpty) {
                  // Store bug report in Firestore
                  await FirebaseFirestore.instance.collection('BugReports').add({
                    'bug_description': bugDescription,
                    'timestamp': FieldValue.serverTimestamp(),
                  });

                  Navigator.pop(context);
                  // You can add a toast or any other UI feedback for successful bug submission
                  Fluttertoast.showToast(
                    msg: 'Bug report submitted!',
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                  );
                } else {
                  // Show a toast for empty bug description
                  Fluttertoast.showToast(
                    msg: 'Please enter a bug description',
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAdminDialog(BuildContext context) {
    TextEditingController passcodeController = TextEditingController(); // Controller for the passcode TextField

    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: const Color.fromRGBO(57, 62, 70, 1),
        title: const Text(
          'Enter the passcode',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: passcodeController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Passcode',
                hintStyle: TextStyle(color: Colors.white70),
              ),
              style: TextStyle(
                  color: Colors.white70
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String enteredPasscode = passcodeController.text.trim();

                // Retrieve the stored passcode from Firestore
                DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
                    .collection('SliversPages') // Replace with your Firestore collection
                    .doc('non_slivers_pages') // Replace with your Firestore document
                    .get();

                String storedPasscode = snapshot.data()!['admin_passcode'] ?? '';

                // Check if the entered passcode matches the stored passcode
                if (enteredPasscode == storedPasscode) {
                  Navigator.pop(context);
                  _showAdminWelcomeToast();
                  Navigator.push(context, SlideTransition1(MyClubAdminPage()));
                } else {
                  // Show a toast for incorrect passcode
                  Fluttertoast.showToast(
                    msg: 'Incorrect passcode',
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAdminWelcomeToast() {
    Fluttertoast.showToast(
      msg: 'Welcome, Admin',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.blueAccent,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    CaptainsNotifier captainsNotifier =
        Provider.of<CaptainsNotifier>(context, listen: false);
    getCaptains(captainsNotifier);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CaptainsNotifier captainsNotifier = Provider.of<CaptainsNotifier>(context);

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
                      icon: Icon(MdiIcons.formatFloatLeft, color: iconColorTwo),
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
                                                  color: iconColorTwo,
                                                ),
                                                title: Text(
                                                  clubAdmin,
                                                  style: GoogleFonts.zillaSlab(
                                                      color: textColorTwo),
                                                ),
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .pop(false);
                                                  _showAdminDialog(context);
                                                }),
                                            // ListTile(
                                            //     leading: Icon(
                                            //       MdiIcons.atom,
                                            //       color: iconColorTwo,
                                            //     ),
                                            //     title: Text(
                                            //       whoWeAre,
                                            //       style: GoogleFonts.zillaSlab(
                                            //           color: textColorTwo),
                                            //     ),
                                            //     onTap: () {
                                            //       Navigator.of(context)
                                            //           .pop(false);
                                            //       navigateToWhoWeArePage(
                                            //           context);
                                            //     }),
                                            ListTile(
                                              leading: Icon(
                                                MdiIcons.accountGroup,
                                                color: iconColorTwo,
                                              ),
                                              title: Text(
                                                aboutClub,
                                                style: GoogleFonts.zillaSlab(
                                                    color: textColorTwo),
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
                                                  color: iconColorTwo,
                                                ),
                                                title: Text(
                                                  acronymMeanings,
                                                  style: GoogleFonts.zillaSlab(
                                                      color: textColorTwo),
                                                ),
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .pop(false);
                                                  navigateToAcronymsMeaningsPage(
                                                      context);
                                                }),
                                            ListTile(
                                              leading: Icon(
                                                MdiIcons.opacity,
                                                color: iconColorTwo,
                                              ),
                                              title: Text(
                                                aboutApp,
                                                style: GoogleFonts.zillaSlab(
                                                    color: textColorTwo),
                                              ),
                                              onTap: () {
                                                Navigator.of(context)
                                                    .pop(false);
                                                navigateToAboutAppDetailsPage(
                                                    context);
                                              },
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    navigateToAppStore(context);
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
                                                    child: Text(
                                                      'Give App Review',
                                                      style: GoogleFonts.quantico(
                                                        fontSize: 15,
                                                        fontStyle: FontStyle.italic,
                                                        fontWeight: FontWeight.w700,
                                                        color: Colors.deepOrangeAccent, // Change the color as needed
                                                        // decoration: TextDecoration.underline,
                                                        //   decorationColor: Colors.blueAccent,
                                                        //   decorationThickness: 2.0
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.of(context).pop(false);
                                                    openReportAppBugDialog(context);
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
                                                    child: Text(
                                                      'Report an App Bug',
                                                      style: GoogleFonts.quantico(
                                                        fontSize: 15,
                                                        fontStyle: FontStyle.italic,
                                                        fontWeight: FontWeight.w700,
                                                        color: Colors.deepOrangeAccent, // Change the color as needed
                                                        // decoration: TextDecoration.underline,
                                                        // decorationColor: textColor,
                                                        // decorationThickness: 2.0
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
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
                      icon: Icon(MdiIcons.magnify, color: iconColorTwo),
                      onPressed: () {
                        showSearch(
                          context: context,
                          delegate: MyCaptainsSearch(
                              all: captainsNotifier.captainsList),
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
                      title: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                            thrownName,
                            textAlign: TextAlign.start,
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
                          return ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.3), // Adjust the opacity as needed
                              BlendMode.darken,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        snapshot.data?.data()!['slivers_page_4'],
                                      ),
                                      fit: BoxFit.cover)),
                            ),
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
                  itemCount: captainsNotifier.captainsList.length,
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
            style: TextStyle(color: nabColor),
          ),
          icon: Icon(MdiIcons.alphaSBoxOutline, color: nabColor),
          splashColor: splashColorTwo,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
