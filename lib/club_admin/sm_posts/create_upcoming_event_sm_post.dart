import 'dart:ui' as ui;
import 'dart:ui';
import 'dart:io';
import 'package:flutter_spinner_time_picker/flutter_spinner_time_picker.dart';
import 'package:image/image.dart' as img;
import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart' as esys;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../api/c_match_day_banner_for_location_api.dart';
import '../../bloc_navigation_bloc/navigation_bloc.dart';
import '../../notifier/c_match_day_banner_for_location_notifier.dart';

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

MatchDayBannerForLocationNotifier? matchDayBannerForLocationNotifier;

class ImageUrls {
  String lowResUrl;
  String highResUrl;

  ImageUrls({required this.lowResUrl, required this.highResUrl});
}

List<ImageUrls> recentImageUrls = [];

class CreateUpcomingEventSMPost extends StatefulWidget with NavigationStates {
  CreateUpcomingEventSMPost({super.key});

  @override
  State<CreateUpcomingEventSMPost> createState() => _CreateUpcomingEventSMPostState();
}

class _CreateUpcomingEventSMPostState extends State<CreateUpcomingEventSMPost> {


  String? selectedBannerLowResImageUrl;
  String? selectedBannerHighResImageUrl;


  GlobalKey _bannerContentKey = GlobalKey();

  // Define variables to store form input
  TextEditingController _eventNameController = TextEditingController();
  TextEditingController _eventSummaryController = TextEditingController();

  String formattedTimeA = '';
  String formattedTimeB = '';

  String? selectedLocation;
  String? selectedLocationPostCode;

  DateTime selectedDateA = DateTime(2023, 10, 31, 14, 15);
  DateTime selectedDateB = DateTime(2023, 10, 31, 14, 15);
  TimeOfDay selectedTimeA = const TimeOfDay(hour: 14, minute: 15);
  TimeOfDay selectedTimeB = const TimeOfDay(hour: 14, minute: 15);

  DateTime? date;
  TimeOfDay? timeA;
  TimeOfDay? timeB;

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

  // Create a GlobalKey for the form
  final _formKey = GlobalKey<FormState>();

  // Firebase Firestore instance
  final firestore = FirebaseFirestore.instance;

