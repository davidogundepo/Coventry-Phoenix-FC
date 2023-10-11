import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coventry_phoenix_fc/api/club_sponsors_api.dart';
import 'package:coventry_phoenix_fc/notifier/a_upcoming_matches_notifier.dart';
import 'package:coventry_phoenix_fc/notifier/club_sponsors_notifier.dart';
import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../api/a_upcoming_matches_api.dart';
import '../../model/club_sponsors.dart';

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
Color backgroundColor = const Color.fromRGBO(19, 20, 21, 1.0);

String callFIRST = "tel:+44";
String smsFIRST = "sms:+44";
String whatsAppFIRST = "https://api.whatsapp.com/send?phone=+44";
String whatsAppSECOND = "&text=Hello%20";
String whatsAppTHIRD = ",%20How%20are%20you%20doing%20today?";
String mailFIRST = "mailto:";
String mailSECOND = "?subject=Hello ";
String urlTwitter = "https://twitter.com/";
String urlFacebook = "https://facebook.com/";
String urlYoutube = "https://youtube.com/";
String urlWebsite = "https://youtube.com/";
String urlInstagram = "https://www.instagram.com/";
String urlSnapchat = "https://www.snapchat.com/add/";

String callButton = "Call Us";
String whatsAppButton = "WhatsApp Us";
String emailButton = "Email Us";
String twitterButton = "Our Twitter";
String instagramButton = "Our Instagram";
String facebookButton = "Our Facebook";
String youtubeButton = "Our Youtube";
String websiteButton = "Our Website";
String snapchatButton = "Our Snapchat";

String reachUsTitle = "Reach Us";
String ourServicesTitle = "Our Services";
String addressTitle = "Our Location:";
String categoryTitle = "Category:";

String facebookProfileSharedPreferencesTitle = "Manual Website Search";
String facebookProfileSharedPreferencesContentOne =
    "Apparently, you'd need to search manually for ";
String facebookProfileSharedPreferencesContentTwo = ", on Facebook.com";
String facebookProfileSharedPreferencesButton = "Go to Facebook";
String facebookProfileSharedPreferencesButtonTwo = "Lol, No";

dynamic _name;
dynamic _phone;
dynamic _email;
dynamic _twitter;
dynamic _instagram;
dynamic _facebook;
dynamic _youtube;
dynamic _website;
dynamic _snapchat;
dynamic _aboutUs;
dynamic _ourServices;

dynamic _homeTeamIcon;
dynamic _awayTeamIcon;
dynamic _homeTeam;
dynamic _awayTeam;
dynamic _matchDate;
dynamic _matchDayKickOff;
dynamic _venue;

late ClubSponsorsNotifier clubSponsorsNotifier;
late UpcomingMatchesNotifier upcomingMatchesNotifier;

class ClubSponsorsDetailsPage extends StatefulWidget {
  const ClubSponsorsDetailsPage({Key? key}) : super(key: key);

  @override
  State<ClubSponsorsDetailsPage> createState() =>
      _ClubSponsorsDetailsPageState();
}

class _ClubSponsorsDetailsPageState extends State<ClubSponsorsDetailsPage> {

  GlobalKey _contentKey = GlobalKey();

