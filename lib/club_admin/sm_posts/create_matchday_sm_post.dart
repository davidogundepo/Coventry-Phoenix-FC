import 'dart:ui' as ui;
import 'dart:ui';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image/image.dart' as img;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coventry_phoenix_fc/api/c_match_day_banner_for_club_api.dart';
import 'package:coventry_phoenix_fc/api/c_match_day_banner_for_club_opp_api.dart';
import 'package:coventry_phoenix_fc/api/c_match_day_banner_for_league_api.dart';
import 'package:coventry_phoenix_fc/api/c_match_day_banner_for_location_api.dart';
import 'package:coventry_phoenix_fc/bloc_navigation_bloc/navigation_bloc.dart';
import 'package:coventry_phoenix_fc/notifier/c_match_day_banner_for_club_notifier.dart';
import 'package:coventry_phoenix_fc/notifier/c_match_day_banner_for_club_opp_notifier.dart';
import 'package:coventry_phoenix_fc/notifier/c_match_day_banner_for_league_notifier.dart';
import 'package:coventry_phoenix_fc/notifier/c_match_day_banner_for_location_notifier.dart';
import 'package:coventry_phoenix_fc/notifier/club_sponsors_notifier.dart';
import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart' as esys;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../../api/club_sponsors_api.dart';

Color backgroundColor = const Color.fromRGBO(34, 36, 54, 1.0);
Color appBarTextColor = const Color.fromRGBO(255, 107, 53, 1.0);
Color appBarBackgroundColor = const Color.fromRGBO(34, 36, 54, 1.0);
Color appBarIconColor = const Color.fromRGBO(255, 255, 255, 1.0);
Color modalColor = Colors.transparent;
Color modalBackgroundColor = const Color.fromRGBO(33, 37, 41, 1.0);
Color materialBackgroundColor = Colors.white;
Color? cardBackgroundColor = const Color.fromRGBO(255, 107, 53, 1.0);
Color? cardBackgroundColorTwo = const Color.fromRGBO(27, 102, 68, 1.0);
Color splashColor = const Color.fromRGBO(197, 212, 225, 1.0);
Color splashColorTwo = const Color.fromRGBO(215, 145, 119, 1.0);
Color iconColor = const Color.fromRGBO(255, 107, 53, 1.0);
Color iconColorTwo = const Color.fromRGBO(132, 134, 157, 1.0);
Color textColor = Colors.white;
Color textColorTwo = Colors.white54;
Color textColorThree = const Color.fromRGBO(132, 134, 157, 1.0);
Color dialogBackgroundColor = const Color.fromRGBO(33, 37, 41, 1.0);
Color borderColor = materialBackgroundColor;

MatchDayBannerForClubNotifier? matchDayBannerForClubNotifier;
MatchDayBannerForClubOppNotifier? matchDayBannerForClubOppNotifier;
MatchDayBannerForLeagueNotifier? matchDayBannerForLeagueNotifier;
MatchDayBannerForLocationNotifier? matchDayBannerForLocationNotifier;

ClubSponsorsNotifier? clubSponsorsNotifier;

class ImageUrls {
  String lowResUrl;
  String highResUrl;

  ImageUrls({required this.lowResUrl, required this.highResUrl});
}

List<ImageUrls> recentImageUrls = [];

class CreateMatchDaySocialMediaPost extends StatefulWidget with NavigationStates {
  CreateMatchDaySocialMediaPost({Key? key}) : super(key: key);

  @override
  State<CreateMatchDaySocialMediaPost> createState() => CreateMatchDaySocialMediaPostState();
}

class CreateMatchDaySocialMediaPostState extends State<CreateMatchDaySocialMediaPost> {
  GlobalKey _bannerContentKey = GlobalKey();

  late List<bool> selectedSponsors;

  List<String> selectedSponsorNames = [];
  List<String> lastThreeSelectedTeamA = [];
  List<String> lastThreeSelectedTeamB = [];
  List<String> lastThreeSelectedLeagueNames = [];

  String? selectedTeamA = ''; // Store selected team A name
  String? selectedTeamB = ''; // Store selected team B name
  String? selectedLeague;
  String? selectedLocation;
  String? selectedLocationPostCode;
  String? selectedSponsorsString = '';
  String? selectedBannerLowResImageUrl;
  String? selectedBannerHighResImageUrl;
  String formattedTime = '';

  DateTime selectedDate = DateTime(2023, 10, 31, 2, 15);
  TimeOfDay selectedTime = const TimeOfDay(hour: 2, minute: 15);

  DateTime? date;
  TimeOfDay? time;