  // Implement a function to handle form submission
  _submitForm() async {
    if (_formKey.currentState!.validate()) {

      final firestore = FirebaseFirestore.instance;
      final eventName = _eventNameController.text;
      final eventSummary = _eventSummaryController.text;
      final day = getFormattedDate(selectedDateA).toUpperCase();
      final timeFrom = formattedTimeA;
      final timeTill = formattedTimeB;
      final time = '$timeFrom - $timeTill';
      final location = selectedLocation;
      final postCode = selectedLocationPostCode;
      String collectionName = 'EventBanners';
      Map<String, dynamic> data = {
        'id': '10',
        'day': 'day',
        'event_name': eventName,
        'event_summary': eventSummary,
        'location': 'location',
        'post_code': 'postCode',
        'time': 'time',
      };

      try {
        if (collectionName.isNotEmpty) {
          data['event_name'] = eventName;
          data['event_summary'] = eventSummary;
          data['day'] = day;
          data['time'] = time;
          data['location'] = location;
          data['post_code'] = postCode;

          // Add the new member if the name doesn't exist
          await firestore.collection(collectionName).add(data);

          _eventNameController.clear();
          _eventSummaryController.clear();

        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Unsupported role: $collectionName'),
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating event: $e'),
          ),
        );
      }
    }
  }

  Future<void> addDataToCollection(FirebaseFirestore firestore, String collectionName, Map<String, dynamic> data) async {
    await firestore.collection(collectionName).add(data);
  }

  @override
  Widget build(BuildContext context) {
    formattedTimeA = DateFormat.jm().format(selectedDateA); // Formats time in 12-hour format with AM/PM
    formattedTimeB = DateFormat.jm().format(selectedDateB); // Formats time in 12-hour format with AM/PM
    matchDayBannerForLocationNotifier = Provider.of<MatchDayBannerForLocationNotifier>(context);

    // Create a GlobalKey for the RepaintBoundary
    GlobalKey boundaryKey = GlobalKey();

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
          title: const Text('Create Upcoming Event'),
          titleTextStyle: TextStyle(color: textColor, fontSize: 20),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  cursorColor: Colors.white70,
                  style: GoogleFonts.cabin(color: textColor),
                  controller: _eventNameController,
                  decoration: InputDecoration(
                    labelText: 'Event Name',
                    labelStyle: const TextStyle(fontSize: 20, color: Colors.white70),
                    floatingLabelStyle: TextStyle(color: cardBackgroundColor),
                    hintText: "U18's Trials",
                    hintStyle: const TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter event title';
                    }
                    return null;
                  },
                  maxLength: 20,
                ),
                TextFormField(
                  cursorColor: Colors.white70,
                  style: GoogleFonts.cabin(color: textColor),
                  controller: _eventSummaryController,
                  decoration: InputDecoration(
                    labelText: 'Event Summary',
                    labelStyle: const TextStyle(fontSize: 20, color: Colors.white70),
                    floatingLabelStyle: TextStyle(color: cardBackgroundColor),
                    hintText: "Coventry Phoenix will be holding open trials for our new under 18s youth team",
                    hintStyle: const TextStyle(color: Colors.white70, fontSize: 13),
                    contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a summary';
                    }
                    return null;
                  },
                  minLines: 1,
                  maxLines: null,
                ),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width / 4.1,
                      height: MediaQuery.sizeOf(context).width / 4.1,
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

                            final newDateTime = DateTime(date!.year, date!.month, date!.day, selectedDateA.hour, selectedDateA.minute);

                            setState(() {
                              selectedDateA = newDateTime;
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
                                            fontSize: 12,
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
                                        getFormattedDate(selectedDateA).toUpperCase(),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.visible,
                                        style: TextStyle(
                                          color: materialBackgroundColor,
                                          fontSize: 12,
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
                        'AT',
                        style: TextStyle(fontSize: 25, color: textColorTwo, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                      ),
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width / 4.1,
                      height: MediaQuery.sizeOf(context).width / 4.1,
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
                                                fontSize: 11,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Icon(
                                            Icons.location_on,
                                            color: iconColor,
                                            size: 16,
                                          ),
                                          Text(
                                            selectedLocationPostCode!,
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.visible,
                                            style: TextStyle(
                                              color: materialBackgroundColor,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        'Select Location',
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.visible,
                                        style: TextStyle(
                                          color: materialBackgroundColor,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                if (selectedLocation == null)
                                  Column(
                                    children: [
                                      const SizedBox(height: 10),
                                      Icon(
                                        Icons.add_box_rounded,
                                        color: iconColor,
                                        size: 25,
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width / 4.1,
                      height: MediaQuery.sizeOf(context).width / 4.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: borderColor.withAlpha(20),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            timeA = await pickTimeA();
                            if (timeA == null) return;

                            final newDateTime = DateTime(selectedDateA.year, selectedDateA.month, selectedDateA.day, timeA!.hour, timeA!.minute);

                            setState(() {
                              selectedDateA = newDateTime;
                            });
                          },
                          splashColor: splashColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              timeA == null
                                  ? Column(
                                      children: [
                                        Text(
                                          'Select Time',
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.visible,
                                          style: TextStyle(
                                            color: materialBackgroundColor,
                                            fontSize: 12,
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
                              if (timeA != null)
                                Text(
                                  formattedTimeA,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        'TO',
                        style: TextStyle(fontSize: 25, color: textColorTwo, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                      ),
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width / 4.1,
                      height: MediaQuery.sizeOf(context).width / 4.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: borderColor.withAlpha(20),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            timeB = await pickTimeB();
                            if (timeB == null) return;

                            final newDateTime = DateTime(selectedDateB.year, selectedDateB.month, selectedDateB.day, timeB!.hour, timeB!.minute);

                            setState(() {
                              selectedDateB = newDateTime;
                            });
                          },
                          splashColor: splashColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              timeB == null
                                  ? Column(
                                      children: [
                                        Text(
                                          'Select Time',
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.visible,
                                          style: TextStyle(
                                            color: materialBackgroundColor,
                                            fontSize: 12,
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
                              if (timeB != null)
                                Text(
                                  formattedTimeB,
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
                const SizedBox(height: 60),
                ElevatedButton(
                  onPressed: () {
                    if (checkMissingSteps()) {
                      _showMissingStepsToast(); // Show toast if any step is missing
                    } else {
                      // Generate banner logic goes here when all steps are completed
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: backgroundColor,
                            content: RepaintBoundary(
                              key: boundaryKey,
                              child: AspectRatio(
                                aspectRatio: 1.0, // Make the content square
                                child: Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/cpfc_logo_back_blurred.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Stack(
                                    key: _bannerContentKey,
                                    children: [
                                      // Top text
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(left: 5, top: 19, right: 65),
                                              child: FittedBox(
                                                alignment: Alignment.center,
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  _eventNameController.text.toUpperCase(),
                                                  style: GoogleFonts.metrophobic(
                                                    color: Colors.yellow,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    shadows: [
                                                      const Shadow(
                                                        color: Colors.black,
                                                        offset: Offset(7, 3),
                                                        blurRadius: 3,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            Container(
                                              padding: const EdgeInsets.only(right: 6),
                                              margin: const EdgeInsets.only(left: 8, top: 3),
                                              child: Text(
                                                _eventSummaryController.text,
                                                textAlign: TextAlign.justify,
                                                maxLines: 4,
                                                overflow: TextOverflow.clip,
                                                style: GoogleFonts.metrophobic(
                                                  color: const Color.fromRGBO(199, 177, 153, 1.0),
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 12,
                                                  shadows: [
                                                    const Shadow(
                                                      color: Colors.black,
                                                      offset: Offset(2, 2),
                                                      blurRadius: 3,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Middle texts
                                      Align(
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const SizedBox(height: 40),
                                            Container(
                                              margin: const EdgeInsets.only(left: 5, top: 13),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "WHEN".toUpperCase(),
                                                    style: GoogleFonts.metrophobic(
                                                      color: Colors.red,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18,
                                                      shadows: [
                                                        const Shadow(
                                                          color: Colors.black,
                                                          offset: Offset(2, 2),
                                                          blurRadius: 3,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(width: 15),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        getFormattedDate(selectedDateA).toUpperCase(),
                                                        style: GoogleFonts.metrophobic(
                                                          color: const Color.fromRGBO(199, 177, 153, 1.0),
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 10,
                                                          shadows: [
                                                            const Shadow(
                                                              color: Colors.black,
                                                              offset: Offset(2, 2),
                                                              blurRadius: 3,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Text(
                                                        "$formattedTimeA - $formattedTimeB",
                                                        style: GoogleFonts.metrophobic(
                                                          color: Colors.yellow,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 8,
                                                          shadows: [
                                                            const Shadow(
                                                              color: Colors.black,
                                                              offset: Offset(2, 2),
                                                              blurRadius: 3,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Container(
                                              margin: const EdgeInsets.only(left: 5, top: 5, right: 5),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "WHERE".toUpperCase(),
                                                    style: GoogleFonts.metrophobic(
                                                      color: Colors.red,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18,
                                                      shadows: [
                                                        const Shadow(
                                                          color: Colors.black,
                                                          offset: Offset(2, 2),
                                                          blurRadius: 3,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        FittedBox(
                                                          child: Text(
                                                            selectedLocation!.toUpperCase(),
                                                            style: GoogleFonts.metrophobic(
                                                              color: const Color.fromRGBO(199, 177, 153, 1.0),
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 10,
                                                              shadows: [
                                                                const Shadow(
                                                                  color: Colors.black,
                                                                  offset: Offset(2, 2),
                                                                  blurRadius: 3,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          selectedLocationPostCode!,
                                                          style: GoogleFonts.metrophobic(
                                                            color: Colors.yellow,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 8,
                                                            shadows: [
                                                              const Shadow(
                                                                color: Colors.black,
                                                                offset: Offset(2, 2),
                                                                blurRadius: 3,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(top: 10),
                                              child: Text(
                                                "All are Welcome!".toUpperCase(),
                                                style: GoogleFonts.metrophobic(
                                                  color: const Color.fromRGBO(199, 177, 153, 1.0),
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 13,
                                                  shadows: [
                                                    const Shadow(
                                                      color: Colors.black,
                                                      offset: Offset(2, 2),
                                                      blurRadius: 3,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(left: 5, right: 5, top: 8, bottom: 5),
                                              child: Expanded(
                                                child: RichText(
                                                  maxLines: 2,
                                                  overflow: TextOverflow.clip,
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: "Please message us or contact Edwin Greaves on ".toUpperCase(),
                                                        style: GoogleFonts.metrophobic(
                                                          color: const Color.fromRGBO(199, 177, 153, 1.0),
                                                          fontWeight: FontWeight.w800,
                                                          fontSize: 11,
                                                          shadows: [
                                                            const Shadow(
                                                              color: Colors.black,
                                                              offset: Offset(2, 2),
                                                              blurRadius: 3,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: "07973370218".toUpperCase(),
                                                        style: GoogleFonts.metrophobic(
                                                          color: Colors.yellow,
                                                          fontWeight: FontWeight.w800,
                                                          fontSize: 9,
                                                          shadows: [
                                                            const Shadow(
                                                              color: Colors.black,
                                                              offset: Offset(2, 2),
                                                              blurRadius: 3,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
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
                                ),
                              ),
                            ),
                            title: Text(
                              'Share your Event'.toUpperCase(),
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white70),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  await _submitForm();
                                  _shareContent(boundaryKey);
                                  Fluttertoast.showToast(
                                    msg: 'Success! Generated',
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.deepOrangeAccent,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                },
                                child: const Text('Share', style: TextStyle(color: Colors.white70)),
                              ),
                            ],
                          );
                        },
                      );

                    }
                  },
                  child: const Text('View Event Design'),
                ),
              ],
            ),
          ),
        ));
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
    String fileNameLowRes = 'event_banner_low_$uniqueIdentifierLowRes.png';
    String fileNameHighRes = 'event_banner_high_$uniqueIdentifierHighRes.png';

    final metadata = SettableMetadata(
      contentType: 'image/png',
      contentDisposition: 'inline', // Set this to 'inline' to display the image in the browser
    );

    // Reference to the Firebase Storage paths with dynamic file names
    var storageRefLowRes = FirebaseStorage.instance.ref().child('event_banners/low_resolution/$fileNameLowRes');
    var storageRefHighRes = FirebaseStorage.instance.ref().child('event_banners/high_resolution/$fileNameHighRes');

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

  Future<DateTime?> pickDate() => showDatePicker(
      context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2100), barrierColor: backgroundColor);

  Future<TimeOfDay?> pickTimeA() => showSpinnerTimePicker(
    context,
    initTime: TimeOfDay(hour: selectedDateA.hour, minute: selectedDateA.minute),
    is24HourFormat: false,
  );

  Future<TimeOfDay?> pickTimeB() => showSpinnerTimePicker(
    context,
    initTime: TimeOfDay(hour: selectedDateB.hour, minute: selectedDateB.minute),
    is24HourFormat: false,
  );

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
    if (_eventNameController.text.isEmpty ||
        _eventSummaryController.text.isEmpty ||
        selectedLocation == null ||
        date == null ||
        timeA == null ||
        timeB == null) {
      return true; // Return true if any step is missing
    }
    return false; // Return false if all steps are completed
  }


  @override
  void initState() {
    MatchDayBannerForLocationNotifier matchDayBannerForLocationNotifier = Provider.of<MatchDayBannerForLocationNotifier>(context, listen: false);
    getMatchDayBannerForLocation(matchDayBannerForLocationNotifier);

    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
