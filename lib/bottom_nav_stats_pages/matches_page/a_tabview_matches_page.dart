import 'a_past_matches_page.dart';
import './a_upcoming_matches_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../main.dart';


String fixturesTitle = 'Fixtures';
String resultsTitle = 'Results';
String matchesTitle = 'Matches';

Color? backgroundColor = const Color.fromRGBO(34, 40, 49, 1);
Color? selectedTabColor = Colors.indigo[200];


class TabviewMatchesPage extends StatefulWidget {
  const TabviewMatchesPage({Key? key, required this.initialPage}) : super(key: key);

  final int initialPage;

  @override
  State<TabviewMatchesPage> createState() => TabviewMatchesPageState();
}

class TabviewMatchesPageState extends State<TabviewMatchesPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: widget.initialPage);
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
            matchesTitle,
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
            Tab(text: resultsTitle),
            Tab(text: fixturesTitle),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          PastMatchesPage(),
          UpcomingMatchesPage(),
        ],
      ),
    );
  }
}


Future navigateMyApp(context) async {
  Navigator.of(context).pop(false);
}