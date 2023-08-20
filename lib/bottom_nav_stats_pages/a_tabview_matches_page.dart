import 'package:coventry_phoenix_fc/bottom_nav_stats_pages/a_past_matches_page.dart';
import 'package:coventry_phoenix_fc/bottom_nav_stats_pages/a_upcoming_matches_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


String fixturesTitle = 'Fixtures';
String resultsTitle = 'Results';
String matchesTitle = 'Matches';

Color? backgroundColor = const Color.fromRGBO(34, 40, 49, 1);


class TabviewMatchesPage extends StatefulWidget {
  const TabviewMatchesPage({super.key});

  @override
  State<TabviewMatchesPage> createState() => TabviewMatchesPageState();
}

class TabviewMatchesPageState extends State<TabviewMatchesPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        bottom: TabBar(
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