  String getFormattedDate(DateTime date) {
    String day = DateFormat('d').format(date);
    String suffix = getDaySuffix(int.parse(day));

    return DateFormat("EEEE d'$suffix' MMMM").format(date);
  }

  String getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  @override
  Widget build(BuildContext context) {
    matchDayBannerForClubNotifier = Provider.of<MatchDayBannerForClubNotifier>(context);

    matchDayBannerForClubOppNotifier = Provider.of<MatchDayBannerForClubOppNotifier>(context);

    matchDayBannerForLeagueNotifier = Provider.of<MatchDayBannerForLeagueNotifier>(context);

    matchDayBannerForLocationNotifier = Provider.of<MatchDayBannerForLocationNotifier>(context);

    clubSponsorsNotifier = Provider.of<ClubSponsorsNotifier>(context);

    final hour = selectedDate.hour.toString().padLeft(2, '0');
    final minute = selectedDate.minute.toString().padLeft(2, '0');

    formattedTime = DateFormat.jm().format(selectedDate); // Formats time in 12-hour format with AM/PM

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: appBarIconColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: appBarBackgroundColor,
        title: const Text('MatchDay Fixtures'),
        titleTextStyle: TextStyle(color: textColor, fontSize: 20),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width / 3.1,
                    height: MediaQuery.sizeOf(context).width / 3.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: borderColor.withAlpha(20),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          _showTeamASelectionDialog();
                        },
                        splashColor: splashColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            selectedTeamA!.isNotEmpty
                                ? Image.network(
                                    matchDayBannerForClubNotifier!.matchDayBannerForClubList
                                        .firstWhere((team) => team.clubName == selectedTeamA)
                                        .clubIcon!,
                                    width: 50,
                                    height: 50,
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 15),
                                      Icon(
                                        Icons.add_box_rounded,
                                        color: materialBackgroundColor,
                                        size: 30,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Select Home Team',
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.visible,
                                        style: TextStyle(
                                          color: materialBackgroundColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                selectedTeamA!,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.visible,
                                style: GoogleFonts.tenorSans(
                                  color: materialBackgroundColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Text(
                      'VS',
                      style: TextStyle(fontSize: 25, color: textColorTwo, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width / 3.1,
                    height: MediaQuery.sizeOf(context).width / 3.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: borderColor.withAlpha(20),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          _showTeamBSelectionDialog();
                        },
                        splashColor: splashColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            selectedTeamB!.isNotEmpty
                                ? Image.network(
                                    matchDayBannerForClubOppNotifier!.matchDayBannerForClubOppList
                                        .firstWhere((team) => team.clubName == selectedTeamB)
                                        .clubIcon!,
                                    width: 50,
                                    height: 50,
                                  )
                                : Column(
                                    children: [
                                      const SizedBox(height: 10),
                                      Icon(
                                        Icons.add_box_rounded,
                                        color: materialBackgroundColor,
                                        size: 30,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Select Away Team',
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.visible,
                                        style: TextStyle(
                                          color: materialBackgroundColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ), // Display team icon or '+' icon
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                selectedTeamB!,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.visible,
                                style: GoogleFonts.tenorSans(
                                  color: materialBackgroundColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(7),
                    width: MediaQuery.sizeOf(context).width / 3.1,
                    height: MediaQuery.sizeOf(context).width / 3.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: borderColor.withAlpha(20),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          _showLeagueSelectionDialog(); // Show dialog for league selection
                        },
                        splashColor: splashColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            selectedLeague != null
                                ? Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          selectedLeague!,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.visible,
                                          style: TextStyle(
                                            color: materialBackgroundColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Icon(
                                        Icons.sports_score_rounded,
                                        color: iconColor,
                                        size: 25,
                                      )
                                    ],
                                  )
                                : Icon(
                                    Icons.add_box_rounded,
                                    color: materialBackgroundColor,
                                    size: 30,
                                  ),
                            if (selectedLeague == null)
                              Text(
                                'Select League',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                  color: materialBackgroundColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'AT',
                      style: TextStyle(fontSize: 25, color: textColorTwo, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(7),
                    width: MediaQuery.sizeOf(context).width / 3.1,
                    height: MediaQuery.sizeOf(context).width / 3.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: borderColor.withAlpha(20),
                    ),
                    child: Center(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            _showLocationSelectionDialog(); // Show dialog for location selection
                          },
                          splashColor: splashColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              selectedLocation != null
                                  ? Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            selectedLocation!,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.visible,
                                            style: TextStyle(
                                              color: materialBackgroundColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Icon(
                                          Icons.location_on,
                                          color: iconColor,
                                          size: 25,
                                        ),
                                        Text(
                                          selectedLocationPostCode!,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.visible,
                                          style: TextStyle(
                                            color: materialBackgroundColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Icon(
                                      Icons.add_box_rounded,
                                      color: materialBackgroundColor,
                                      size: 30,
                                    ),
                              if (selectedLocation == null)
                                Text(
                                  'Select Location',
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.visible,
                                  style: TextStyle(
                                    color: materialBackgroundColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(7),
                    width: MediaQuery.sizeOf(context).width / 3.1,
                    height: MediaQuery.sizeOf(context).width / 3.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: borderColor.withAlpha(20),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () async {
                          date = await pickDate();
                          if (date == null) return;

                          final newDateTime = DateTime(date!.year, date!.month, date!.day, selectedDate.hour, selectedDate.minute);

                          setState(() {
                            selectedDate = newDateTime;
                          });
                        },
                        splashColor: splashColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            date == null
                                ? Column(
                                    children: [
                                      Text(
                                        'Select Date',
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.visible,
                                        style: TextStyle(
                                          color: materialBackgroundColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Icon(
                                        Icons.date_range_rounded,
                                        color: iconColor,
                                        size: 25,
                                      )
                                    ],
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      getFormattedDate(selectedDate).toUpperCase(),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.visible,
                                      style: TextStyle(
                                        color: materialBackgroundColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'BY',
                      style: TextStyle(fontSize: 25, color: textColorTwo, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(7),
                    width: MediaQuery.sizeOf(context).width / 3.1,
                    height: MediaQuery.sizeOf(context).width / 3.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: borderColor.withAlpha(20),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () async {
                          time = await pickTime();
                          if (time == null) return;

                          final newDateTime = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, time!.hour, time!.minute);

                          setState(() {
                            selectedDate = newDateTime;
                          });
                        },
                        splashColor: splashColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            time == null
                                ? Column(
                                    children: [
                                      Text(
                                        'Select Time',
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.visible,
                                        style: TextStyle(
                                          color: materialBackgroundColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Icon(
                                        Icons.date_range_rounded,
                                        color: iconColor,
                                        size: 25,
                                      )
                                    ],
                                  )
                                : Container(),
                            if (time != null)
                              Text(
                                formattedTime,
                                // '$hour:$minute',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                  color: materialBackgroundColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width / 3.1,
                    height: MediaQuery.sizeOf(context).width / 5.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: borderColor.withAlpha(20),
                    ),
                    child: InkWell(
                      onTap: () {
                        _showAndSelectSponsorsDialog();
                      },
                      splashColor: splashColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          selectedSponsorsString!.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Text(
                                    selectedSponsorsString!,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.visible,
                                    style: TextStyle(
                                      color: materialBackgroundColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Text(
                                    'Choose Sponsors',
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.visible,
                                    style: TextStyle(
                                      color: materialBackgroundColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                )
                        ],
                      ),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Container()),
                  Container(
                    width: MediaQuery.sizeOf(context).width / 2,
                    height: MediaQuery.sizeOf(context).width / 4.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: cardBackgroundColor,
                    ),
                    child: InkWell(
                      onTap: () {
                        if (checkMissingSteps()) {
                          _showMissingStepsToast(); // Show toast if any step is missing
                        } else {
                          // Generate banner logic goes here when all steps are completed

                          _showGeneratedBanner();
                        }
                      },
                      splashColor: splashColorTwo,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Generate Banner',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                              color: materialBackgroundColor,
                              fontSize: 17,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).width / 3.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: borderColor.withAlpha(20),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: recentImageUrls.isNotEmpty
                          ? recentImageUrls.map((imageUrls) {
                              return Stack(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width / 4,
                                    height: MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: borderColor.withAlpha(20),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        imageUrls.lowResUrl,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: -12,
                                    right: -12,
                                    child: IconButton(
                                      icon: const FaIcon(
                                        FontAwesomeIcons.circleMinus,
                                        color: Colors.red,
                                        size: 25,
                                      ),
                                      onPressed: () {
                                        // Show delete confirmation dialog
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor: modalBackgroundColor,
                                              title: const Text("Are you sure?", style: TextStyle(color: Colors.white70)),
                                              content: const Text("Do you want to delete this image?", style: TextStyle(color: Colors.white70)),
                                              actions: [
                                                TextButton(
                                                  child: const Text("Cancel", style: TextStyle(color: Colors.white70)),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: const Text("Yes", style: TextStyle(color: Colors.white70)),
                                                  onPressed: () async {
                                                    // Find the index of the imageUrls object in the list
                                                    int index = recentImageUrls.indexWhere(
                                                        (urls) => urls.lowResUrl == imageUrls.lowResUrl && urls.highResUrl == imageUrls.highResUrl);

                                                    // Check if the object was found
                                                    if (index != -1) {
                                                      // Delete the image from Firebase Storage for both low-res and high-res URLs
                                                      await FirebaseStorage.instance.refFromURL(imageUrls.lowResUrl).delete();
                                                      await FirebaseStorage.instance.refFromURL(imageUrls.highResUrl).delete();

                                                      // Remove the imageUrls object from the list
                                                      recentImageUrls.removeAt(index);

                                                      Navigator.of(context).pop(); // Close the dialog

                                                      // Update the UI to reflect the deletion
                                                      setState(() {});
                                                    }
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            }).toList()
                          : [
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 4,
                                    height: MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: borderColor.withAlpha(20),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.image_rounded,
                                          color: iconColorTwo,
                                          size: 40,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 4,
                                    height: MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: borderColor.withAlpha(20),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.image_rounded,
                                          color: iconColorTwo,
                                          size: 40,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 4,
                                    height: MediaQuery.of(context).size.width / 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: borderColor.withAlpha(20),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.image_rounded,
                                          color: iconColorTwo,
                                          size: 40,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: borderColor.withAlpha(20),
                        ),
                        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                          stream: FirebaseFirestore.instance.collection('SliversPages').doc('non_slivers_pages').snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const CircularProgressIndicator();
                            }
                            return Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        snapshot.data?.data()!['club_icon'] ?? 0,
                                      ),
                                      fit: BoxFit.cover)),
                            );
                          },
                        )),
                  ),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Container()),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width / 2,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // color: cardBackgroundColorTwo,
                        gradient: const LinearGradient(
                          colors: [Colors.red, Colors.blue], // Set your desired gradient colors
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          // _shareMultipleImages(highResImageUrls);
                        },
                        splashColor: splashColorTwo,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Publish Banner(s)',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                color: materialBackgroundColor,
                                fontSize: 17,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }

  Future<DateTime?> pickDate() => showDatePicker(
      context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2100), barrierColor: backgroundColor);

  Future<TimeOfDay?> pickTime() => showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: selectedDate.hour, minute: selectedDate.minute),
      );

  void _showTeamASelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: modalBackgroundColor,
          title: const Text('Select a Team', style: TextStyle(color: Colors.white70)),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: matchDayBannerForClubNotifier!.matchDayBannerForClubList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      selectedTeamA = matchDayBannerForClubNotifier!.matchDayBannerForClubList[index].clubName!;
                      // Rearrange list based on the latest selection
                      if (lastThreeSelectedTeamA.contains(selectedTeamA)) {
                        lastThreeSelectedTeamA.remove(selectedTeamA);
                      }
                      lastThreeSelectedTeamA.add(selectedTeamA!);
                      if (lastThreeSelectedTeamA.length > 3) {
                        lastThreeSelectedTeamA.removeAt(0); // Remove the oldest selection
                      }
                    });
                  },
                  title: Text(
                    matchDayBannerForClubNotifier!.matchDayBannerForClubList[index].clubName!,
                    style: const TextStyle(fontSize: 17, color: Colors.white70, fontWeight: FontWeight.w600),
                  ),
                  leading: Image.network(
                    matchDayBannerForClubNotifier!.matchDayBannerForClubList[index].clubIcon!,
                    width: 50,
                    height: 50,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _showTeamBSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: modalBackgroundColor,
          title: const Text(
            'Select a Team',
            style: TextStyle(color: Colors.white70),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: matchDayBannerForClubOppNotifier!.matchDayBannerForClubOppList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      selectedTeamB = matchDayBannerForClubOppNotifier!.matchDayBannerForClubOppList[index].clubName!;
                      // Rearrange list based on the latest selection
                      if (lastThreeSelectedTeamB.contains(selectedTeamB)) {
                        lastThreeSelectedTeamB.remove(selectedTeamB);
                      }
                      lastThreeSelectedTeamB.add(selectedTeamB!);
                      if (lastThreeSelectedTeamB.length > 3) {
                        lastThreeSelectedTeamB.removeAt(0); // Remove the oldest selection
                      }
                    });
                  },
                  title: Text(
                    matchDayBannerForClubOppNotifier!.matchDayBannerForClubOppList[index].clubName!,
                    style: const TextStyle(fontSize: 17, color: Colors.white70, fontWeight: FontWeight.w600),
                  ),
                  leading: Image.network(
                    matchDayBannerForClubOppNotifier!.matchDayBannerForClubOppList[index].clubIcon!,
                    width: 50,
                    height: 50,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _showLeagueSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: modalBackgroundColor,
          title: const Text(
            'Select a League',
            style: TextStyle(color: Colors.white70),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: matchDayBannerForLeagueNotifier!.matchDayBannerForLeagueList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      selectedLeague = matchDayBannerForLeagueNotifier!.matchDayBannerForLeagueList[index].league!;
                      // Rearrange list based on the latest selection
                      if (lastThreeSelectedLeagueNames.contains(selectedLeague)) {
                        lastThreeSelectedLeagueNames.remove(selectedLeague);
                      }
                      lastThreeSelectedLeagueNames.add(selectedLeague!);
                      if (lastThreeSelectedLeagueNames.length > 3) {
                        lastThreeSelectedLeagueNames.removeAt(0); // Remove the oldest selection
                      }
                    });
                  },
                  title: Text(
                    matchDayBannerForLeagueNotifier!.matchDayBannerForLeagueList[index].league!,
                    style: const TextStyle(fontSize: 17, color: Colors.white70, fontWeight: FontWeight.w600),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _showLocationSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: modalBackgroundColor,
          title: const Text(
            'Select a Location',
            style: TextStyle(color: Colors.white70),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: matchDayBannerForLocationNotifier!.matchDayBannerForLocationList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      selectedLocation = matchDayBannerForLocationNotifier!.matchDayBannerForLocationList[index].location!;
                      selectedLocationPostCode = matchDayBannerForLocationNotifier!.matchDayBannerForLocationList[index].postCode!;
                    });
                  },
                  title: Text(
                    matchDayBannerForLocationNotifier!.matchDayBannerForLocationList[index].location!,
                    style: const TextStyle(fontSize: 17, color: Colors.white70, fontWeight: FontWeight.w600),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _showAndSelectSponsorsDialog() async {
    await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: modalBackgroundColor,
            title: const Text(
              "Select Sponsor(s) [4 Max]",
              style: TextStyle(fontSize: 14, color: Colors.white70, fontWeight: FontWeight.w500),
            ),
            content: SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: double.maxFinite,
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: clubSponsorsNotifier!.clubSponsorsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CheckboxListTile(
                          activeColor: iconColor,
                          title: Text(
                            clubSponsorsNotifier!.clubSponsorsList[index].name!,
                            style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400),
                          ),
                          value: selectedSponsors[index],
                          onChanged: (bool? value) {
                            if (selectedSponsors.where((element) => element).length < 4 || value == false) {
                              setState(() {
                                selectedSponsors[index] = value!;
                              });
                            }
                          },
                          secondary: Image.network(
                            clubSponsorsNotifier!.clubSponsorsList[index].sponsorIcon!,
                            width: 30,
                            height: 30,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    '${selectedSponsors.where((element) => element).length}/${clubSponsorsNotifier!.clubSponsorsList.length} sponsors chosen',
                    style: const TextStyle(fontSize: 16, color: Colors.white70, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
              ),
              TextButton(
                onPressed: () {
                  int selectedCount = selectedSponsors.where((element) => element).length;
                  setState(() {
                    selectedSponsorsString = '$selectedCount/${clubSponsorsNotifier!.clubSponsorsList.length} sponsors chosen';
                    print('Selected Sponsors String: $selectedSponsorsString');
                  });
                  Navigator.of(context).pop(selectedCount);
                },
                child: const Text('Select', style: TextStyle(color: Colors.white70)),
              ),
            ],
          );
        }).then((selectedCount) {
      if (selectedCount != null) {
        // Clear the selected sponsor names list before populating it with new selections
        selectedSponsorNames.clear();

        // Populate the selected sponsor names list with the names of selected sponsors
        for (int i = 0; i < selectedSponsors.length; i++) {
          if (selectedSponsors[i]) {
            selectedSponsorNames.add(clubSponsorsNotifier!.clubSponsorsList[i].name!);
          }
          // Set the selectedSponsorsString to the number of selected sponsors
          setState(() {
            selectedSponsorsString = '${selectedSponsorNames.length}/${clubSponsorsNotifier!.clubSponsorsList.length} sponsors selected';
          });

          // Print the selected sponsor names for debugging (optional)
          // print('Selected Sponsor Names: $selectedSponsorNames');

          String matchDayInfo = """
⚽️ Match Day ⚽️                  
${lastThreeSelectedLeagueNames.isNotEmpty ? '🏆 ${lastThreeSelectedLeagueNames.last}' : ''}
${lastThreeSelectedTeamA.isNotEmpty ? lastThreeSelectedTeamA.last : ''} Vs 
${lastThreeSelectedTeamB.isNotEmpty ? lastThreeSelectedTeamB.last : ''}
${lastThreeSelectedLeagueNames.length >= 2 ? '🏆 ${lastThreeSelectedLeagueNames.elementAt(lastThreeSelectedLeagueNames.length - 2)}' : ''}
${lastThreeSelectedTeamA.length >= 2 ? lastThreeSelectedTeamA.elementAt(lastThreeSelectedTeamA.length - 2) : ''}
${lastThreeSelectedTeamB.length >= 2 ? ' Vs ${lastThreeSelectedTeamB.elementAt(lastThreeSelectedTeamB.length - 2)}' : ''}
${lastThreeSelectedLeagueNames.length >= 3 ? '🏆 ${lastThreeSelectedLeagueNames.elementAt(lastThreeSelectedLeagueNames.length - 3)}' : ''}
${lastThreeSelectedTeamA.length >= 3 ? lastThreeSelectedTeamA.elementAt(lastThreeSelectedTeamA.length - 3) : ''}
${lastThreeSelectedTeamB.length >= 3 ? ' Vs ${lastThreeSelectedTeamB.elementAt(lastThreeSelectedTeamB.length - 3)}' : ''}
${selectedSponsorNames.isNotEmpty ? 'We are proudly sponsored by ${selectedSponsorNames.join(', ')}' : ''}
    """.trim();

          print(matchDayInfo);


        }
      }
    });
  }

  void _showGeneratedBanner() async {
    // Create a GlobalKey for the RepaintBoundary
    GlobalKey boundaryKey = GlobalKey();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: modalBackgroundColor,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RepaintBoundary(
                  key: boundaryKey, // Set the key for RepaintBoundary,
                  child: Stack(
                    key: _bannerContentKey,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15), // Add top padding of 16 units
                        child: Image.asset(
                          'assets/images/cpfc_sm_banner.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 170,
                        left: 10,
                        width: 30,
                        height: 30,
                        child: Image.network(
                          matchDayBannerForClubNotifier!.matchDayBannerForClubList.firstWhere((team) => team.clubName == selectedTeamA).clubIcon!,
                        ),
                      ),
                      Positioned(
                        top: 170,
                        right: 12,
                        width: 27,
                        height: 27,
                        child: Image.network(
                          matchDayBannerForClubOppNotifier!.matchDayBannerForClubOppList
                              .firstWhere((team) => team.clubName == selectedTeamB)
                              .clubIcon!,
                        ),
                      ),
                      Positioned(
                        top: 176,
                        left: 45,
                        child: SizedBox(
                          width: 50,
                          height: calculateLineHeight(calculateFontSize(selectedTeamA!)),
                          child: Text(
                            selectedTeamA!.toUpperCase(),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.visible,
                            style: GoogleFonts.barlowCondensed(
                                color: Colors.black, fontSize: calculateFontSize(selectedTeamA), fontWeight: FontWeight.w600, height: 1),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 176,
                        right: 45,
                        child: SizedBox(
                          width: 67,
                          height: calculateLineHeight(calculateFontSize(selectedTeamB!)),
                          child: Text(
                            selectedTeamB!.toUpperCase(),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.visible,
                            style: GoogleFonts.barlowCondensed(
                                color: Colors.black, fontSize: calculateFontSize(selectedTeamB), fontWeight: FontWeight.w600, height: 1),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 52,
                        left: 97,
                        child: SizedBox(
                          width: 67,
                          child: Text(
                            formattedTime.toUpperCase(),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.visible,
                            style: GoogleFonts.barlowCondensed(color: Colors.black, fontSize: 8, fontWeight: FontWeight.w600, height: 1),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 239),
                          width: 90,
                          child: Text(
                            '@ ${selectedLocation!.toUpperCase()} - ${selectedLocationPostCode!.toUpperCase()}',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.clip,
                            style: GoogleFonts.barlowCondensed(
                                color: Colors.black, fontSize: calculateFontSizeTwo(selectedLocation), fontWeight: FontWeight.w600, height: 0.9),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 121,
                        left: 80,
                        child: SizedBox(
                          width: 99,
                          child: Text(
                            getFormattedDate(selectedDate).toUpperCase(),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.visible,
                            style: GoogleFonts.barlowCondensed(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w600, height: 1),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 80),
                          alignment: Alignment.center,
                          child: Center(
                            child: Text(
                              selectedLeague!.toUpperCase(),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.visible,
                              style: GoogleFonts.barlowCondensed(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600, height: 1),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 22,
                        left: 60,
                        child: Visibility(
                          visible: selectedSponsors.any((sponsorSelected) => sponsorSelected),
                          child: Container(
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Text(
                                  'Proudly Sponsored by: '.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.visible,
                                  style: GoogleFonts.barlowCondensed(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w600, height: 1),
                                ),
                                const SizedBox(width: 5), // Add some space between text and icons
                                // Display selected sponsor icons here
                                ...selectedSponsors
                                    .asMap()
                                    .entries
                                    .where((entry) => entry.value) // Filter selected sponsors
                                    .map(
                                      (entry) => Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 2),
                                    child: Image.network(
                                      clubSponsorsNotifier!.clubSponsorsList[entry.key].sponsorIcon!,
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                )
                                    .toList(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  // Capture the screenshot and share the content
                  _shareContent(boundaryKey);
                  Navigator.pop(context);
                  Fluttertoast.showToast(
                    msg: 'Success! Generated', // Show success message (you can replace it with actual banner generation logic)
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.deepOrangeAccent,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                },
                child: const Text("Generate", style: TextStyle(color: Colors.white70)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel", style: TextStyle(color: Colors.white70)),
              ),
            ],
          );
        });
  }

  Future<List<String>> _shareContent(GlobalKey boundaryKey) async {
    // Get the RenderObject from the RepaintBoundary using its key
    RenderRepaintBoundary boundary = boundaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    // Increase the pixelRatio for higher resolution
    double pixelRatio = 10.0; // You can adjust this value based on your needs
    ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);

    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? pngBytes = byteData?.buffer.asUint8List();

    // Generate unique identifiers for the image file names
    String uniqueIdentifierLowRes = DateTime.now().millisecondsSinceEpoch.toString(); // For low-resolution image
    String uniqueIdentifierHighRes = DateTime.now().millisecondsSinceEpoch.toString(); // For high-resolution image

    // Create dynamic file names for the images (e.g., banner_<timestamp>.png)
    String fileNameLowRes = 'banner_low_$uniqueIdentifierLowRes.png';
    String fileNameHighRes = 'banner_high_$uniqueIdentifierHighRes.png';

    final metadata = SettableMetadata(
      contentType: 'image/png',
      contentDisposition: 'inline', // Set this to 'inline' to display the image in the browser
    );

    // Reference to the Firebase Storage paths with dynamic file names
    var storageRefLowRes = FirebaseStorage.instance.ref().child('banners/low_resolution/$fileNameLowRes');
    var storageRefHighRes = FirebaseStorage.instance.ref().child('banners/high_resolution/$fileNameHighRes');

    // Compress the image for low-resolution version
    img.Image compressedImage = img.decodeImage(Uint8List.fromList(pngBytes!))!;
    compressedImage = img.copyResize(compressedImage, width: 200, height: 200);
    Uint8List compressedBytes = img.encodePng(compressedImage);

    // Upload the low-resolution image to Firebase Storage
    await storageRefLowRes.putData(compressedBytes, metadata);

    // Upload the original high-resolution image to Firebase Storage
    await storageRefHighRes.putData(pngBytes, metadata);

    // Get the download URLs of the uploaded images
    String lowResDownloadURL = await storageRefLowRes.getDownloadURL();
    String highResDownloadURL = await storageRefHighRes.getDownloadURL();

    // Create ImageUrls objects for low-resolution and high-resolution URLs
    ImageUrls imageUrls = ImageUrls(lowResUrl: lowResDownloadURL, highResUrl: highResDownloadURL);

    // Remove the previous instance of this imageUrls object from the list (if it exists)
    recentImageUrls.removeWhere((element) => element.lowResUrl == imageUrls.lowResUrl && element.highResUrl == imageUrls.highResUrl);

    // Insert the new imageUrls object at the beginning of the list
    recentImageUrls.insert(0, imageUrls);

    // Limit the list to store only the latest three images
    if (recentImageUrls.length > 3) {
      recentImageUrls.removeLast(); // Remove the oldest imageUrls object from the list
    }

    // Set the download URLs to the appropriate variables
    setState(() {
      selectedBannerLowResImageUrl = lowResDownloadURL;
      selectedBannerHighResImageUrl = highResDownloadURL;
    });

    // Return the high-resolution image URLs
    return [lowResDownloadURL, highResDownloadURL];
  }

  void _shareMultipleImages(List<String> highResImageUrls) async {
    List<Map<String, List<int>>> files = [];

    // Download the high-resolution images and create a list of files to share
    for (String imageUrl in highResImageUrls) {
      // Download the image as bytes (you need to implement this function)
      List<int> imageBytes = await _downloadImage(imageUrl);

      // Get the file name from the URL
      String fileName = imageUrl.split('/').last;

      // Determine the MIME type based on the file extension
      String mimeType = 'image/png'; // Change this according to your image format

      // Create a map for the current file and add it to the list
      files.add({fileName: imageBytes});
    }

    String matchDayInfo = """
      ⚽️ Match Day ⚽️                  
  
      🏆 $selectedLeague
  
      $selectedTeamA Vs 
      $selectedTeamB
       
      🏆 $selectedLeague
      
      $selectedTeamA Vs 
      $selectedTeamB Res 
      
      🏆 $selectedLeague 
      
      $selectedTeamA Vs 
      $selectedTeamB 
   
      ${selectedSponsorNames.isNotEmpty ? 'We are proudly sponsored by ${selectedSponsorNames.join(', ')}' : ''}
    """;

    print(matchDayInfo);

    // Share the high-resolution images
    await esys.Share.files(
      'Sponsor Information',
      files as Map<String, List<int>>,
      '*/*' as Set<String>, // You can specify specific MIME types here if necessary
      text: matchDayInfo,
    );
  }

  Future<List<int>> _downloadImage(String imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      // Get temporary directory to store the downloaded image
      final tempDir = await getTemporaryDirectory();

      // Write the image bytes to a file in the temporary directory
      File imageFile = File('${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.png');
      await imageFile.writeAsBytes(response.bodyBytes);

      // Read the image file as bytes and return
      List<int> imageBytes = await imageFile.readAsBytes();
      return imageBytes;
    } else {
      // Handle error (e.g., image download failed)
      throw Exception('Failed to load image');
    }
  }

  void _showMissingStepsToast() {
    Fluttertoast.showToast(
      msg: 'One or more steps are missing!',
      gravity: ToastGravity.BOTTOM,
      backgroundColor: cardBackgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  bool checkMissingSteps() {
    if (selectedTeamA!.isEmpty || selectedTeamB!.isEmpty || selectedLocation == null || selectedLeague == null || selectedSponsorsString!.isEmpty) {
      return true; // Return true if any step is missing
    }
    return false; // Return false if all steps are completed
  }

  double calculateFontSize(String? text) {
    if (text == null || text.isEmpty) {
      return 10.0; // Default font size
    }

    if (text.length <= 10) {
      return 13.0; // Font size for short text
    } else if (text.length <= 15) {
      return 11.0; // Font size for medium-length text
    } else if (text.length <= 20) {
      return 9.0; // Font size for medium-length text
    } else {
      return 8.0; // Font size for long text
    }
  }

  double calculateFontSizeTwo(String? text) {
    if (text == null || text.isEmpty) {
      return 10.0; // Default font size
    }

    if (text.length <= 10) {
      return 9.0; // Foont size for short text
    } else if (text.length <= 15) {
      return 9.0; // Font size for medium-length text
    } else if (text.length <= 20) {
      return 8.0; // Font size for medium-length text
    } else if (text.length <= 25) {
      return 7.0; // Font size for medium-length text
    } else {
      return 7.0; // Font size for long text
    }
  }

  double calculateLineHeight(double fontSize) {
    // Calculate line height based on font size
    return fontSize * 1.2; // You can adjust the multiplier as needed
  }

  double calculateLineWidth(double fontSize) {
    if (fontSize == 7) {
      return fontSize * 11.3;
    } else {
      return fontSize * 13.2;
    }
  }

  @override
  void initState() {
    MatchDayBannerForClubNotifier matchDayBannerForClubNotifier = Provider.of<MatchDayBannerForClubNotifier>(context, listen: false);

    MatchDayBannerForClubOppNotifier matchDayBannerForClubOppNotifier = Provider.of<MatchDayBannerForClubOppNotifier>(context, listen: false);

    MatchDayBannerForLeagueNotifier matchDayBannerForLeagueNotifier = Provider.of<MatchDayBannerForLeagueNotifier>(context, listen: false);

    MatchDayBannerForLocationNotifier matchDayBannerForLocationNotifier = Provider.of<MatchDayBannerForLocationNotifier>(context, listen: false);

    ClubSponsorsNotifier clubSponsorsNotifier = Provider.of<ClubSponsorsNotifier>(context, listen: false);

    // Initialize the selectedSponsors list with all false values
    selectedSponsors = List<bool>.generate(clubSponsorsNotifier.clubSponsorsList.length, (index) => false);

    getMatchDayBannerForClub(matchDayBannerForClubNotifier);
    getMatchDayBannerForClubOpp(matchDayBannerForClubOppNotifier);
    getMatchDayBannerForLeague(matchDayBannerForLeagueNotifier);
    getMatchDayBannerForLocation(matchDayBannerForLocationNotifier);

    getClubSponsors(clubSponsorsNotifier);

    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
