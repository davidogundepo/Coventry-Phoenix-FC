import 'dart:async';
import 'dart:io';
import 'package:coventry_phoenix_fc/api/club_sponsors_api.dart';
import 'package:coventry_phoenix_fc/bloc_navigation_bloc/navigation_bloc.dart';
import 'package:coventry_phoenix_fc/notifier/club_sponsors_notifier.dart';
import 'details_club_sponsors_page.dart';
import 'package:coventry_phoenix_fc/sidebar/sidebar_layout.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:photo_view/photo_view.dart';
import '../../model/club_sponsors.dart';

String exitAppStatement = "Exit from App";
String exitAppTitle = "Come on!";
String exitAppSubtitle = "Do you really really want to?";
String exitAppNo = "Oh No";
String exitAppYes = "I Have To";
String clubSponsorsTitle = "Club Sponsors";

Color splashColor = const Color.fromRGBO(98, 98, 213, 1.0);
Color textColor = const Color.fromRGBO(222, 214, 214, 1.0);
Color backgroundColor = const Color.fromRGBO(19, 20, 21, 1.0);
Color textColorTwo = const Color.fromRGBO(19, 20, 21, 1.0);
Color dialogBackgroundColor = const Color.fromRGBO(238, 235, 235, 1.0);

late ClubSponsorsNotifier clubSponsorsNotifier;

class MyClubSponsorsPage extends StatefulWidget with NavigationStates {
  MyClubSponsorsPage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  State<MyClubSponsorsPage> createState() => _MyClubSponsorsPageState();
}

class _MyClubSponsorsPageState extends State<MyClubSponsorsPage> with SingleTickerProviderStateMixin{

  late ClubSponsorsNotifier clubSponsorsNotifier;
  late AnimationController _animationController;
  late Animation<double> _zoomAnimation;
  int _currentIndex = 0;
  int _animationCount = 0; // Add a counter variable

  @override
  void initState() {
    super.initState();

    ClubSponsorsNotifier clubSponsorsNotifier = Provider.of<ClubSponsorsNotifier>(context, listen: false);
    getClubSponsors(clubSponsorsNotifier);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // Set the duration for zooming
    );

    _animationController.forward();
    _zoomAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    Timer.periodic(const Duration(seconds: 5), (_) {
      setState(() {
        _currentIndex++;

        // If _currentIndex exceeds the total number of images, reset it to 0
        if (_currentIndex == 5) {
          _currentIndex = 0;
        }
        _animationController.forward(from: 0.0);

        _animationCount++; // Increment the animation count

      });
    });
  }

  @override
  void didChangeDependencies() {
    ClubSponsorsNotifier clubSponsorsNotifier =
    Provider.of<ClubSponsorsNotifier>(context, listen: true);
    getClubSponsors(clubSponsorsNotifier);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildSponsorsItem(BuildContext context, int index) {
    clubSponsorsNotifier = Provider.of<ClubSponsorsNotifier>(context);

    final ClubSponsors sponsors = clubSponsorsNotifier.clubSponsorsList[index];

    final List<String?> imageUrls = [];
    if (sponsors.image != null) {
      imageUrls.add(sponsors.image);
    }
    if (sponsors.imageTwo != null) {
      imageUrls.add(sponsors.imageTwo);
    }
    if (sponsors.imageThree != null) {
      imageUrls.add(sponsors.imageThree);
    }
    if (sponsors.imageFour != null) {
      imageUrls.add(sponsors.imageFour);
    }
    if (sponsors.imageFive != null) {
      imageUrls.add(sponsors.imageFive);
    }

    return InkWell(
      splashColor: splashColor,
      onTap: () {
        clubSponsorsNotifier.currentClubSponsors = clubSponsorsNotifier.clubSponsorsList[index];
        navigateToClubSponsorsDetailsPage(context);
      },
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Stack(
                          children: [
                            for (int i = 0; i < imageUrls.length; i++)
                              AnimatedBuilder(
                                animation: _animationController,
                                builder: (context, child) {
                                  double zoomValue = 1.0;
                                  if (i == _currentIndex) {
                                    zoomValue = _zoomAnimation.value;
                                  }
                                  return Transform.scale(
                                    scale: zoomValue,
                                    child: Opacity(
                                      opacity: i == _currentIndex ? 1.0 : 0.0,
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: double.infinity,
                                        child: PhotoView(
                                          basePosition: const Alignment(0.1, -0.55),
                                          imageProvider: NetworkImage(imageUrls[i]!),
                                          loadingBuilder: (context, event) => const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          minScale: PhotoViewComputedScale.covered,
                                          maxScale: PhotoViewComputedScale.covered,
                                          initialScale: PhotoViewComputedScale.covered * 2,
                                          heroAttributes: PhotoViewHeroAttributes(tag: i.toString()),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16.0,
                    bottom: 16.0,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.black.withOpacity(0.65),
                      ),
                      child: Text(
                        clubSponsorsNotifier.clubSponsorsList[index].name!,
                        style: GoogleFonts.aldrich(
                          color: textColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    clubSponsorsNotifier = Provider.of<ClubSponsorsNotifier>(context);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        // appBar: AppBar(
        //   centerTitle: true,
        //   shape: const RoundedRectangleBorder(
        //     borderRadius: BorderRadius.vertical(
        //       bottom: Radius.circular(30),
        //     ),
        //   ),
        //   elevation: 10,
        //   backgroundColor: backgroundColor,
        //   leading: IconButton(
        //     icon: Icon(Icons.arrow_back_ios, color: whiteColor),
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        // ),
        body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: ListView.builder(
                  itemBuilder: _buildSponsorsItem,
                  itemCount: clubSponsorsNotifier.clubSponsorsList.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // navigateToHomePage(context);
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.black.withOpacity(0.65),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 5), // Add some spacing between the Icon and Text
                            Text(
                              'BACK',
                              style: GoogleFonts.aldrich(
                                color: textColor,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*.10,
                    ),
                    Text(
                      'List of Club Sponsors',
                      style: GoogleFonts.aldrich(
                        color: textColorTwo,
                        fontSize: 23,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              // Positioned for "List of Club Sponsors" text without decoration

            ],
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

}


Future navigateToClubSponsorsDetailsPage(context) async {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const ClubSponsorsDetailsPage()));
}
Future navigateToHomePage(context) async {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const SideBarLayout()));
}
