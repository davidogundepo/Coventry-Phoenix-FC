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
import '../bottom_nav_stats_pages/bottom_navigator.dart';
import '../thrown_searches/management_thrown_search.dart';
import '../api/management_body_api.dart';
import '../bloc_navigation_bloc/navigation_bloc.dart';
import '../details_pages/management_details_page.dart';
import '../notifier/management_body_notifier.dart';


String clubName = "Coventry Phoenix FC";
String thrownName = "Management";

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



Color backgroundColor = const Color.fromRGBO(238, 235, 235, 1.0);
Color appBarBackgroundColor = const Color.fromRGBO(238, 235, 235, 1.0);
Color appBarTextColor = const Color.fromRGBO(208, 104, 47, 1);
Color appBarIconColor = const Color.fromRGBO(208, 104, 47, 1);
Color modalColor = Colors.transparent;
Color modalBackgroundColor = const Color.fromRGBO(238, 235, 235, 1.0);
Color materialBackgroundColor = Colors.transparent;
Color cardBackgroundColor = const Color.fromRGBO(208, 104, 47, 1);
Color splashColor = const Color.fromRGBO(238, 235, 235, 1.0);
Color splashColorTwo = Colors.black87;
Color iconColor = const Color.fromRGBO(208, 104, 47, 1);
Color textColor = const Color.fromRGBO(208, 104, 47, 1.0);
Color textColorTwo = Colors.white70;
Color dialogBackgroundColor = const Color.fromRGBO(238, 235, 235, 1.0);
Color borderColor = Colors.black;

class MyManagementBodyPage extends StatefulWidget with NavigationStates{
  MyManagementBodyPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<MyManagementBodyPage> createState() => _MyManagementBodyPage();
}

class _MyManagementBodyPage extends State<MyManagementBodyPage> {

