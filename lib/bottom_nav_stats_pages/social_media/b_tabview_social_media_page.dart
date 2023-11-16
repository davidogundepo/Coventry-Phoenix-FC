import 'package:flutter/services.dart';
import 'b_social_media_page.dart';
import 'b_youtube_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../main.dart';


String smTitle = 'Social Media';
String phoenixTitle = 'Phoenix';
String ytTitle = 'Youtube';

Color? backgroundColor = const Color.fromRGBO(34, 40, 49, 1);
Color? selectedTabColor = Colors.indigo[200];


class TabviewSocialMediaPage extends StatefulWidget {
  const TabviewSocialMediaPage({super.key});

  @override
  State<TabviewSocialMediaPage> createState() => TabviewSocialMediaPageState();
}

class TabviewSocialMediaPageState extends State<TabviewSocialMediaPage> with SingleTickerProviderStateMixin {
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
            smTitle,
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
            Tab(text: phoenixTitle),
            Tab(text: ytTitle),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MySocialMediaPage(),
          MyYouTubePage(),
        ],
      ),
    );
  }
}


Future navigateMyApp(context) async {
  Navigator.of(context).pop(false);
}