import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coventry_phoenix_fc/about_menu_details_pages/about_club.dart';
import 'package:coventry_phoenix_fc/bottom_nav_stats_pages/matches_page/a_past_matches_page.dart';
import 'package:coventry_phoenix_fc/bottom_nav_stats_pages/matches_page/a_upcoming_matches_page.dart';
import 'package:coventry_phoenix_fc/bottom_nav_stats_pages/players_stats_info_page.dart';
import 'package:coventry_phoenix_fc/bottom_nav_stats_pages/players_table_page.dart';
import 'package:coventry_phoenix_fc/bottom_nav_stats_pages/social_media/b_youtube_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simple_icons/simple_icons.dart';
import '../bloc_navigation_bloc/navigation_bloc.dart';
import '../bottom_nav_stats_pages/bottom_navigator.dart';
import '../bottom_nav_stats_pages/matches_page/a_tabview_matches_page.dart';
import '../bottom_nav_stats_pages/social_media/b_tabview_social_media_page.dart';
import '../notifier/sidebar_notifier.dart';
import '../sidebar/menu_item.dart';

String clubName = "Coventry Phoenix FC";
String subtitle = "We breed elite players here";

String returningPlayersTitle = "Coventry Phoenix I";
String newPlayersTitle = "Coventry Phoenix II";
// String thirdTeamClassTitle = "Reserve Team Players";
String captainsTitle = "CPFC Captains";
String coachesTitle = "Coaching Staff";
String managementBodyTitle = "Management Body";
String sponsorsTitle = "Club Sponsors";
// String adminTitle = "Club Admin";

String aiStatsTitle = "Ask ChatGFA";

String exitAppStatement = "Exit from App";
String exitAppTitle = "Come on!";
String exitAppSubtitle = "Do you really really want to?";
String exitAppNo = "Oh No";
String exitAppYes = "I Have To";

String fmTitle = "CPFC More";
String ytTitle = "Youtube Page";
String aptTitle = "All Players Table";
String tppTitle = "Top Performing Players";
String pmTitle = "Past Matches";
String umTitle = "Upcoming Fixtures";
String cbTitle = "Club Background";