  Future launchURL(String url) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    if (await canLaunch(Uri.parse(url) as String)) {
      await launch(Uri.parse(url) as String);
    } else {
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text("The required app is not installed.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    clubSponsorsNotifier =
        Provider.of<ClubSponsorsNotifier>(context, listen: true);
    upcomingMatchesNotifier = Provider.of<UpcomingMatchesNotifier>(context);

    // _homeTeamIcon = upcomingMatchesNotifier.currentUpcomingMatches.homeTeamIcon;
    // _awayTeamIcon = upcomingMatchesNotifier.currentUpcomingMatches.awayTeamIcon;
    // _homeTeam = upcomingMatchesNotifier.currentUpcomingMatches.homeTeam;
    // _awayTeam = upcomingMatchesNotifier.currentUpcomingMatches.awayTeam;
    // _matchDate = upcomingMatchesNotifier.currentUpcomingMatches.matchDate;
    // _matchDayKickOff = upcomingMatchesNotifier.currentUpcomingMatches.matchDayKickOff;
    // _venue = upcomingMatchesNotifier.currentUpcomingMatches.venue;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        elevation: 10,
        backgroundColor: backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: whiteColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.upload),
            onPressed: () {
              _showUploadDialog();
            },
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Stack(
              children: [
                Container(
                  width: width,
                  // height: height/0.8,
                  decoration: BoxDecoration(
                      color: conColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: width / 2.7,
                              height: width / 2.7,
                              decoration: BoxDecoration(
                                color: conColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Center(
                                child: Container(
                                  width: width / 3,
                                  height: width / 3,
                                  decoration: BoxDecoration(
                                    color: conColorTwo.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(14),
                                    image: DecorationImage(
                                      image: NetworkImage(clubSponsorsNotifier
                                          .currentClubSponsors.image!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SizedBox(
                              width: width / 2.7,
                              height: width / 2.7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    clubSponsorsNotifier
                                        .currentClubSponsors.name!,
                                    style: GoogleFonts.aldrich(
                                      color: textColor,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    '$addressTitle ${clubSponsorsNotifier.currentClubSponsors.address!}',
                                    style: GoogleFonts.aldrich(
                                      color: textColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    '$categoryTitle ${clubSponsorsNotifier.currentClubSponsors.category!}',
                                    style: GoogleFonts.aldrich(
                                      color: textColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: width / 1.29,
                              decoration: BoxDecoration(
                                color: conColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text.rich(
                                      textAlign: TextAlign.justify,
                                      TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: '$reachUsTitle\n',
                                              style: GoogleFonts.aBeeZee(
                                                color: textColor,
                                                fontSize: 19,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ],
                                      ),
                                    ),
                                    Wrap(
                                      runAlignment: WrapAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      alignment: WrapAlignment.spaceBetween,
                                      spacing: 8,
                                      children: [
                                        Visibility(
                                          visible: _phone.isNotEmpty,
                                          child: OutlinedButton.icon(
                                            onPressed: () {
                                              if (_phone
                                                  .toString()
                                                  .startsWith('0')) {
                                                var most = _phone
                                                    .toString()
                                                    .substring(1);
                                                launchURL(callFIRST + most);
                                              } else {
                                                launchURL(callFIRST + _phone);
                                              }
                                            },
                                            style: OutlinedButton.styleFrom(
                                              foregroundColor: phoneColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              side: BorderSide(
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                                width: 2.0,
                                              ),
                                            ),
                                            icon: Icon(
                                              MdiIcons.phoneDial,
                                              size: 17,
                                              color: whiteColor,
                                            ),
                                            label: Text(
                                              callButton,
                                              style: GoogleFonts.raleway(
                                                color: textColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: _phone.isNotEmpty,
                                          child: OutlinedButton.icon(
                                            onPressed: () {
                                              if (_phone
                                                  .toString()
                                                  .startsWith('0')) {
                                                var most = _phone
                                                    .toString()
                                                    .substring(1);
                                                var firstName = _name
                                                    .toString()
                                                    .substring(
                                                        0,
                                                        _name
                                                            .toString()
                                                            .indexOf(" "));
                                                launchURL(whatsAppFIRST +
                                                    most +
                                                    whatsAppSECOND +
                                                    firstName +
                                                    whatsAppTHIRD);
                                                launchURL(whatsAppFIRST + most);
                                              } else {
                                                var firstName = _name
                                                    .toString()
                                                    .substring(
                                                        0,
                                                        _name
                                                            .toString()
                                                            .indexOf(" "));
                                                launchURL(whatsAppFIRST +
                                                    _phone +
                                                    whatsAppSECOND +
                                                    firstName +
                                                    whatsAppTHIRD);
                                              }
                                            },
                                            style: OutlinedButton.styleFrom(
                                              foregroundColor: phoneColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              side: BorderSide(
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                                width: 2.0,
                                              ),
                                            ),
                                            icon: Icon(
                                              MdiIcons.whatsapp,
                                              size: 17,
                                              color: whiteColor,
                                            ),
                                            label: Text(
                                              whatsAppButton,
                                              style: GoogleFonts.raleway(
                                                color: textColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: _email.isNotEmpty,
                                          child: OutlinedButton.icon(
                                            onPressed: () {
                                              launchURL(mailFIRST +
                                                  _email +
                                                  mailSECOND +
                                                  _name);
                                            },
                                            style: OutlinedButton.styleFrom(
                                              foregroundColor: emailColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              side: BorderSide(
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                                width: 2.0,
                                              ),
                                            ),
                                            icon: Icon(
                                              MdiIcons.email,
                                              size: 17,
                                              color: whiteColor,
                                            ),
                                            label: Text(
                                              emailButton,
                                              style: GoogleFonts.raleway(
                                                color: textColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: _twitter.isNotEmpty,
                                          child: OutlinedButton.icon(
                                            onPressed: () {
                                              if (_twitter
                                                  .toString()
                                                  .startsWith('@')) {
                                                var handle = _twitter
                                                    .toString()
                                                    .substring(1);
                                                launchURL(urlTwitter + handle);
                                              } else {
                                                launchURL(
                                                    urlTwitter + _twitter);
                                              }
                                            },
                                            style: OutlinedButton.styleFrom(
                                              foregroundColor: twitterColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              side: BorderSide(
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                                width: 2.0,
                                              ),
                                            ),
                                            icon: Icon(
                                              MdiIcons.twitter,
                                              size: 17,
                                              color: twitterColor,
                                            ),
                                            label: Text(
                                              twitterButton,
                                              style: GoogleFonts.raleway(
                                                color: textColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: _instagram.isNotEmpty,
                                          child: OutlinedButton.icon(
                                            onPressed: () {
                                              if (_instagram
                                                  .toString()
                                                  .startsWith('@')) {
                                                var handle = _instagram
                                                    .toString()
                                                    .substring(1);
                                                launchURL(
                                                    urlInstagram + handle);
                                              } else {
                                                launchURL(
                                                    urlInstagram + _instagram);
                                              }
                                            },
                                            style: OutlinedButton.styleFrom(
                                              foregroundColor: instagramColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              side: BorderSide(
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                                width: 2.0,
                                              ),
                                            ),
                                            icon: Icon(
                                              MdiIcons.instagram,
                                              size: 17,
                                              color: instagramColor,
                                            ),
                                            label: Text(
                                              instagramButton,
                                              style: GoogleFonts.raleway(
                                                color: textColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: _snapchat.isNotEmpty,
                                          child: OutlinedButton.icon(
                                            onPressed: () {
                                              if (_snapchat
                                                  .toString()
                                                  .startsWith('@')) {
                                                var handle = _snapchat
                                                    .toString()
                                                    .substring(1);
                                                launchURL(urlSnapchat + handle);
                                              } else {
                                                launchURL(
                                                    urlSnapchat + _snapchat);
                                              }
                                            },
                                            style: OutlinedButton.styleFrom(
                                              foregroundColor: snapchatColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              side: BorderSide(
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                                width: 2.0,
                                              ),
                                            ),
                                            icon: Icon(
                                              MdiIcons.snapchat,
                                              size: 17,
                                              color: snapchatColor,
                                            ),
                                            label: Text(
                                              snapchatButton,
                                              style: GoogleFonts.raleway(
                                                color: textColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: _website.isNotEmpty,
                                          child: OutlinedButton.icon(
                                            onPressed: () {
                                              facebookLink();
                                            },
                                            style: OutlinedButton.styleFrom(
                                              foregroundColor: websiteColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(20.0),
                                              ),
                                              side: BorderSide(
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                                width: 2.0,
                                              ),
                                            ),
                                            icon: Icon(
                                              MdiIcons.searchWeb,
                                              size: 17,
                                              color: whiteColor,
                                            ),
                                            label: Text(
                                              websiteButton,
                                              style: GoogleFonts.raleway(
                                                color: textColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: _facebook.isNotEmpty,
                                          child: OutlinedButton.icon(
                                            onPressed: () {
                                              facebookLink();
                                            },
                                            style: OutlinedButton.styleFrom(
                                              foregroundColor: facebookColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              side: BorderSide(
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                                width: 2.0,
                                              ),
                                            ),
                                            icon: Icon(
                                              MdiIcons.facebook,
                                              size: 17,
                                              color: whiteColor,
                                            ),
                                            label: Text(
                                              facebookButton,
                                              style: GoogleFonts.raleway(
                                                color: textColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: _youtube.isNotEmpty,
                                          child: OutlinedButton.icon(
                                            onPressed: () {
                                              facebookLink();
                                            },
                                            style: OutlinedButton.styleFrom(
                                              foregroundColor: youtubeColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              side: BorderSide(
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                                width: 2.0,
                                              ),
                                            ),
                                            icon: Icon(
                                              MdiIcons.youtube,
                                              size: 17,
                                              color: whiteColor,
                                            ),
                                            label: Text(
                                              youtubeButton,
                                              style: GoogleFonts.raleway(
                                                color: textColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: width / 1.19,
                              // height: width/1.6,
                              decoration: BoxDecoration(
                                color: conColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text.rich(
                                  textAlign: TextAlign.justify,
                                  TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              '${clubSponsorsNotifier.currentClubSponsors.name!}\n',
                                          style: GoogleFonts.aBeeZee(
                                            color: textColor,
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      TextSpan(
                                          text: '  $_aboutUs\n\n',
                                          style: GoogleFonts.trykker(
                                            color: textColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300,
                                          )),
                                      TextSpan(
                                          text: '$ourServicesTitle\n',
                                          style: GoogleFonts.aBeeZee(
                                            color: textColor,
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      TextSpan(
                                          text: '  $_ourServices',
                                          style: GoogleFonts.trykker(
                                            color: textColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: width / 1.19,
                              height: width / 1.6,
                              decoration: BoxDecoration(
                                color: conColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Swiper(
                                curve: Curves.bounceIn,
                                autoplay: true,
                                viewportFraction: 0.8,
                                scale: 0.9,
                                itemCount: clubSponsorsNotifier.clubSponsorsList
                                    .length, // Total count of images in all documents
                                itemBuilder: (context, index) {
                                  int imageIndex = index % 5;
                                  ClubSponsors sponsor =
                                      clubSponsorsNotifier.currentClubSponsors;

                                  String? imageUrl;
                                  switch (imageIndex) {
                                    case 0:
                                      imageUrl = sponsor.image;
                                      break;
                                    case 1:
                                      imageUrl = sponsor.imageTwo;
                                      break;
                                    case 2:
                                      imageUrl = sponsor.imageThree;
                                      break;
                                    case 3:
                                      imageUrl = sponsor.imageFour;
                                      break;
                                    case 4:
                                      imageUrl = sponsor.imageFive;
                                      break;
                                    default:
                                      imageUrl = null;
                                      break;
                                  }

                                  if (imageUrl != null) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          image: DecorationImage(
                                            alignment: Alignment.topCenter,
                                            image: CachedNetworkImageProvider(
                                                imageUrl),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return const SizedBox
                                        .shrink(); // Return an empty container if image URL is null
                                  }
                                },
                                layout: SwiperLayout.DEFAULT,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    ClubSponsorsNotifier clubSponsorsNotifier =
        Provider.of<ClubSponsorsNotifier>(context, listen: false);
    getClubSponsors(clubSponsorsNotifier);

    upcomingMatchesNotifier =
        Provider.of<UpcomingMatchesNotifier>(context, listen: false);
    getUpcomingMatches(upcomingMatchesNotifier);

    _name = clubSponsorsNotifier.currentClubSponsors.name;
    _phone = clubSponsorsNotifier.currentClubSponsors.phone;
    _email = clubSponsorsNotifier.currentClubSponsors.email;
    _twitter = clubSponsorsNotifier.currentClubSponsors.twitter;
    _instagram = clubSponsorsNotifier.currentClubSponsors.instagram;
    _facebook = clubSponsorsNotifier.currentClubSponsors.facebook;
    _youtube = clubSponsorsNotifier.currentClubSponsors.youtube;
    _website = clubSponsorsNotifier.currentClubSponsors.website;
    _snapchat = clubSponsorsNotifier.currentClubSponsors.snapchat;
    _aboutUs = clubSponsorsNotifier.currentClubSponsors.aboutUs;
    _ourServices = clubSponsorsNotifier.currentClubSponsors.ourServices;

    _homeTeamIcon = upcomingMatchesNotifier.upcomingMatchesList[1].homeTeamIcon;
    _awayTeamIcon = upcomingMatchesNotifier.upcomingMatchesList[1].awayTeamIcon;
    _homeTeam = upcomingMatchesNotifier.upcomingMatchesList[0].homeTeam;
    _awayTeam = upcomingMatchesNotifier.upcomingMatchesList[0].awayTeam;
    _matchDate = upcomingMatchesNotifier.upcomingMatchesList[0].matchDate;
    _matchDayKickOff =
        upcomingMatchesNotifier.upcomingMatchesList[0].matchDayKickOff;
    _venue = upcomingMatchesNotifier.upcomingMatchesList[0].venue;

    super.initState();
  }

  void _showUploadDialog() async {
    // Create a GlobalKey for the RepaintBoundary
    GlobalKey boundaryKey = GlobalKey();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text("Upload Sponsor Information"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RepaintBoundary(
                key: boundaryKey, // Set the key for RepaintBoundary,
                child: Stack(
                  key: _contentKey,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 45), // Add top padding of 16 units
                      child: Image.asset(
                        'assets/images/cpfc_logo.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(color: Colors.black.withOpacity(0.2)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Text(
                        "Our Sponsor for today is ${clubSponsorsNotifier.currentClubSponsors.name!}, with their image:",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          top: 50), // Add a top margin of 16 units
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              _homeTeamIcon!,
                              width: 50,
                              height: 50,
                            ),
                          ),
                          Text('Matchday',
                              style: TextStyle(fontSize: 25, color: Colors.white)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              _awayTeamIcon!,
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 120.0),
                      child: Center(
                        child: Text(
                          '${_homeTeam!} vs ${_awayTeam!}',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 160.0, left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('When', style: TextStyle(color: Colors.white)),
                          Text(
                            _matchDate!,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            '${_matchDayKickOff} kick off',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 220.0, left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Where', style: TextStyle(color: Colors.white)),
                          Text(
                            _venue!,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            // clubSponsorsNotifier.currentClubSponsors.postcode!,
                            'CV3 1HW',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 280.0),
                      child: Container(
                        height: 24,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.yellow, //
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Text(
                              'Sponsored by ${clubSponsorsNotifier.currentClubSponsors.name!}',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ), // Yellow rectangular space
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 300.0),
                      child: SizedBox(),
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
              },
              child: Text("Share", style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel", style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }


  void _shareContent(GlobalKey boundaryKey) async {
    // Get the RenderObject from the RepaintBoundary using its key
    RenderRepaintBoundary boundary =
    boundaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    // Increase the pixelRatio for higher resolution
    double pixelRatio = 3.0; // You can adjust this value based on your needs
    ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);

    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? pngBytes = byteData?.buffer.asUint8List();

    String text =
        "Our Sponsor for today is ${clubSponsorsNotifier.currentClubSponsors.name!}, with their image:";

    // Share the image with caption and text
    await Share.file(
      'Sponsor Information',
      'sponsor_info.png',
      pngBytes as List<int>,
      'image/png',
      text: text,
    );
  }


}

facebookLink() async {
  // showDialog(
  //   context: context,
  //   builder: (context) => AlertDialog(
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.all(Radius.circular(8)),
  //     ),
  //     backgroundColor: backGroundColor,
  //     title: Text(
  //       facebookProfileSharedPreferencesTitle,
  //       style: TextStyle(color: textColor),
  //     ),
  //     content: Text(
  //       facebookProfileSharedPreferencesContentOne +
  //           _facebook +
  //           facebookProfileSharedPreferencesContentTwo,
  //       textAlign: TextAlign.justify,
  //       style: TextStyle(color: textColor),
  //     ),
  //     actions: <Widget>[
  //       TextButton(
  //         onPressed: () {
  //           launchURL(urlFacebook);
  //           Toast.show("Loading up Facebook.com",
  //               duration: Toast.lengthLong,
  //               gravity: Toast.bottom,
  //               webTexColor: textColor,
  //               backgroundColor: backGroundColor,
  //               backgroundRadius: 10);
  //         },
  //         child: Text(
  //           facebookProfileSharedPreferencesButton,
  //           style: TextStyle(color: textColor),
  //         ),
  //       ),
  //       TextButton(
  //         onPressed: () => Navigator.of(context).pop(false),
  //         child: Text(
  //           facebookProfileSharedPreferencesButtonTwo,
  //           style: TextStyle(color: textColor),
  //         ),
  //       ),
  //     ],
  //   ),
  // );
}