  Widget _buildProductItem(BuildContext context, int index) {
    ManagementBodyNotifier managementBodyNotifier = Provider.of<ManagementBodyNotifier>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),color: borderColor.withAlpha(50),
        ),

        child: Material(
          color: materialBackgroundColor,
          child: InkWell(
            splashColor: splashColor,
            onTap: () {
              managementBodyNotifier.currentManagementBody = managementBodyNotifier.managementBodyList[index];
              navigateToManagementBodyDetailsPage(context);
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
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                        image: DecorationImage(
                            alignment: const Alignment(0, -1),
                            image: CachedNetworkImageProvider(
                                managementBodyNotifier.managementBodyList[index].image!
                            ),
                            fit: BoxFit.cover
                        )
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
                              Text(
                                  managementBodyNotifier.managementBodyList[index].name!,
                                  style: GoogleFonts.tenorSans(
                                      color: textColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600
                                  )
                              ),
                              const SizedBox(width: 10),
                              Icon (
                                MdiIcons.shieldCheck,
                                color: iconColor,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                              managementBodyNotifier.managementBodyList[index].staffPosition!,
                              style: GoogleFonts.tenorSans(
                                  color: textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.italic
                              )
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
      ),
    );
  }

  Future<bool> _onWillPop() async{
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),

        ),
        backgroundColor: backgroundColor,
        title: Text(exitAppTitle,
          style: TextStyle(
              color: textColor
          ),
        ),
        content: Text(exitAppSubtitle,
          style: TextStyle(
              color: textColor
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(exitAppNo,
              style: TextStyle(
                  color: textColor
              ),
            ),
          ),
          TextButton(
            onPressed: () => exit(0),
            /*Navigator.of(context).pop(true)*/
            child: Text(exitAppYes,
              style: TextStyle(
                  color: textColor
              ),
            ),
          ),
        ],
      ),
    ) ??
        false;
  }

  Future navigateToManagementBodyDetailsPage(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ManagementBodyDetailsPage()));
  }

  Future navigateTablesAndStatsDetails(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const BottomNavigator()));
  }

  Future navigateToAboutAppDetailsPage(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutAppDetails()));
  }
  Future navigateToAcronymsMeaningsPage(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const AcronymsMeanings()));
  }
  Future navigateToAboutClubDetailsPage(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutClubDetails()));
  }
  Future navigateToWhoWeArePage(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const WhoWeAre()));
  }

  @override
  void initState() {
    ManagementBodyNotifier managementBodyNotifier = Provider.of<ManagementBodyNotifier>(context, listen: false);
    getManagementBody(managementBodyNotifier);
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

  }


  @override
  Widget build(BuildContext context) {
    ManagementBodyNotifier managementBodyNotifier = Provider.of<ManagementBodyNotifier>(context);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Container(
          color: backgroundColor,

          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context,
                bool innerBoxIsScrolled) {
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
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                              ),
                              child: Material(
                                color: materialBackgroundColor,
                                child: InkWell(
                                  splashColor: splashColorTwo,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0, bottom: 35.0, right: 8.0, left: 8.0),
                                    child: Wrap(
                                      children: <Widget>[
                                        ListTile(
                                            leading: Icon(MdiIcons.tableMultiple,
                                              color: iconColor,
                                            ),
                                            title: Text(tablesAndStats,
                                              style: GoogleFonts.zillaSlab(
                                                  color: textColor
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.of(context).pop(false);
                                              navigateTablesAndStatsDetails(context);
                                            }
                                        ),
                                        ListTile(
                                            leading: Icon(MdiIcons.atom,
                                            color: iconColor),
                                            title: Text(whoWeAre,
                                            style: GoogleFonts.zillaSlab(
                                              color: textColor
                                            ),),
                                            onTap: () {
                                              Navigator.of(context).pop(false);
                                              navigateToWhoWeArePage(context);
                                            }
                                        ),
                                        ListTile(
                                          leading: Icon(MdiIcons.accountGroup,
                                            color: iconColor),
                                          title: Text(aboutClub,
                                            style: GoogleFonts.zillaSlab(
                                                color: textColor
                                            ),),
                                          onTap: () {
                                              Navigator.of(context).pop(false);
                                              navigateToAboutClubDetailsPage(context);
                                          },
                                        ),
                                        ListTile(
                                            leading: Icon(MdiIcons.sortAlphabeticalAscending,
                                              color: iconColor),
                                            title: Text(acronymMeanings,
                                              style: GoogleFonts.zillaSlab(
                                                  color: textColor
                                              ),),
                                            onTap: () {
                                              Navigator.of(context).pop(false);
                                              navigateToAcronymsMeaningsPage(context);
                                            }
                                        ),
                                        ListTile(
                                          leading: Icon(MdiIcons.opacity,
                                            color: iconColor),
                                          title: Text(aboutApp,
                                            style: GoogleFonts.zillaSlab(
                                                color: textColor
                                            ),),
                                          onTap: () {
                                              Navigator.of(context).pop(false);
                                              navigateToAboutAppDetailsPage(context);
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
                      onPressed: (){
                        showSearch(
                          context: context,
                          delegate: MyManagementBodySearch(all: managementBodyNotifier.managementBodyList),
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
                              color: textColor,
                                fontSize: 26.0,
                                fontWeight: FontWeight.bold
                            )
                        ),
                      ),
                      background: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance.collection('SliversPages').doc('slivers_pages').snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }
                          return Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      snapshot.data?.data()!['slivers_page_6'],
                                    ),
                                    fit: BoxFit.cover
                                )
                            ),
                          );
                        },
                      )
                  ),
                ),
              ];
            },
            body: Padding(
              padding: const EdgeInsets.only(left: 25, right: 10),
              child: Container(
                margin: const EdgeInsets.only( bottom: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                ),
                child: ListView.builder(
                  itemBuilder: _buildProductItem,
                  itemCount: managementBodyNotifier.managementBodyList.length,

                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}
