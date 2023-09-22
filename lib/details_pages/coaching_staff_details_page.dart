import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../notifier/coaching_staff_notifier.dart';

String clubName = "Coventry Phoenix FC";

String callFIRST = "tel:+44";
String smsFIRST = "sms:+44";
String whatsAppFIRST = "https://api.whatsapp.com/send?phone=+44";
String whatsAppSECOND = "&text=Hello%20";
String whatsAppTHIRD = ",%20How%20are%20you%20doing%20today?";
String mailFIRST = "mailto:";
String mailSECOND = "?subject=Hello ";
String urlTwitter = "https://twitter.com/";
String urlFacebook = "https://facebook.com/";
String urlInstagram = "https://www.instagram.com/";
String urlLinkedIn = "https://www.linkedin.com/";

String reachDetails = "Contacts";
String autoBioDetails = "  AutoBiography";

String callButton = "Call me";
String messageButton = "Send me a Message";
String whatsAppButton = "Send me a WhatsApp Message";
String emailButton = "Send me an Email";
String facebookButton = "My Facebook";
String linkedInButton = "My LinkedIn";
String twitterButton = "My Twitter";
String instagramButton = "My Instagram";

String autobiographyTitle = "My Autobiography\n";
String staffPositionTitle = "CPFC Coaching Position\n";
String bestMomentTitle = "My best moment so far in $clubName\n";
String worstMomentTitle = "My worst moment so far in $clubName\n";
String countryTitle = "My Nationality\n";
String whyLoveFootballCoachingTitle =
    "What made me move into Football Coaching\n";
String sportingIconTitle = "Who is my favourite sporting icon\n";
String yearOfInceptionTitle = "Year of Inception with $clubName\n";
String regionOfOriginTitle = "My Region of Origin\n";
String hobbiesTitle = "My Hobbies\n";
String philosophyTitle = "My Philosophy about Life\n";

String facebookProfileSharedPreferencesTitle = "Manual Website Search";
String facebookProfileSharedPreferencesContentOne =
    "Apparently, you'd need to search manually for ";
String facebookProfileSharedPreferencesContentTwo = ", on Facebook.com";
String facebookProfileSharedPreferencesButton = "Go to Facebook";
String facebookProfileSharedPreferencesButtonTwo = "Lol, No";

String linkedInProfileSharedPreferencesTitle = "Manual Website Search";
String linkedInProfileSharedPreferencesContentOne =
    "Apparently, you'd need to search manually for ";
String linkedInProfileSharedPreferencesContentTwo = ", on LinkedIn.com";
String linkedInProfileSharedPreferencesButton = "Go to LinkedIn";
String linkedInProfileSharedPreferencesButtonTwo = "Lol, No";

Color backgroundColor = const Color.fromRGBO(255, 145, 104, 1);
Color appBarBackgroundColor = const Color.fromRGBO(255, 145, 104, 1);
Color appBarIconColor = Colors.white;
Color materialBackgroundColor = Colors.transparent;
Color shapeDecorationColor = const Color.fromRGBO(255, 145, 104, 1);
Color shapeDecorationColorTwo = const Color.fromRGBO(138, 55, 24, 1);
Color shapeDecorationTextColor = const Color.fromRGBO(255, 145, 104, 1);
Color shapeDecorationTextColorTwo = const Color.fromRGBO(138, 55, 24, 1);
Color shapeDecorationIconColor = const Color.fromRGBO(254, 255, 236, 1);
Color cardBackgroundColor = Colors.white;
Color splashColor = const Color.fromRGBO(255, 145, 104, 1);
Color splashColorTwo = Colors.white;
Color splashColorThree = const Color.fromRGBO(255, 145, 104, 1);
Color iconTextColor = const Color.fromRGBO(138, 55, 24, 1);
Color buttonColor = const Color.fromRGBO(255, 145, 104, 1);
Color textColor = const Color.fromRGBO(138, 55, 24, 1);

Color confettiColorOne = Colors.green;
Color confettiColorTwo = Colors.blue;
Color confettiColorThree = Colors.pink;
Color confettiColorFour = Colors.orange;
Color confettiColorFive = Colors.purple;
Color confettiColorSix = Colors.brown;
Color confettiColorSeven = Colors.white;
Color confettiColorEight = Colors.blueGrey;
Color confettiColorNine = Colors.redAccent;
Color confettiColorTen = Colors.teal;
Color confettiColorEleven = Colors.indigoAccent;
Color confettiColorTwelve = Colors.cyan;

late CoachesNotifier coachesNotifier;

Map<int, Widget>? userBIO;

var crossFadeView = CrossFadeState.showFirst;

dynamic _autoBio;
dynamic _staffPosition;
dynamic _bestMoment;
dynamic _worstMoment;
dynamic _country;
dynamic _whyLoveFootballCoaching;
dynamic _sportingIcon;
dynamic _yearOfInception;
dynamic _hobbies;
dynamic _philosophy;
dynamic _regionFrom;
dynamic _email;
dynamic _facebook;
dynamic _instagram;
dynamic _name;
dynamic _phone;
dynamic _twitter;
dynamic _linkedIn;

class CoachesDetailsPage extends StatefulWidget {
  const CoachesDetailsPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<CoachesDetailsPage> createState() => _CoachesDetailsPage();
}

class _CoachesDetailsPage extends State<CoachesDetailsPage> {
  ConfettiController? _confettiController;

  bool _isVisible = true;

