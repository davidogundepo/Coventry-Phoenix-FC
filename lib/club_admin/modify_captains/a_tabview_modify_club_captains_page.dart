import 'package:coventry_phoenix_fc/bloc_navigation_bloc/navigation_bloc.dart';
import 'package:flutter/services.dart';
import '../modify_captains/modify_add_club_captains_page.dart';
import '../modify_captains/modify_remove_club_captains_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../main.dart';


String mcTitle = 'Modify Captains';
String acTitle = 'Add Captains';
String rcTitle = 'Remove Captains';

Color? backgroundColor = const Color.fromRGBO(34, 40, 49, 1);
Color? selectedTabColor = Colors.indigo[200];


class TabviewCaptainsPage extends StatefulWidget with NavigationStates{
  TabviewCaptainsPage({super.key});

  @override
  State<TabviewCaptainsPage> createState() => TabviewCaptainsPageState();
}

class TabviewCaptainsPageState extends State<TabviewCaptainsPage> with SingleTickerProviderStateMixin {
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
            mcTitle,
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
            Tab(text: acTitle),
            Tab(text: rcTitle),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MyModifyAddClubCaptainsPage(),
          MyModifyRemoveClubCaptainsPage(),
        ],
      ),
    );
  }
}


Future navigateMyApp(context) async {
  Navigator.of(context).pop(false);
}