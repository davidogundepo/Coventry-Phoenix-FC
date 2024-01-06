import 'package:coventry_phoenix_fc/bloc_navigation_bloc/navigation_bloc.dart';
import 'package:coventry_phoenix_fc/club_admin/others/modify_red_card/record_red_card_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../main.dart';
import 'display_red_card_history_page.dart';


Color conColor = const Color.fromRGBO(194, 194, 220, 1.0);
Color conColorTwo = const Color.fromRGBO(151, 147, 151, 1.0);
Color textColor = const Color.fromRGBO(222, 214, 214, 1.0);
Color whiteColor = const Color.fromRGBO(255, 253, 253, 1.0);
Color twitterColor = const Color.fromRGBO(36, 81, 149, 1.0);
Color instagramColor = const Color.fromRGBO(255, 255, 255, 1.0);
Color facebookColor = const Color.fromRGBO(43, 103, 195, 1.0);
Color snapchatColor = const Color.fromRGBO(222, 163, 36, 1.0);
Color youtubeColor = const Color.fromRGBO(220, 45, 45, 1.0);
Color websiteColor = const Color.fromRGBO(104, 79, 178, 1.0);
Color emailColor = const Color.fromRGBO(230, 45, 45, 1.0);
Color phoneColor = const Color.fromRGBO(20, 134, 46, 1.0);
Color backgroundColor = const Color.fromRGBO(37, 47, 60, 1.0);


String mcTitle = 'Record fined Players     🟥';
String acTitle = 'Choose fined Player';
String rcTitle = 'All Fined Players';

Color? selectedTabColor = Colors.indigo[200];

class TabviewRedCardPage extends StatefulWidget with NavigationStates{
  TabviewRedCardPage({super.key});

  @override
  State<TabviewRedCardPage> createState() => TabviewRedCardPageState();
}

class TabviewRedCardPageState extends State<TabviewRedCardPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
            mcTitle,
            style: GoogleFonts.cairo(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.white
            )
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: appBarIconColor),
          onPressed: () {
            navigateMyApp(context);
          },
        ),
        bottom: TabBar(
          labelColor: selectedTabColor,
          unselectedLabelColor: Colors.lightBlue,
          indicatorColor: Colors.white,
          controller: _tabController,
          tabs: [
            Tab(text: acTitle),
            Tab(text: rcTitle),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MyRecordRedCardPage(),
          MyDisplayRedCardHistoryPage(),
        ],
      ),
    );
  }
}


Future navigateMyApp(context) async {
  Navigator.of(context).pop(false);
}