  void showToast() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  Future launchURL(String url) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    if (await canLaunchUrl(url as Uri)) {
      await launchUrl(url as Uri);
    } else {
      scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text("The required App not installed")));
    }
  }

  @override
  Widget build(BuildContext context) {
    coachesNotifier = Provider.of<CoachesNotifier>(context, listen: true);

    return ConfettiWidget(
      confettiController: _confettiController!,
      blastDirectionality: BlastDirectionality.explosive,
      shouldLoop: false,
      colors: [
        confettiColorOne,
        confettiColorTwo,
        confettiColorThree,
        confettiColorFour,
        confettiColorFive,
        confettiColorSix,
        confettiColorSeven,
        confettiColorEight,
        confettiColorNine,
        confettiColorTen,
        confettiColorEleven,
        confettiColorTwelve,
      ],
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          elevation: 10,
          backgroundColor: appBarBackgroundColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: appBarIconColor),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              if (coachesNotifier.currentCoaches.imageTwo
                  .toString()
                  .isEmpty) ...[
                Tooltip(
                    message: coachesNotifier.currentCoaches.name,
                    child: GestureDetector(
                      onTap: () => setState(() {
                        crossFadeView =
                            crossFadeView == CrossFadeState.showFirst
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst;
                      }),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * .64,
                        child: Card(
                          color: Colors.transparent,
                          elevation: 5,
                          margin: const EdgeInsets.all(10),
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: AnimatedCrossFade(
                            crossFadeState:
                                crossFadeView == CrossFadeState.showFirst
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                            duration: const Duration(milliseconds: 1000),
                            firstChild: CachedNetworkImage(
                              imageUrl: coachesNotifier.currentCoaches.image!,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(MdiIcons.alertRhombus),
                            ),
                            secondChild: CachedNetworkImage(
                              imageUrl: coachesNotifier.currentCoaches.image!,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(MdiIcons.alertRhombus),
                            ),
                          ),
                        ),
                      ),
                    )),
              ] else ...[
                Tooltip(
                    message: coachesNotifier.currentCoaches.name,
                    child: GestureDetector(
                      onTap: () => setState(() {
                        crossFadeView =
                            crossFadeView == CrossFadeState.showFirst
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst;
                      }),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          elevation: 5,
                          margin: const EdgeInsets.all(10),
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: AnimatedCrossFade(
                            crossFadeState:
                                crossFadeView == CrossFadeState.showFirst
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                            duration: const Duration(milliseconds: 1000),
                            firstChild: CachedNetworkImage(
                              imageUrl: coachesNotifier.currentCoaches.image!,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(MdiIcons.alertRhombus),
                            ),
                            secondChild: CachedNetworkImage(
                              imageUrl:
                                  coachesNotifier.currentCoaches.imageTwo!,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(MdiIcons.alertRhombus),
                            ),
                          ),
                        ),
                      ),
                    )),
              ],
              Material(
                color: materialBackgroundColor,
                child: InkWell(
                  splashColor: splashColor.withOpacity(0.20),
                  onTap: () {},
                  child: Card(
                    elevation: 4,
                    shape: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: shapeDecorationColor.withOpacity(0.80),
                          width: 4.0,
                          style: BorderStyle.solid),
                    ),
                    margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, top: 16.0, right: 16.0, bottom: 16.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              coachesNotifier.currentCoaches.name!
                                  .toUpperCase(),
                              style: GoogleFonts.blinker(
                                  color: shapeDecorationTextColorTwo,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(width: 10),
                            Icon(
                              MdiIcons.shieldCheck,
                              color: shapeDecorationColorTwo,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 5,
                color: cardBackgroundColor,
                margin: const EdgeInsets.all(10),
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 20, left: 8.0, right: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 20.0, bottom: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: shapeDecorationColor.withAlpha(70)),
                              // borderRadius: BorderRadius.circular(10)),
                              child: Material(
                                color: shapeDecorationColor.withAlpha(70),
                                child: InkWell(
                                  splashColor: splashColorThree,
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8, top: 8, left: 14, right: 14),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        padding: const EdgeInsets.all(4),
                                      ),
                                      child: Text(
                                        // _name.replaceAll(" ", "'s'") + autoBioDetails,
                                        _name.substring(0, _name.indexOf(' ')) +
                                            "'s" +
                                            autoBioDetails,
                                        style: GoogleFonts.sacramento(
                                          color: textColor,
                                          fontSize: 25,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          (() {
                            if (_whyLoveFootballCoaching
                                .toString()
                                .isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          shapeDecorationColorTwo.withAlpha(50),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Material(
                                    color: materialBackgroundColor,
                                    child: InkWell(
                                      splashColor: splashColorThree,
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 15, top: 15, left: 25),
                                        child: Text.rich(
                                          TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      whyLoveFootballCoachingTitle,
                                                  style: GoogleFonts.aBeeZee(
                                                    color: textColor,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              TextSpan(
                                                  text:
                                                      ' $_whyLoveFootballCoaching',
                                                  style: GoogleFonts.trykker(
                                                    color: textColor,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.w300,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Visibility(
                                  visible: !_isVisible,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: shapeDecorationColorTwo
                                            .withAlpha(50),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Material(
                                      color: materialBackgroundColor,
                                      // child: InkWell(
                                      //   splashColor: splashColorThree,
                                      //   onTap: () {},
                                      //   child: Padding(
                                      //     padding: const EdgeInsets.only(
                                      //         bottom: 15, top: 15, left: 25),
                                      //     child: Text.rich(
                                      //       TextSpan(
                                      //         children: <TextSpan>[
                                      //           TextSpan(
                                      //               text: qualificationTitle,
                                      //               style: GoogleFonts.aBeeZee(
                                      //                 color: textColor,
                                      //                 fontSize: 19,
                                      //                 fontWeight: FontWeight.bold,
                                      //               )),
                                      //           TextSpan(
                                      //               text: ' ' + _qualification,
                                      //               style: GoogleFonts.trykker(
                                      //                 color: textColor,
                                      //                 fontSize: 19,
                                      //                 fontWeight: FontWeight.w300,
                                      //               )),
                                      //         ],
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                    ),
                                  ));
                            }
                          }()),
                          (() {
                            if (_sportingIcon.toString().isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          shapeDecorationColorTwo.withAlpha(50),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Material(
                                    color: materialBackgroundColor,
                                    child: InkWell(
                                      splashColor: splashColorThree,
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 15, top: 15, left: 25),
                                        child: Text.rich(
                                          TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: sportingIconTitle,
                                                  style: GoogleFonts.aBeeZee(
                                                    color: textColor,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              TextSpan(
                                                  text: ' $_sportingIcon',
                                                  style: GoogleFonts.trykker(
                                                    color: textColor,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.w300,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Visibility(
                                  visible: !_isVisible,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: shapeDecorationColorTwo
                                            .withAlpha(50),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Material(
                                      color: materialBackgroundColor,
                                      // child: InkWell(
                                      //   splashColor: splashColorThree,
                                      //   onTap: () {},
                                      //   child: Padding(
                                      //     padding: const EdgeInsets.only(
                                      //         bottom: 15, top: 15, left: 25),
                                      //     child: Text.rich(
                                      //       TextSpan(
                                      //         children: <TextSpan>[
                                      //           TextSpan(
                                      //               text: peleOrMaradonaTitle,
                                      //               style: GoogleFonts.aBeeZee(
                                      //                 color: textColor,
                                      //                 fontSize: 19,
                                      //                 fontWeight: FontWeight.bold,
                                      //               )),
                                      //           TextSpan(
                                      //               text: ' ' + _peleOrMaradona,
                                      //               style: GoogleFonts.trykker(
                                      //                 color: textColor,
                                      //                 fontSize: 19,
                                      //                 fontWeight: FontWeight.w300,
                                      //               )),
                                      //         ],
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                    ),
                                  ));
                            }
                          }()),
                          (() {
                            if (_staffPosition.toString().isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          shapeDecorationColorTwo.withAlpha(50),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Material(
                                    color: materialBackgroundColor,
                                    child: InkWell(
                                      splashColor: splashColorThree,
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 15, top: 15, left: 25),
                                        child: Text.rich(
                                          TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: staffPositionTitle,
                                                  style: GoogleFonts.aBeeZee(
                                                    color: textColor,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              TextSpan(
                                                  text: ' $_staffPosition',
                                                  style: GoogleFonts.trykker(
                                                    color: textColor,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.w300,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Visibility(
                                  visible: !_isVisible,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: shapeDecorationColorTwo
                                            .withAlpha(50),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Material(
                                      color: materialBackgroundColor,
                                      child: InkWell(
                                        splashColor: splashColorThree,
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 15, top: 15, left: 25),
                                          child: Text.rich(
                                            TextSpan(
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: staffPositionTitle,
                                                    style: GoogleFonts.aBeeZee(
                                                      color: textColor,
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                                TextSpan(
                                                    text: ' $_staffPosition',
                                                    style: GoogleFonts.trykker(
                                                      color: textColor,
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ));
                            }
                          }()),
                          (() {
                            if (_yearOfInception.toString().isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          shapeDecorationColorTwo.withAlpha(50),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Material(
                                    color: materialBackgroundColor,
                                    child: InkWell(
                                      splashColor: splashColorThree,
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 15, top: 15, left: 25),
                                        child: Text.rich(
                                          TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: yearOfInceptionTitle,
                                                  style: GoogleFonts.aBeeZee(
                                                    color: textColor,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              TextSpan(
                                                  text: ' $_yearOfInception',
                                                  style: GoogleFonts.trykker(
                                                    color: textColor,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.w300,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Visibility(
                                  visible: !_isVisible,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: shapeDecorationColorTwo
                                            .withAlpha(50),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Material(
                                      color: materialBackgroundColor,
                                      child: InkWell(
                                        splashColor: splashColorThree,
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 15, top: 15, left: 25),
                                          child: Text.rich(
                                            TextSpan(
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: yearOfInceptionTitle,
                                                    style: GoogleFonts.aBeeZee(
                                                      color: textColor,
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                                TextSpan(
                                                    text: ' $_yearOfInception',
                                                    style: GoogleFonts.trykker(
                                                      color: textColor,
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ));
                            }
                          }()),
                          (() {
                            if (_bestMoment.toString().isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          shapeDecorationColorTwo.withAlpha(50),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Material(
                                    color: materialBackgroundColor,
                                    child: InkWell(
                                      splashColor: splashColorThree,
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 15, top: 15, left: 25),
                                        child: Text.rich(
                                          TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: bestMomentTitle,
                                                  style: GoogleFonts.aBeeZee(
                                                    color: textColor,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              TextSpan(
                                                  text: ' $_bestMoment',
                                                  style: GoogleFonts.trykker(
                                                    color: textColor,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.w300,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Visibility(
                                  visible: !_isVisible,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: shapeDecorationColorTwo
                                            .withAlpha(50),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Material(
                                      color: materialBackgroundColor,
                                      // child: InkWell(
                                      //   splashColor: splashColorThree,
                                      //   onTap: () {},
                                      //   child: Padding(
                                      //     padding: const EdgeInsets.only(
                                      //         bottom: 15, top: 15, left: 25),
                                      //     child: Text.rich(
                                      //       TextSpan(
                                      //         children: <TextSpan>[
                                      //           TextSpan(
                                      //               text: courseTeachingTitle,
                                      //               style: GoogleFonts.aBeeZee(
                                      //                 color: textColor,
                                      //                 fontSize: 19,
                                      //                 fontWeight: FontWeight.bold,
                                      //               )),
                                      //           TextSpan(
                                      //               text: ' ' + _courseTeaching,
                                      //               style: GoogleFonts.trykker(
                                      //                 color: textColor,
                                      //                 fontSize: 19,
                                      //                 fontWeight: FontWeight.w300,
                                      //               )),
                                      //         ],
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                    ),
                                  ));
                            }
                          }()),
                          (() {
                            if (_worstMoment.toString().isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          shapeDecorationColorTwo.withAlpha(50),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Material(
                                    color: materialBackgroundColor,
                                    child: InkWell(
                                      splashColor: splashColorThree,
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 15, top: 15, left: 25),
                                        child: Text.rich(
                                          TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: worstMomentTitle,
                                                  style: GoogleFonts.aBeeZee(
                                                    color: textColor,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              TextSpan(
                                                  text: ' $_worstMoment',
                                                  style: GoogleFonts.trykker(
                                                    color: textColor,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.w300,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Visibility(
                                  visible: !_isVisible,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: shapeDecorationColorTwo
                                            .withAlpha(50),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Material(
                                      color: materialBackgroundColor,
                                      // child: InkWell(
                                      //   splashColor: splashColorThree,
                                      //   onTap: () {},
                                      //   child: Padding(
                                      //     padding: const EdgeInsets.only(
                                      //         bottom: 15, top: 15, left: 25),
                                      //     child: Text.rich(
                                      //       TextSpan(
                                      //         children: <TextSpan>[
                                      //           TextSpan(
                                      //               text: courseTeachingTitle,
                                      //               style: GoogleFonts.aBeeZee(
                                      //                 color: textColor,
                                      //                 fontSize: 19,
                                      //                 fontWeight: FontWeight.bold,
                                      //               )),
                                      //           TextSpan(
                                      //               text: ' ' + _courseTeaching,
                                      //               style: GoogleFonts.trykker(
                                      //                 color: textColor,
                                      //                 fontSize: 19,
                                      //                 fontWeight: FontWeight.w300,
                                      //               )),
                                      //         ],
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                    ),
                                  ));
                            }
                          }()),
                          (() {
                            if (_autoBio.toString().isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          shapeDecorationColorTwo.withAlpha(50),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Material(
                                    color: materialBackgroundColor,
                                    child: InkWell(
                                      splashColor: splashColorThree,
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 15, top: 15, left: 25),
                                        child: Text.rich(
                                          TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: autobiographyTitle,
                                                  style: GoogleFonts.aBeeZee(
                                                    color: textColor,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              TextSpan(
                                                  text: ' $_autoBio',
                                                  style: GoogleFonts.trykker(
                                                    color: textColor,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.w300,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Visibility(
                                  visible: _isVisible,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: shapeDecorationColorTwo
                                            .withAlpha(50),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Material(
                                      color: materialBackgroundColor,
                                      child: InkWell(
                                        splashColor: splashColorThree,
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 15, top: 15, left: 25),
                                          child: Text.rich(
                                            TextSpan(
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: autobiographyTitle,
                                                    style: GoogleFonts.aBeeZee(
                                                      color: textColor,
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                                TextSpan(
                                                    text: " ${ _name.substring(0, _name.indexOf(' '))} hasn't filled his data",
                                                    style: GoogleFonts.trykker(
                                                      color: textColor,
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ));
                            }
                          }()),
                          (() {
                            if (_country.toString().isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          shapeDecorationColorTwo.withAlpha(50),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Material(
                                    color: materialBackgroundColor,
                                    child: InkWell(
                                      splashColor: splashColorThree,
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 15, top: 15, left: 25),
                                        child: Text.rich(
                                          TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: countryTitle,
                                                  style: GoogleFonts.aBeeZee(
                                                    color: textColor,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              TextSpan(
                                                  text: ' $_country',
                                                  style: GoogleFonts.trykker(
                                                    color: textColor,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.w300,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Visibility(
                                  visible: !_isVisible,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: shapeDecorationColorTwo
                                            .withAlpha(50),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Material(
                                      color: materialBackgroundColor,
                                      // child: InkWell(
                                      //   splashColor: splashColorThree,
                                      //   onTap: () {},
                                      //   child: Padding(
                                      //     padding: const EdgeInsets.only(
                                      //         bottom: 15, top: 15, left: 25),
                                      //     child: Text.rich(
                                      //       TextSpan(
                                      //         children: <TextSpan>[
                                      //           TextSpan(
                                      //               text: qualificationTitle,
                                      //               style: GoogleFonts.aBeeZee(
                                      //                 color: textColor,
                                      //                 fontSize: 19,
                                      //                 fontWeight: FontWeight.bold,
                                      //               )),
                                      //           TextSpan(
                                      //               text: ' ' + _qualification,
                                      //               style: GoogleFonts.trykker(
                                      //                 color: textColor,
                                      //                 fontSize: 19,
                                      //                 fontWeight: FontWeight.w300,
                                      //               )),
                                      //         ],
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                    ),
                                  ));
                            }
                          }()),
                          (() {
                            if (_regionFrom.toString().isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          shapeDecorationColorTwo.withAlpha(50),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Material(
                                    color: materialBackgroundColor,
                                    child: InkWell(
                                      splashColor: splashColorThree,
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 15, top: 15, left: 25),
                                        child: Text.rich(
                                          TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: regionOfOriginTitle,
                                                  style: GoogleFonts.aBeeZee(
                                                    color: textColor,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              TextSpan(
                                                  text: ' $_regionFrom',
                                                  style: GoogleFonts.trykker(
                                                    color: textColor,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.w300,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Visibility(
                                  visible: !_isVisible,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: shapeDecorationColorTwo
                                            .withAlpha(50),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Material(
                                      color: materialBackgroundColor,
                                      child: InkWell(
                                        splashColor: splashColorThree,
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 15, top: 15, left: 25),
                                          child: Text.rich(
                                            TextSpan(
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: regionOfOriginTitle,
                                                    style: GoogleFonts.aBeeZee(
                                                      color: textColor,
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                                TextSpan(
                                                    text: ' $_regionFrom',
                                                    style: GoogleFonts.trykker(
                                                      color: textColor,
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ));
                            }
                          }()),
                          (() {
                            if (_hobbies.toString().isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          shapeDecorationColorTwo.withAlpha(50),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Material(
                                    color: materialBackgroundColor,
                                    child: InkWell(
                                      splashColor: splashColorThree,
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 15, top: 15, left: 25),
                                        child: Text.rich(
                                          TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: hobbiesTitle,
                                                  style: GoogleFonts.aBeeZee(
                                                    color: textColor,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              TextSpan(
                                                  text: ' $_hobbies',
                                                  style: GoogleFonts.trykker(
                                                    color: textColor,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.w300,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Visibility(
                                  visible: !_isVisible,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: shapeDecorationColorTwo
                                            .withAlpha(50),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Material(
                                      color: materialBackgroundColor,
                                      child: InkWell(
                                        splashColor: splashColorThree,
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 15, top: 15, left: 25),
                                          child: Text.rich(
                                            TextSpan(
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: hobbiesTitle,
                                                    style: GoogleFonts.aBeeZee(
                                                      color: textColor,
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                                TextSpan(
                                                    text: ' $_hobbies',
                                                    style: GoogleFonts.trykker(
                                                      color: textColor,
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ));
                            }
                          }()),
                          (() {
                            if (_philosophy.toString().isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          shapeDecorationColorTwo.withAlpha(50),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Material(
                                    color: materialBackgroundColor,
                                    child: InkWell(
                                      splashColor: splashColorThree,
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 15, top: 15, left: 25),
                                        child: Text.rich(
                                          TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: philosophyTitle,
                                                  style: GoogleFonts.aBeeZee(
                                                    color: textColor,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              TextSpan(
                                                  text: ' $_philosophy',
                                                  style: GoogleFonts.trykker(
                                                    color: textColor,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.w300,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Visibility(
                                  visible: !_isVisible,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: shapeDecorationColorTwo
                                            .withAlpha(50),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Material(
                                      color: materialBackgroundColor,
                                      child: InkWell(
                                        splashColor: splashColorThree,
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 15, top: 15, left: 25),
                                          child: Text.rich(
                                            TextSpan(
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: philosophyTitle,
                                                    style: GoogleFonts.aBeeZee(
                                                      color: textColor,
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                                TextSpan(
                                                    text: ' $_philosophy',
                                                    style: GoogleFonts.trykker(
                                                      color: textColor,
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ));
                            }
                          }()),
                        ],
                      ),

                      /** 0: Useful for CPFC 1st Version and other FC Apps, DND */
                      // Padding(
                      //   padding: const EdgeInsets.only(bottom: 35),
                      //   child: CupertinoSlidingSegmentedControl<int>(
                      //     padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                      //     thumbColor: cardBackgroundColor,
                      //     backgroundColor: shapeDecorationColorTwo.withAlpha(
                      //         120),
                      //
                      //     children: {
                      //       0: Text(
                      //         reachDetails,
                      //         style: GoogleFonts.sacramento(
                      //             color: shapeDecorationTextColorTwo,
                      //             fontSize: 25,
                      //             fontStyle: FontStyle.normal,
                      //             fontWeight: FontWeight.w400
                      //         ),
                      //       ),
                      //       1: Text(
                      //         autoBioDetails,
                      //         style: GoogleFonts.sacramento(
                      //           color: shapeDecorationTextColorTwo,
                      //           fontSize: 25,
                      //           fontStyle: FontStyle.normal,
                      //           fontWeight: FontWeight.w400,
                      //
                      //         ),
                      //       ),
                      //     },
                      //     onValueChanged: (int? val) {
                      //       setState(() {
                      //         sharedValue = val!;
                      //       });
                      //     },
                      //     groupValue: sharedValue,
                      //   ),
                      // ),
                      // userBIO![sharedValue]!,
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40)
            ],
          ),
        ),
      ),
    );
  }

  @override
  initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _confettiController =
        ConfettiController(duration: const Duration(seconds: 7));
    _confettiController?.play();

    CoachesNotifier coachesNotifier =
        Provider.of<CoachesNotifier>(context, listen: false);

    _autoBio = coachesNotifier.currentCoaches.autoBio;
    _staffPosition = coachesNotifier.currentCoaches.staffPosition;
    _bestMoment = coachesNotifier.currentCoaches.bestMoment;
    _worstMoment = coachesNotifier.currentCoaches.worstMoment;
    _country = coachesNotifier.currentCoaches.nationality;
    _whyLoveFootballCoaching =
        coachesNotifier.currentCoaches.whyLoveCoachingOrFCManagement;
    _sportingIcon = coachesNotifier.currentCoaches.favSportingIcon;
    _yearOfInception = coachesNotifier.currentCoaches.yearOfInception;
    _hobbies = coachesNotifier.currentCoaches.hobbies;
    _philosophy = coachesNotifier.currentCoaches.philosophy;
    _regionFrom = coachesNotifier.currentCoaches.regionOfOrigin;
    _email = coachesNotifier.currentCoaches.email;
    _facebook = coachesNotifier.currentCoaches.facebook;
    _instagram = coachesNotifier.currentCoaches.instagram;
    _name = coachesNotifier.currentCoaches.name;
    _phone = coachesNotifier.currentCoaches.phone;
    _twitter = coachesNotifier.currentCoaches.twitter;
    _linkedIn = coachesNotifier.currentCoaches.linkedIn;

    userBIO = <int, Widget>{
      0: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          (() {
            if (_phone.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  splashColor: splashColorTwo,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      elevation: 2,
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: Icon(MdiIcons.dialpad, color: iconTextColor),
                    label: Text(callButton,
                        style: GoogleFonts.abel(
                            color: iconTextColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w300)),
                    onPressed: () {
                      if (_phone.toString().startsWith('0')) {
                        var most = _phone.toString().substring(1);
                        launchURL(callFIRST + most);
                      } else {
                        launchURL(callFIRST + _phone);
                      }
                    },
                  ),
                ),
              );
            } else {
              return Visibility(
                visible: !_isVisible,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    splashColor: splashColorTwo,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        elevation: 2,
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      icon: Icon(MdiIcons.dialpad, color: iconTextColor),
                      label: Text(callButton,
                          style: GoogleFonts.abel(
                              color: iconTextColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w300)),
                      onPressed: () {
                        launchURL(callFIRST + _phone);
                      },
                    ),
                  ),
                ),
              );
            }
          }()),
          (() {
            if (_phone.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  splashColor: splashColorTwo,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      elevation: 2,
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: Icon(MdiIcons.message, color: iconTextColor),
                    label: Text(messageButton,
                        style: GoogleFonts.abel(
                            color: iconTextColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w300)),
                    onPressed: () {
                      if (_phone.toString().startsWith('0')) {
                        var most = _phone.toString().substring(1);
                        launchURL(smsFIRST + most);
                      } else {
                        launchURL(smsFIRST + _phone);
                      }
                    },
                  ),
                ),
              );
            } else {
              return Visibility(
                visible: !_isVisible,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    splashColor: splashColorTwo,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        elevation: 2,
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      icon: Icon(MdiIcons.message, color: iconTextColor),
                      label: Text(messageButton,
                          style: GoogleFonts.abel(
                              color: iconTextColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w300)),
                      onPressed: () {
                        launchURL(smsFIRST + _phone);
                      },
                    ),
                  ),
                ),
              );
            }
          }()),
          (() {
            if (_phone.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  splashColor: splashColorTwo,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      elevation: 2,
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: Icon(MdiIcons.whatsapp, color: iconTextColor),
                    label: Text(whatsAppButton,
                        style: GoogleFonts.abel(
                            color: iconTextColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w300)),
                    onPressed: () {
                      if (_phone.toString().startsWith('0')) {
                        var most = _phone.toString().substring(1);
                        var firstName = _name
                            .toString()
                            .substring(0, _name.toString().indexOf(" "));
                        launchURL(whatsAppFIRST +
                            most +
                            whatsAppSECOND +
                            firstName +
                            whatsAppTHIRD);
                      } else {
                        var firstName = _name
                            .toString()
                            .substring(0, _name.toString().indexOf(" "));
                        launchURL(whatsAppFIRST +
                            _phone +
                            whatsAppSECOND +
                            firstName +
                            whatsAppTHIRD);
                      }
                    },
                  ),
                ),
              );
            } else {
              return Visibility(
                visible: !_isVisible,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    splashColor: splashColorTwo,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        elevation: 2,
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      icon: Icon(MdiIcons.message, color: iconTextColor),
                      label: Text(messageButton,
                          style: GoogleFonts.abel(
                              color: iconTextColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w300)),
                      onPressed: () {
                        launchURL(smsFIRST + _phone);
                      },
                    ),
                  ),
                ),
              );
            }
          }()),
          (() {
            if (_email.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  splashColor: splashColorTwo,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      elevation: 2,
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: Icon(MdiIcons.gmail, color: iconTextColor),
                    label: Text(emailButton,
                        style: GoogleFonts.abel(
                            color: iconTextColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w300)),
                    onPressed: () {
                      launchURL(mailFIRST + _email + mailSECOND + _name);
                    },
                  ),
                ),
              );
            } else {
              return Visibility(
                visible: !_isVisible,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    splashColor: splashColorTwo,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        elevation: 2,
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      icon: Icon(MdiIcons.gmail, color: iconTextColor),
                      label: Text(emailButton,
                          style: GoogleFonts.abel(
                              color: iconTextColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w300)),
                      onPressed: () {
                        launchURL(mailFIRST + _email + mailSECOND + _name);
                      },
                    ),
                  ),
                ),
              );
            }
          }()),
          (() {
            if (_twitter.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  splashColor: splashColorTwo,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      elevation: 2,
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: Icon(MdiIcons.twitter, color: iconTextColor),
                    label: Text(twitterButton,
                        style: GoogleFonts.abel(
                            color: iconTextColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w300)),
                    onPressed: () {
                      if (_twitter.toString().startsWith('@')) {
                        var most = _twitter.toString().substring(1);
                        launchURL(urlTwitter + most);
                      } else {
                        launchURL(urlTwitter + _twitter);
                      }
                    },
                  ),
                ),
              );
            } else {
              return Visibility(
                visible: !_isVisible,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    splashColor: splashColorTwo,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        elevation: 2,
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      icon: Icon(MdiIcons.twitter, color: iconTextColor),
                      label: Text(twitterButton,
                          style: GoogleFonts.abel(
                              color: iconTextColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w300)),
                      onPressed: () {
                        launchURL(urlTwitter + _twitter);
                      },
                    ),
                  ),
                ),
              );
            }
          }()),
          (() {
            if (_instagram.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  splashColor: splashColorTwo,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      elevation: 2,
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: Icon(MdiIcons.instagram, color: iconTextColor),
                    label: Text(instagramButton,
                        style: GoogleFonts.abel(
                            color: iconTextColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w300)),
                    onPressed: () {
                      if (_instagram.toString().startsWith('@')) {
                        var most = _instagram.toString().substring(1);
                        launchURL(urlInstagram + most);
                      } else {
                        launchURL(urlInstagram + _instagram);
                      }
                    },
                  ),
                ),
              );
            } else {
              return Visibility(
                visible: !_isVisible,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    splashColor: splashColorTwo,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        elevation: 2,
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      icon: Icon(MdiIcons.instagram, color: iconTextColor),
                      label: Text(instagramButton,
                          style: GoogleFonts.abel(
                              color: iconTextColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w300)),
                      onPressed: () {
                        launchURL(urlInstagram + _instagram);
                      },
                    ),
                  ),
                ),
              );
            }
          }()),
          (() {
            if (_facebook.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  splashColor: splashColorTwo,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      elevation: 2,
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: Icon(MdiIcons.facebook, color: iconTextColor),
                    label: Text(
                      facebookButton,
                      style: GoogleFonts.abel(
                          color: iconTextColor,
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.dashed,
                          fontWeight: FontWeight.w300),
                    ),
                    onPressed: () {
                      facebookLink();
                    },
                  ),
                ),
              );
            } else {
              return Visibility(
                visible: !_isVisible,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    splashColor: iconTextColor,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        elevation: 2,
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      icon: Icon(MdiIcons.facebook, color: iconTextColor),
                      label: Text(
                        'My Facebook',
                        style: GoogleFonts.abel(
                            color: iconTextColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w300),
                      ),
                      onPressed: () {
                        launchURL(urlFacebook + _facebook);
                      },
                    ),
                  ),
                ),
              );
            }
          }()),
          (() {
            if (_linkedIn.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  splashColor: splashColorTwo,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      elevation: 2,
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: Icon(MdiIcons.linkedin, color: iconTextColor),
                    label: Text(
                      linkedInButton,
                      style: GoogleFonts.abel(
                          color: iconTextColor,
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.dashed,
                          fontWeight: FontWeight.w300),
                    ),
                    onPressed: () {
                      linkedInLink();
                    },
                  ),
                ),
              );
            } else {
              return Visibility(
                visible: !_isVisible,
                child: const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  // child: InkWell(
                  //   splashColor: iconTextColor,
                  //   child: RaisedButton.icon(
                  //     shape: BeveledRectangleBorder(
                  //         borderRadius: BorderRadius.circular(10)
                  //     ),
                  //     elevation: 2,
                  //     color: buttonColor,
                  //     icon: Icon(MdiIcons.facebook, color: iconTextColor),
                  //     label: Text('My Facebook',
                  //       style: GoogleFonts.abel(
                  //           color: iconTextColor,
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.w300
                  //       ),
                  //     ),
                  //     onPressed: () {
                  //       launchURL(urlFacebook + _facebook);
                  //     },
                  //   ),
                  // ),
                ),
              );
            }
          }()),
        ],
      ),
      1: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          (() {
            if (_whyLoveFootballCoaching.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: shapeDecorationColorTwo.withAlpha(50),
                      borderRadius: BorderRadius.circular(10)),
                  child: Material(
                    color: materialBackgroundColor,
                    child: InkWell(
                      splashColor: splashColorThree,
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, top: 15, left: 25),
                        child: Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: whyLoveFootballCoachingTitle,
                                  style: GoogleFonts.aBeeZee(
                                    color: textColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  )),
                              TextSpan(
                                  text: ' $_whyLoveFootballCoaching',
                                  style: GoogleFonts.trykker(
                                    color: textColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w300,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Visibility(
                  visible: !_isVisible,
                  child: Container(
                    decoration: BoxDecoration(
                        color: shapeDecorationColorTwo.withAlpha(50),
                        borderRadius: BorderRadius.circular(10)),
                    child: Material(
                      color: materialBackgroundColor,
                      // child: InkWell(
                      //   splashColor: splashColorThree,
                      //   onTap: () {},
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(
                      //         bottom: 15, top: 15, left: 25),
                      //     child: Text.rich(
                      //       TextSpan(
                      //         children: <TextSpan>[
                      //           TextSpan(
                      //               text: qualificationTitle,
                      //               style: GoogleFonts.aBeeZee(
                      //                 color: textColor,
                      //                 fontSize: 19,
                      //                 fontWeight: FontWeight.bold,
                      //               )),
                      //           TextSpan(
                      //               text: ' ' + _qualification,
                      //               style: GoogleFonts.trykker(
                      //                 color: textColor,
                      //                 fontSize: 19,
                      //                 fontWeight: FontWeight.w300,
                      //               )),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ),
                  ));
            }
          }()),
          (() {
            if (_sportingIcon.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: shapeDecorationColorTwo.withAlpha(50),
                      borderRadius: BorderRadius.circular(10)),
                  child: Material(
                    color: materialBackgroundColor,
                    child: InkWell(
                      splashColor: splashColorThree,
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, top: 15, left: 25),
                        child: Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: sportingIconTitle,
                                  style: GoogleFonts.aBeeZee(
                                    color: textColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  )),
                              TextSpan(
                                  text: ' $_sportingIcon',
                                  style: GoogleFonts.trykker(
                                    color: textColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w300,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Visibility(
                  visible: !_isVisible,
                  child: Container(
                    decoration: BoxDecoration(
                        color: shapeDecorationColorTwo.withAlpha(50),
                        borderRadius: BorderRadius.circular(10)),
                    child: Material(
                      color: materialBackgroundColor,
                      // child: InkWell(
                      //   splashColor: splashColorThree,
                      //   onTap: () {},
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(
                      //         bottom: 15, top: 15, left: 25),
                      //     child: Text.rich(
                      //       TextSpan(
                      //         children: <TextSpan>[
                      //           TextSpan(
                      //               text: peleOrMaradonaTitle,
                      //               style: GoogleFonts.aBeeZee(
                      //                 color: textColor,
                      //                 fontSize: 19,
                      //                 fontWeight: FontWeight.bold,
                      //               )),
                      //           TextSpan(
                      //               text: ' ' + _peleOrMaradona,
                      //               style: GoogleFonts.trykker(
                      //                 color: textColor,
                      //                 fontSize: 19,
                      //                 fontWeight: FontWeight.w300,
                      //               )),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ),
                  ));
            }
          }()),
          (() {
            if (_staffPosition.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: shapeDecorationColorTwo.withAlpha(50),
                      borderRadius: BorderRadius.circular(10)),
                  child: Material(
                    color: materialBackgroundColor,
                    child: InkWell(
                      splashColor: splashColorThree,
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, top: 15, left: 25),
                        child: Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: staffPositionTitle,
                                  style: GoogleFonts.aBeeZee(
                                    color: textColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  )),
                              TextSpan(
                                  text: ' $_staffPosition',
                                  style: GoogleFonts.trykker(
                                    color: textColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w300,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Visibility(
                  visible: !_isVisible,
                  child: Container(
                    decoration: BoxDecoration(
                        color: shapeDecorationColorTwo.withAlpha(50),
                        borderRadius: BorderRadius.circular(10)),
                    child: Material(
                      color: materialBackgroundColor,
                      child: InkWell(
                        splashColor: splashColorThree,
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 15, top: 15, left: 25),
                          child: Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: staffPositionTitle,
                                    style: GoogleFonts.aBeeZee(
                                      color: textColor,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                    )),
                                TextSpan(
                                    text: ' $_staffPosition',
                                    style: GoogleFonts.trykker(
                                      color: textColor,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w300,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ));
            }
          }()),
          (() {
            if (_yearOfInception.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: shapeDecorationColorTwo.withAlpha(50),
                      borderRadius: BorderRadius.circular(10)),
                  child: Material(
                    color: materialBackgroundColor,
                    child: InkWell(
                      splashColor: splashColorThree,
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, top: 15, left: 25),
                        child: Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: yearOfInceptionTitle,
                                  style: GoogleFonts.aBeeZee(
                                    color: textColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  )),
                              TextSpan(
                                  text: ' $_yearOfInception',
                                  style: GoogleFonts.trykker(
                                    color: textColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w300,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Visibility(
                  visible: !_isVisible,
                  child: Container(
                    decoration: BoxDecoration(
                        color: shapeDecorationColorTwo.withAlpha(50),
                        borderRadius: BorderRadius.circular(10)),
                    child: Material(
                      color: materialBackgroundColor,
                      child: InkWell(
                        splashColor: splashColorThree,
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 15, top: 15, left: 25),
                          child: Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: yearOfInceptionTitle,
                                    style: GoogleFonts.aBeeZee(
                                      color: textColor,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                    )),
                                TextSpan(
                                    text: ' $_yearOfInception',
                                    style: GoogleFonts.trykker(
                                      color: textColor,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w300,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ));
            }
          }()),
          (() {
            if (_bestMoment.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: shapeDecorationColorTwo.withAlpha(50),
                      borderRadius: BorderRadius.circular(10)),
                  child: Material(
                    color: materialBackgroundColor,
                    child: InkWell(
                      splashColor: splashColorThree,
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, top: 15, left: 25),
                        child: Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: bestMomentTitle,
                                  style: GoogleFonts.aBeeZee(
                                    color: textColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  )),
                              TextSpan(
                                  text: ' $_bestMoment',
                                  style: GoogleFonts.trykker(
                                    color: textColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w300,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Visibility(
                  visible: !_isVisible,
                  child: Container(
                    decoration: BoxDecoration(
                        color: shapeDecorationColorTwo.withAlpha(50),
                        borderRadius: BorderRadius.circular(10)),
                    child: Material(
                      color: materialBackgroundColor,
                      // child: InkWell(
                      //   splashColor: splashColorThree,
                      //   onTap: () {},
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(
                      //         bottom: 15, top: 15, left: 25),
                      //     child: Text.rich(
                      //       TextSpan(
                      //         children: <TextSpan>[
                      //           TextSpan(
                      //               text: courseTeachingTitle,
                      //               style: GoogleFonts.aBeeZee(
                      //                 color: textColor,
                      //                 fontSize: 19,
                      //                 fontWeight: FontWeight.bold,
                      //               )),
                      //           TextSpan(
                      //               text: ' ' + _courseTeaching,
                      //               style: GoogleFonts.trykker(
                      //                 color: textColor,
                      //                 fontSize: 19,
                      //                 fontWeight: FontWeight.w300,
                      //               )),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ),
                  ));
            }
          }()),
          (() {
            if (_worstMoment.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: shapeDecorationColorTwo.withAlpha(50),
                      borderRadius: BorderRadius.circular(10)),
                  child: Material(
                    color: materialBackgroundColor,
                    child: InkWell(
                      splashColor: splashColorThree,
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, top: 15, left: 25),
                        child: Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: worstMomentTitle,
                                  style: GoogleFonts.aBeeZee(
                                    color: textColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  )),
                              TextSpan(
                                  text: ' $_worstMoment',
                                  style: GoogleFonts.trykker(
                                    color: textColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w300,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Visibility(
                  visible: !_isVisible,
                  child: Container(
                    decoration: BoxDecoration(
                        color: shapeDecorationColorTwo.withAlpha(50),
                        borderRadius: BorderRadius.circular(10)),
                    child: Material(
                      color: materialBackgroundColor,
                      // child: InkWell(
                      //   splashColor: splashColorThree,
                      //   onTap: () {},
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(
                      //         bottom: 15, top: 15, left: 25),
                      //     child: Text.rich(
                      //       TextSpan(
                      //         children: <TextSpan>[
                      //           TextSpan(
                      //               text: courseTeachingTitle,
                      //               style: GoogleFonts.aBeeZee(
                      //                 color: textColor,
                      //                 fontSize: 19,
                      //                 fontWeight: FontWeight.bold,
                      //               )),
                      //           TextSpan(
                      //               text: ' ' + _courseTeaching,
                      //               style: GoogleFonts.trykker(
                      //                 color: textColor,
                      //                 fontSize: 19,
                      //                 fontWeight: FontWeight.w300,
                      //               )),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ),
                  ));
            }
          }()),
          (() {
            if (_autoBio.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: shapeDecorationColorTwo.withAlpha(50),
                      borderRadius: BorderRadius.circular(10)),
                  child: Material(
                    color: materialBackgroundColor,
                    child: InkWell(
                      splashColor: splashColorThree,
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, top: 15, left: 25),
                        child: Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: autobiographyTitle,
                                  style: GoogleFonts.aBeeZee(
                                    color: textColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  )),
                              TextSpan(
                                  text: ' $_autoBio',
                                  style: GoogleFonts.trykker(
                                    color: textColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w300,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Visibility(
                  visible: !_isVisible,
                  child: Container(
                    decoration: BoxDecoration(
                        color: shapeDecorationColorTwo.withAlpha(50),
                        borderRadius: BorderRadius.circular(10)),
                    child: Material(
                      color: materialBackgroundColor,
                      child: InkWell(
                        splashColor: splashColorThree,
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 15, top: 15, left: 25),
                          child: Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: autobiographyTitle,
                                    style: GoogleFonts.aBeeZee(
                                      color: textColor,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                    )),
                                TextSpan(
                                    text: ' $_autoBio',
                                    style: GoogleFonts.trykker(
                                      color: textColor,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w300,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ));
            }
          }()),
          (() {
            if (_country.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: shapeDecorationColorTwo.withAlpha(50),
                      borderRadius: BorderRadius.circular(10)),
                  child: Material(
                    color: materialBackgroundColor,
                    child: InkWell(
                      splashColor: splashColorThree,
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, top: 15, left: 25),
                        child: Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: countryTitle,
                                  style: GoogleFonts.aBeeZee(
                                    color: textColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  )),
                              TextSpan(
                                  text: ' $_country',
                                  style: GoogleFonts.trykker(
                                    color: textColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w300,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Visibility(
                  visible: !_isVisible,
                  child: Container(
                    decoration: BoxDecoration(
                        color: shapeDecorationColorTwo.withAlpha(50),
                        borderRadius: BorderRadius.circular(10)),
                    child: Material(
                      color: materialBackgroundColor,
                      // child: InkWell(
                      //   splashColor: splashColorThree,
                      //   onTap: () {},
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(
                      //         bottom: 15, top: 15, left: 25),
                      //     child: Text.rich(
                      //       TextSpan(
                      //         children: <TextSpan>[
                      //           TextSpan(
                      //               text: qualificationTitle,
                      //               style: GoogleFonts.aBeeZee(
                      //                 color: textColor,
                      //                 fontSize: 19,
                      //                 fontWeight: FontWeight.bold,
                      //               )),
                      //           TextSpan(
                      //               text: ' ' + _qualification,
                      //               style: GoogleFonts.trykker(
                      //                 color: textColor,
                      //                 fontSize: 19,
                      //                 fontWeight: FontWeight.w300,
                      //               )),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ),
                  ));
            }
          }()),
          (() {
            if (_regionFrom.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: shapeDecorationColorTwo.withAlpha(50),
                      borderRadius: BorderRadius.circular(10)),
                  child: Material(
                    color: materialBackgroundColor,
                    child: InkWell(
                      splashColor: splashColorThree,
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, top: 15, left: 25),
                        child: Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: regionOfOriginTitle,
                                  style: GoogleFonts.aBeeZee(
                                    color: textColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  )),
                              TextSpan(
                                  text: ' $_regionFrom',
                                  style: GoogleFonts.trykker(
                                    color: textColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w300,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Visibility(
                  visible: !_isVisible,
                  child: Container(
                    decoration: BoxDecoration(
                        color: shapeDecorationColorTwo.withAlpha(50),
                        borderRadius: BorderRadius.circular(10)),
                    child: Material(
                      color: materialBackgroundColor,
                      child: InkWell(
                        splashColor: splashColorThree,
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 15, top: 15, left: 25),
                          child: Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: regionOfOriginTitle,
                                    style: GoogleFonts.aBeeZee(
                                      color: textColor,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                    )),
                                TextSpan(
                                    text: ' $_regionFrom',
                                    style: GoogleFonts.trykker(
                                      color: textColor,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w300,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ));
            }
          }()),
          (() {
            if (_hobbies.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: shapeDecorationColorTwo.withAlpha(50),
                      borderRadius: BorderRadius.circular(10)),
                  child: Material(
                    color: materialBackgroundColor,
                    child: InkWell(
                      splashColor: splashColorThree,
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, top: 15, left: 25),
                        child: Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: hobbiesTitle,
                                  style: GoogleFonts.aBeeZee(
                                    color: textColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  )),
                              TextSpan(
                                  text: ' $_hobbies',
                                  style: GoogleFonts.trykker(
                                    color: textColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w300,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Visibility(
                  visible: !_isVisible,
                  child: Container(
                    decoration: BoxDecoration(
                        color: shapeDecorationColorTwo.withAlpha(50),
                        borderRadius: BorderRadius.circular(10)),
                    child: Material(
                      color: materialBackgroundColor,
                      child: InkWell(
                        splashColor: splashColorThree,
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 15, top: 15, left: 25),
                          child: Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: hobbiesTitle,
                                    style: GoogleFonts.aBeeZee(
                                      color: textColor,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                    )),
                                TextSpan(
                                    text: ' $_hobbies',
                                    style: GoogleFonts.trykker(
                                      color: textColor,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w300,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ));
            }
          }()),
          (() {
            if (_philosophy.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: shapeDecorationColorTwo.withAlpha(50),
                      borderRadius: BorderRadius.circular(10)),
                  child: Material(
                    color: materialBackgroundColor,
                    child: InkWell(
                      splashColor: splashColorThree,
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15, top: 15, left: 25),
                        child: Text.rich(
                          TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: philosophyTitle,
                                  style: GoogleFonts.aBeeZee(
                                    color: textColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  )),
                              TextSpan(
                                  text: ' $_philosophy',
                                  style: GoogleFonts.trykker(
                                    color: textColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w300,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Visibility(
                  visible: !_isVisible,
                  child: Container(
                    decoration: BoxDecoration(
                        color: shapeDecorationColorTwo.withAlpha(50),
                        borderRadius: BorderRadius.circular(10)),
                    child: Material(
                      color: materialBackgroundColor,
                      child: InkWell(
                        splashColor: splashColorThree,
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 15, top: 15, left: 25),
                          child: Text.rich(
                            TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: philosophyTitle,
                                    style: GoogleFonts.aBeeZee(
                                      color: textColor,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                    )),
                                TextSpan(
                                    text: ' $_philosophy',
                                    style: GoogleFonts.trykker(
                                      color: textColor,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w300,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ));
            }
          }()),
        ],
      ),
    };
    super.initState();
  }

  int sharedValue = 0;

  facebookLink() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        backgroundColor: backgroundColor,
        title: Text(
          facebookProfileSharedPreferencesTitle,
          style: TextStyle(color: cardBackgroundColor),
        ),
        content: Text(
          facebookProfileSharedPreferencesContentOne +
              _facebook +
              facebookProfileSharedPreferencesContentTwo,
          textAlign: TextAlign.justify,
          style: TextStyle(color: cardBackgroundColor),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              launchURL(urlFacebook);
              Toast.show("Loading up Facebook.com",
                  duration: Toast.lengthLong,
                  gravity: Toast.bottom,
                  webTexColor: cardBackgroundColor,
                  backgroundColor: backgroundColor,
                  backgroundRadius: 10);
            },
            child: Text(
              facebookProfileSharedPreferencesButton,
              style: TextStyle(color: cardBackgroundColor),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              facebookProfileSharedPreferencesButtonTwo,
              style: TextStyle(color: cardBackgroundColor),
            ),
          ),
        ],
      ),
    );
//    }
  }

  linkedInLink() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        backgroundColor: backgroundColor,
        title: Text(
          linkedInProfileSharedPreferencesTitle,
          style: TextStyle(color: cardBackgroundColor),
        ),
        content: Text(
          linkedInProfileSharedPreferencesContentOne +
              _linkedIn +
              linkedInProfileSharedPreferencesContentTwo,
          textAlign: TextAlign.justify,
          style: TextStyle(color: cardBackgroundColor),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              launchURL(urlLinkedIn);
              Toast.show("Loading up LinkedIn.com",
                  duration: Toast.lengthLong,
                  gravity: Toast.bottom,
                  webTexColor: cardBackgroundColor,
                  backgroundColor: backgroundColor,
                  backgroundRadius: 10);
            },
            child: Text(
              linkedInProfileSharedPreferencesButton,
              style: TextStyle(color: cardBackgroundColor),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              linkedInProfileSharedPreferencesButtonTwo,
              style: TextStyle(color: cardBackgroundColor),
            ),
          ),
        ],
      ),
    );
//    }
  }

  @override
  void dispose() {
    _confettiController?.dispose();
    super.dispose();
  }
}
