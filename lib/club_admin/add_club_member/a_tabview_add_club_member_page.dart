import 'package:coventry_phoenix_fc/bloc_navigation_bloc/navigation_bloc.dart';
import 'package:coventry_phoenix_fc/club_admin/add_club_member/add_club_member_page.dart';
import 'package:coventry_phoenix_fc/club_admin/add_club_member/show_all_club_members_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../main.dart';


String acmTitle = 'Add Club Members';
String amTitle = 'Add New Member';
String ecmTitle = 'Current Members';

Color? backgroundColor = const Color.fromRGBO(34, 40, 49, 1);
Color? selectedTabColor = Colors.indigo[200];


class TabviewClubMemberPage extends StatefulWidget with NavigationStates{
  TabviewClubMemberPage({super.key});

  @override
  State<TabviewClubMemberPage> createState() => TabviewClubMemberPageState();
}

class TabviewClubMemberPageState extends State<TabviewClubMemberPage> with SingleTickerProviderStateMixin {
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
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
            acmTitle,
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
          unselectedLabelColor: Colors.orange,
          indicatorColor: Colors.white,
          controller: _tabController,
          tabs: [
            Tab(text: amTitle),
            Tab(text: ecmTitle),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MyAddClubMemberPage(),
          MyShowAllClubMemberPage(),
        ],
      ),
    );
  }
}


Future navigateMyApp(context) async {
  Navigator.of(context).pop(false);
}