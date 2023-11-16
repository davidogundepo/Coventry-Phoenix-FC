import 'package:coventry_phoenix_fc/club_admin/modify_club_sponsors/add_club_sponsors_page.dart';
import 'package:coventry_phoenix_fc/club_admin/modify_club_sponsors/remove_club_sponsors_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc_navigation_bloc/navigation_bloc.dart';

String acsTitle = 'Modify Club Sponsors';
String ancsTitle = 'Add New Club Sponsor';
String rcsTitle = 'Remove Club Sponsor';

Color? selectedTabColor = Colors.black;

Color conColor = const Color.fromRGBO(194, 194, 220, 1.0);
Color conColorTwo = const Color.fromRGBO(151, 147, 151, 1.0);
Color whiteColor = const Color.fromRGBO(255, 253, 253, 1.0);
Color twitterColor = const Color.fromRGBO(36, 81, 149, 1.0);
Color appBarIconColor = const Color.fromRGBO(239, 239, 241, 1.0);
Color instagramColor = const Color.fromRGBO(255, 255, 255, 1.0);
Color facebookColor = const Color.fromRGBO(43, 103, 195, 1.0);
Color snapchatColor = const Color.fromRGBO(222, 163, 36, 1.0);
Color youtubeColor = const Color.fromRGBO(220, 45, 45, 1.0);
Color websiteColor = const Color.fromRGBO(104, 79, 178, 1.0);
Color emailColor = const Color.fromRGBO(230, 45, 45, 1.0);
Color phoneColor = const Color.fromRGBO(20, 134, 46, 1.0);
Color backgroundColor = const Color.fromRGBO(147, 165, 193, 1.0);

class TabviewClubSponsorsPage extends StatefulWidget with NavigationStates {
  TabviewClubSponsorsPage({super.key});

  @override
  State<TabviewClubSponsorsPage> createState() => _TabviewClubSponsorsPageState();
}

class _TabviewClubSponsorsPageState extends State<TabviewClubSponsorsPage> with SingleTickerProviderStateMixin {

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
      // backgrou?ndColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
            acsTitle,
            style: GoogleFonts.jura(
                fontSize: 23,
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
          unselectedLabelColor: Colors.white,
          indicatorColor: Colors.white,
          controller: _tabController,
          tabs: [
            Tab(text: ancsTitle),
            Tab(text: rcsTitle),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MyAddClubSponsorPage(),
          MyRemoveClubSponsorPage(),
        ],
      ),
    );
  }
}


Future navigateMyApp(context) async {
  Navigator.of(context).pop(false);
}