Color gradientColor = const Color.fromRGBO(24, 26, 36, 1.0);
Color gradientColorTwo = Colors.white;
Color gradientColorThree = const Color.fromRGBO(215, 71, 108, 1.0);
Color gradientColorFour = const Color.fromRGBO(255, 107, 53, 1.0);
Color linearGradientColor = const Color.fromRGBO(24, 26, 36, 1.0);
Color linearGradientColorTwo = const Color.fromRGBO(24, 26, 36, 1.0);
Color boxShadowColor = const Color.fromRGBO(24, 26, 36, 1.0);
Color dividerColor = Colors.white;
Color materialBackgroundColor = Colors.transparent;
Color shimmerBaseColor = Colors.white;
Color shimmerHighlightColor = Colors.white;
Color shapeDecorationTextColor = const Color.fromRGBO(24, 26, 36, 1.0);
Color containerBackgroundColor = const Color.fromRGBO(24, 26, 36, 1.0);
Color containerIconColor = Colors.white;
Color dialogBackgroundColor = const Color.fromRGBO(24, 26, 36, 1.0);
Color dialogTextColor = Colors.white;
Color splashColor = const Color.fromRGBO(24, 26, 36, 1.0);
Color splashColorTwo = Colors.white;
Color splashColorThree = Colors.white;
Color textColor = Colors.white;
Color textColorTwo = const Color.fromRGBO(24, 26, 36, 1.0);
Color textShadowColor = Colors.white;

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> with SingleTickerProviderStateMixin<SideBar> {
  int _currentNAVSelected = 0;
  bool _isClubSponsorsClicked = false; // New variable to track the "Club Sponsors" click

  _onSelected(int index) {
    if (index == 7 /**|| index == 8 */) {
      // Check if the selected item is "Club Sponsors"
      _isClubSponsorsClicked = true;
      // showToast("Club Sponsors Clicked"); // Show the toast message
    } else {
      _isClubSponsorsClicked = false;
    }
    setState(() => _currentNAVSelected = index);
  }

  late AnimationController _animationController;
  late StreamController<bool> isSidebarOpenedStreamController;
  late Stream<bool> isSidebarOpenedStream;
  late StreamSink<bool> isSidebarOpenedSink;
  final bool isSidebarOpened = true;
  final _animationDuration = const Duration(milliseconds: 500);

  Stream<DocumentSnapshot<Map<String, dynamic>>> getDataFromFirestore() {
    return FirebaseFirestore.instance.collection('SliversPages').doc('non_slivers_pages').snapshots();
  }

  @override
  void initState() {
    super.initState();

    getDataFromFirestore();

    _animationController = AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      Provider.of<SideBarNotifier>(context, listen: false).setIsOpened(false);
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      Provider.of<SideBarNotifier>(context, listen: false).setIsOpened(true);
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    var screeWidthLeft = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSidebarOpenedAsync) {
        return Visibility(
          visible: !_isClubSponsorsClicked, // Hide the sidebar when "Club Sponsors" is clicked,
          child: AnimatedPositioned(
            duration: _animationDuration,
            top: 0,
            bottom: 0,
            left: isSidebarOpenedAsync.data! ? -screeWidthLeft : 0,
            right: isSidebarOpenedAsync.data! ? screeWidthLeft - 55 : 0,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Card(
                    color: containerBackgroundColor,
                    elevation: 20,
                    margin: const EdgeInsets.all(0),
                    child: Align(
                      alignment: const Alignment(0, -1.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [gradientColor, gradientColor])),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: <Widget>[
                              const SizedBox(
                                height: 60,
                              ),
                              Stack(
                                children: <Widget>[
                                  Opacity(
                                    opacity: 0.7,
                                    child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                                      stream: getDataFromFirestore(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return const Center(child: CircularProgressIndicator());
                                        } else {
                                          return Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: MediaQuery.of(context).size.height * 0.4,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                alignment: const Alignment(0, -0.8),
                                                image: CachedNetworkImageProvider(
                                                  snapshot.data?.data()!['sidebar_page'],
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                              gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [linearGradientColor, linearGradientColorTwo.withAlpha(50)],
                                                stops: const [0.3, 1],
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: boxShadowColor,
                                                  blurRadius: 12,
                                                  offset: const Offset(3, 12),
                                                )
                                              ],
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Material(
                                              color: materialBackgroundColor,
                                              child: InkWell(
                                                splashColor: splashColor,
                                                onTap: () {},
                                                child: Align(
                                                  alignment: const Alignment(0, 0.9),
                                                  child: ListTile(
                                                    title: Text(
                                                      clubName.toUpperCase(),
                                                      style: GoogleFonts.gorditas(
                                                          color: textColor,
                                                          fontSize: 19,
                                                          fontWeight: FontWeight.w700,
                                                          shadows: <Shadow>[
                                                            Shadow(blurRadius: 50, color: textShadowColor, offset: Offset.fromDirection(100, 12))
                                                          ]),
                                                    ),
                                                    subtitle: Text(
                                                      subtitle,
                                                      style: GoogleFonts.varela(
                                                        color: textColor,
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Opacity(
                                        opacity: 0.6,
                                        child: Container(
                                          width: 140.0,
                                          height: 140.0,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle, image: DecorationImage(image: AssetImage('assets/images/cpfc_logo.jpeg'))),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              Divider(
                                height: 30,
                                thickness: 0.5,
                                color: dividerColor.withOpacity(0.3),
                                indent: 32,
                                endIndent: 32,
                              ),
                              Material(
                                color: _currentNAVSelected == 0 ? gradientColorTwo.withOpacity(0.3) : materialBackgroundColor,
                                child: InkWell(
                                  splashColor: splashColorThree,
                                  onTap: () {
                                    _onSelected(0);
                                    onIconPressed();
                                    BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.myFirstTeamClassPageClickedEvent);
                                  },
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: MenuItems(
                                      icon: MdiIcons.soccer,
                                      title: returningPlayersTitle,
                                    ),
                                  ),
                                ),
                              ),
                              Material(
                                color: _currentNAVSelected == 1 ? gradientColorTwo.withOpacity(0.3) : materialBackgroundColor,
                                child: InkWell(
                                  splashColor: splashColorThree,
                                  onTap: () {
                                    _onSelected(1);
                                    onIconPressed();
                                    BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.mySecondTeamClassPageClickedEvent);
                                  },
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: MenuItems(
                                      icon: MdiIcons.soccer,
                                      title: newPlayersTitle,
                                    ),
                                  ),
                                ),
                              ),
                              // Material(
                              //   color: _currentNAVSelected == 2 ? gradientColorTwo.withOpacity(0.3) : materialBackgroundColor,
                              //   child: InkWell(
                              //     splashColor: splashColorThree,
                              //     onTap: () {
                              //       _onSelected(2);
                              //       onIconPressed();
                              //       BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.myThirdTeamClassPageClickedEvent);
                              //     },
                              //     child: Align(
                              //       alignment: Alignment.centerLeft,
                              //       child: MenuItems(
                              //         icon: MdiIcons.soccer,
                              //         title: thirdTeamClassTitle,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              Material(
                                color: _currentNAVSelected == 3 ? gradientColorTwo.withOpacity(0.3) : materialBackgroundColor,
                                child: InkWell(
                                  splashColor: splashColorThree,
                                  onTap: () {
                                    _onSelected(3);
                                    onIconPressed();
                                    BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.myCaptainsPageClickedEvent);
                                  },
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: MenuItems(
                                      icon: MdiIcons.accountStar,
                                      title: captainsTitle,
                                    ),
                                  ),
                                ),
                              ),
                              Material(
                                color: _currentNAVSelected == 4 ? gradientColorTwo.withOpacity(0.3) : materialBackgroundColor,
                                child: InkWell(
                                  splashColor: splashColorThree,
                                  onTap: () {
                                    _onSelected(4);
                                    onIconPressed();
                                    BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.myCoachesPageClickedEvent);
                                  },
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: MenuItems(
                                      icon: MdiIcons.podiumSilver,
                                      title: coachesTitle,
                                    ),
                                  ),
                                ),
                              ),
                              Material(
                                color: _currentNAVSelected == 5 ? gradientColorTwo.withOpacity(0.3) : materialBackgroundColor,
                                child: InkWell(
                                  splashColor: splashColorThree,
                                  onTap: () {
                                    _onSelected(5);
                                    onIconPressed();
                                    BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.myManagementBodyPageClickedEvent);
                                  },
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: MenuItems(
                                      icon: MdiIcons.accountTie,
                                      title: managementBodyTitle,
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                height: 5,
                                thickness: 0.5,
                                color: dividerColor.withOpacity(0.3),
                                indent: 12,
                                endIndent: 15,
                              ),
                              Material(
                                color: _currentNAVSelected == 6 ? gradientColorTwo.withOpacity(0.3) : materialBackgroundColor,
                                child: InkWell(
                                  splashColor: splashColorThree,
                                  onTap: () {
                                    // _onSelected(7);
                                    // onIconPressed();
                                    // BlocProvider.of<NavigationBloc>(context).add(
                                    //     NavigationEvents
                                    //         .myClubSponsorsPageClickedEvent);

                                    showToast();
                                  },
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: MenuItems(icon: SimpleIcons.rubysinatra, title: aiStatsTitle, textColor: gradientColorFour),
                                  ),
                                ),
                              ),
                              Divider(
                                height: 5,
                                thickness: 0.5,
                                color: dividerColor.withOpacity(0.3),
                                indent: 12,
                                endIndent: 15,
                              ),
                              Material(
                                color: _currentNAVSelected == 7 ? gradientColorTwo.withOpacity(0.3) : materialBackgroundColor,
                                child: InkWell(
                                  splashColor: splashColorThree,
                                  onTap: () {
                                    _onSelected(7);
                                    onIconPressed();
                                    BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.myClubSponsorsPageClickedEvent);
                                  },
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: MenuItems(icon: SimpleIcons.icinga, title: sponsorsTitle, textColor: gradientColorThree),
                                  ),
                                ),
                              ),
                              Divider(
                                height: 5,
                                thickness: 0.5,
                                color: dividerColor.withOpacity(0.3),
                                indent: 12,
                                endIndent: 15,
                              ),
                              Theme(
                                  data: ThemeData.dark().copyWith(primaryColor: Colors.white),
                                  child: ExpansionTile(
                                      title: MenuItems(
                                        icon: SimpleIcons.mobxstatetree,
                                        title: fmTitle,
                                      ),
                                      children: <Widget>[
                                        Material(
                                          color: _currentNAVSelected == 8 ? containerBackgroundColor.withOpacity(0.3) : materialBackgroundColor,
                                          child: InkWell(
                                            splashColor: splashColorTwo,
                                            onTap: () {
                                              _onSelected(8);
                                              onIconPressed();
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => const BottomNavigator(mainPage: TabviewSocialMediaPage(), initialPage: 3),
                                                ),
                                              );
                                            },
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: MenuItems(
                                                icon: SimpleIcons.youtube,
                                                title: ytTitle,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Material(
                                          color: _currentNAVSelected == 9 ? containerBackgroundColor.withOpacity(0.3) : materialBackgroundColor,
                                          child: InkWell(
                                            splashColor: splashColorTwo,
                                            onTap: () {
                                              _onSelected(9);
                                              onIconPressed();
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => const BottomNavigator(mainPage: PlayersTablePage(), initialPage: 0),
                                                ),
                                              );
                                            },
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: MenuItems(
                                                icon: MdiIcons.accountGroup,
                                                title: aptTitle,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Material(
                                          color: _currentNAVSelected == 10 ? containerBackgroundColor.withOpacity(0.3) : materialBackgroundColor,
                                          child: InkWell(
                                            splashColor: splashColorTwo,
                                            onTap: () {
                                              _onSelected(10);
                                              onIconPressed();
                                              Navigator.push(
                                                           context,
                                                MaterialPageRoute(
                                                  builder: (context) => const BottomNavigator(mainPage: PlayersStatsAndInfoPage(), initialPage: 1),
                                                ),
                                              );
                                            },
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: MenuItems(
                                                icon: SimpleIcons.starz,
                                                title: tppTitle,
                                              ),
                                            ),
                                          ),
                                        ),

                                        // Material(
                                        //   color: _currentNAVSelected == 11 ? containerBackgroundColor.withOpacity(0.3) : materialBackgroundColor,
                                        //   child: InkWell(
                                        //     splashColor: splashColorTwo,
                                        //     onTap: () {
                                        //       _onSelected(11);
                                        //       onIconPressed();
                                        //       Navigator.push(
                                        //         context,
                                        //         MaterialPageRoute(
                                        //           builder: (context) => const BottomNavigator(mainPage: TabviewMatchesPage(initialPage: 0), initialPage: 2), // Set initialPage to 0 for 'Results'
                                        //         ),
                                        //       );
                                        //     },
                                        //     child: Align(
                                        //       alignment: Alignment.centerLeft,
                                        //       child: MenuItems(
                                        //         icon: SimpleIcons.strongswan,
                                        //         title: pmTitle,
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),

                                        Material(
                                          color: _currentNAVSelected == 12 ? containerBackgroundColor.withOpacity(0.3) : materialBackgroundColor,
                                          child: InkWell(
                                            splashColor: splashColorTwo,
                                            onTap: () {
                                              _onSelected(12);
                                              onIconPressed();
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => const BottomNavigator(mainPage: TabviewMatchesPage(initialPage: 1), initialPage: 2), // Set initialPage to 1 for 'Fixtures'
                                                ),
                                              );
                                            },
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: MenuItems(
                                                icon: SimpleIcons.googlecolab,
                                                title: umTitle,
                                              ),
                                            ),
                                          ),
                                        ),

                                        // Material(
                                        //   color: _currentNAVSelected == 13 ? containerBackgroundColor.withOpacity(0.3) : materialBackgroundColor,
                                        //   child: InkWell(
                                        //     splashColor: splashColorTwo,
                                        //     onTap: () {
                                        //       _onSelected(13);
                                        //       onIconPressed();
                                        //       Navigator.push(
                                        //         context,
                                        //         MaterialPageRoute(
                                        //           builder: (context) => const AboutClubDetails(),
                                        //         ),
                                        //       );
                                        //     },
                                        //     child: Align(
                                        //       alignment: Alignment.centerLeft,
                                        //       child: MenuItems(
                                        //         icon: MdiIcons.accountGroup,
                                        //         title: cbTitle,
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),

                                      ])),
                              // Material(
                              //   color: _currentNAVSelected == 8
                              //       ? gradientColorTwo.withOpacity(0.3)
                              //       : materialBackgroundColor,
                              //   child: InkWell(
                              //     splashColor: splashColorThree,
                              //     onTap: () {
                              //       _onSelected(8);
                              //       onIconPressed();
                              //       BlocProvider.of<NavigationBloc>(context).add(
                              //           NavigationEvents
                              //               .myClubAdminPageClickedEvent);
                              //     },
                              //     child: Align(
                              //       alignment: Alignment.centerLeft,
                              //       child: MenuItems(
                              //           icon: MdiIcons.security,
                              //           title: adminTitle,
                              //           textColor: gradientColorTwo
                              //       ),
                              //     ),
                              //   ),
                              // ),

                              Padding(
                                padding: const EdgeInsets.only(bottom: 50, top: 10),
                                child: Material(
                                  color: materialBackgroundColor,
                                  child: InkWell(
                                    splashColor: splashColorThree,
                                    onTap: () {
                                      _onWillPop();
                                      onIconPressed();
                                    },
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: MenuItems(
                                        icon: MdiIcons.logout,
                                        title: exitAppStatement,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: const Alignment(-0.1, -0.9),
                  child: GestureDetector(
                    onTap: () {
                      onIconPressed();
                    },
                    child: ClipPath(
                      clipper: CustomMenuClipper(),
                      child: Card(
                        elevation: 20,
                        margin: const EdgeInsets.all(0),
                        child: Container(
                          width: 35,
                          height: 110,
                          color: containerBackgroundColor,
                          alignment: Alignment.centerLeft,
                          child: AnimatedIcon(
                            progress: _animationController.view,
                            icon: _animationController.status == AnimationStatus.completed ? AnimatedIcons.menu_home : AnimatedIcons.close_menu,
                            color: containerIconColor,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<bool>? _onWillPop() async {
    //moves the screen up
    // if (Provider.of<SideBarNotifier>(context, listen: false).isOpened) {
    //   onIconPressed();
    //   return false;
    // }

    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            backgroundColor: dialogBackgroundColor,
            title: Text(
              exitAppTitle,
              style: TextStyle(color: dialogTextColor),
            ),
            content: Text(
              exitAppSubtitle,
              style: TextStyle(color: dialogTextColor),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  exitAppNo,
                  style: TextStyle(color: dialogTextColor),
                ),
              ),
              TextButton(
                onPressed: () => exit(0),
                child: Text(
                  exitAppYes,
                  style: TextStyle(color: dialogTextColor),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = materialBackgroundColor;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 10);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class CustomPILLCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomPILLCardShapePainter(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 24.0;

    var david = Paint();
    david.shader = ui.Gradient.linear(
        const Offset(0, 0), Offset(size.width, size.height), [HSLColor.fromColor(startColor).withLightness(0.8).toColor(), endColor]);

    var jesus = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    canvas.drawPath(jesus, david);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

void showToast() {
  Fluttertoast.showToast(
    msg: "Coming Soon  ⚽️💎💎",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.deepOrangeAccent,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
