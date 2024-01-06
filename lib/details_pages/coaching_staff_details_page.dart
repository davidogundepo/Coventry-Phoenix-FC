import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';
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
String whyLoveFootballCoachingTitle = "What made me move into Football Coaching\n";
String sportingIconTitle = "Who is my favourite sporting icon\n";
String yearOfInceptionTitle = "Year of Inception with $clubName\n";
String regionOfOriginTitle = "My Region of Origin\n";
String hobbiesTitle = "My Hobbies\n";
String philosophyTitle = "My Philosophy about Life\n";
String dobTitle = "My Birthday\n";

String facebookProfileSharedPreferencesTitle = "Manual Website Search";
String facebookProfileSharedPreferencesContentOne = "Apparently, you'd need to search manually for ";
String facebookProfileSharedPreferencesContentTwo = ", on Facebook.com";
String facebookProfileSharedPreferencesButton = "Go to Facebook";
String facebookProfileSharedPreferencesButtonTwo = "Lol, No";

String linkedInProfileSharedPreferencesTitle = "Manual Website Search";
String linkedInProfileSharedPreferencesContentOne = "Apparently, you'd need to search manually for ";
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
dynamic _dob;
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
  // final _formKey = GlobalKey<FormState>();
  String otpCode = "";
  bool isLoaded = false;
  final FirebaseAuth auth = FirebaseAuth.instance;
  String _receivedId = ""; // Add this line
  bool isOTPComplete = false;
  bool isOtpVerified = false; // Add this variable
  // Declare a boolean variable to track OTP generation
  bool isOtpGenerated = false;

  bool isModifyingAutobiography = true; // Assuming modifying autobiography by default

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
      scaffoldMessenger.showSnackBar(const SnackBar(content: Text("The required App not installed")));
    }
  }

  // Define variables to store form input
  final TextEditingController _myClubInceptionController = TextEditingController();
  final TextEditingController _myATFavController = TextEditingController();
  final TextEditingController _myBestMomentInClubController = TextEditingController();
  final TextEditingController _myWorstMomentInClubController = TextEditingController();
  final TextEditingController _myHobbiesController = TextEditingController();
  final TextEditingController _myNationalityController = TextEditingController();
  final TextEditingController _myPhilosophyController = TextEditingController();
  final TextEditingController _myRegionOfOriginController = TextEditingController();
  final TextEditingController _myAutobiographyController = TextEditingController();
  final TextEditingController _myWhyLoveForCoachingController = TextEditingController();

  final TextEditingController commentController = TextEditingController();

  String _selectedCoachingTeamPositionRole = 'Select One'; // Default value

  final List<String> _coachingTeamOptions = [
    'Select One',
    'Coventry Phoenix 1sts',
    'Coventry Phoenix Reserves',
    'Coventry Phoenix 3rds',
    "Coventry Phoenix U'18s",
    "Coventry Phoenix O'35s",
  ];

  DateTime selectedDateA = DateTime(2023, 12, 25, 14, 15);
  DateTime? date;

  String getFormattedDate(DateTime date) {
    String day = DateFormat('d').format(date);
    String suffix = getDaySuffix(int.parse(day));

    return DateFormat("d'$suffix' MMMM").format(date);
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

  String? formattedDate;

  // Create a GlobalKey for the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Firebase Firestore instance
  final firestore = FirebaseFirestore.instance;

  // Implement a function to handle form submission
  Future<void> _submitForm() async {
    String fullName2 = _name;

    if (_formKey.currentState!.validate()) {
      final firestore = FirebaseFirestore.instance;
      final clubInceptionName = _myClubInceptionController.text;
      final atFavName = _myATFavController.text;
      final bestMomentInClubName = _myBestMomentInClubController.text;
      final worstMomentInClubName = _myWorstMomentInClubController.text;
      final hobbiesName = _myHobbiesController.text;
      final nationalityName = _myNationalityController.text;
      final regionOfOriginName = _myRegionOfOriginController.text;
      final autobiographyName = _myAutobiographyController.text;
      final philosophyName = _myPhilosophyController.text;
      final whyLoveForCoachingName = _myWhyLoveForCoachingController.text;
      final fullName = fullName2;

      String collectionName = 'Coaches';

      // Find the corresponding document in the firestore by querying for the full name
      QuerySnapshot querySnapshot = await firestore.collection(collectionName).where('name', isEqualTo: fullName).get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the first document from the query results
        DocumentSnapshot documentSnapshot = querySnapshot.docs[0];

        // Update the fields with the new data, but only if the value is not "select"
        if (_selectedCoachingTeamPositionRole != "Select One") {
          documentSnapshot.reference.update({'staff_position': _selectedCoachingTeamPositionRole});
        } else {
          documentSnapshot.reference.update({'staff_position': ''});
        }

        if (getFormattedDate(selectedDateA).toUpperCase() != "25TH DECEMBER") {
          documentSnapshot.reference.update({
            'd_o_b': getFormattedDate(selectedDateA).toUpperCase(),
          });
        }

        // Update the fields with the new data
        await documentSnapshot.reference.update({
          'autobio': autobiographyName,
          'best_moment': bestMomentInClubName,
          'nationality': nationalityName,
          'region_of_origin': regionOfOriginName,
          'fav_sporting_icon': atFavName,
          'year_of_inception': clubInceptionName,
          'hobbies': hobbiesName,
          'philosophy': philosophyName,
          'worst_moment': worstMomentInClubName,
          'why_you_love_coaching_or_fc_management': whyLoveForCoachingName,
        });

        Fluttertoast.showToast(
          msg: 'Success! Your Autobiography is updated', // Show success message (you can replace it with actual banner generation logic)
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.deepOrangeAccent,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Hmm, strange, Error updating profile'),
          ),
        );
      }
    }
  }

  ////

  // final ImagePicker _picker = ImagePicker();
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  File? _imageOne;
  File? _imageTwo;
  // String _userName = _name;

  Future<void> uploadImagesToStorageAndFirestore(List<File> imageFiles) async {
    try {
      // Find the document ID for the user with the specified name (_name)
      String _queryName = _name.toLowerCase().replaceAll(" ", "");

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Coaches').get();

      String? documentId;

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        String documentName = document['name'].toLowerCase().replaceAll(" ", "");
        if (documentName == _queryName) {
          // Found the document with the matching name
          documentId = document.id;
          break; // Exit the loop since we found the document
        }
      }

      if (documentId != null) {
        for (int i = 0; i < imageFiles.length; i++) {
          String imageName = '$_queryName${i + 1}.jpg';

          // Upload each image to Firebase Storage
          final Reference storageReference = FirebaseStorage.instance.ref().child('coaches').child(_queryName).child(imageName);
          final UploadTask uploadTask = storageReference.putFile(imageFiles[i]);
          await uploadTask.whenComplete(() {});

          // Get download URL of the uploaded image
          final String imageUrl = await storageReference.getDownloadURL();

          // Store the image reference (download URL) in Firestore under the user's name
          String imageField = i == 0 ? 'image' : 'image_two'; // Set the field name based on the image index

          // Update the existing document for the specified user (_queryName)
          await FirebaseFirestore.instance.collection('Coaches').doc(documentId).update({
            imageField: imageUrl,
          });
        }
        // Show success toast
        Fluttertoast.showToast(
          msg: "Images uploaded and references stored successfully.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.deepOrangeAccent,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        print('Images uploaded and references stored successfully.');
      } else {
        print('User with name $_queryName not found.');
      }
    } catch (e) {
      print('Error uploading images and storing references: $e');
      // Show error toast
      Fluttertoast.showToast(
        msg: "Error uploading images and storing references.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> _checkAndUpdatePhoto() async {
    if (_imageOne != null || _imageTwo != null) {
      List<File> imagesToUpload = [];

      if (_imageOne != null) {
        imagesToUpload.add(_imageOne!);
      }

      if (_imageTwo != null) {
        imagesToUpload.add(_imageTwo!);
      }

      // Call the function to upload images to Firebase Storage and update Firestore
      await uploadImagesToStorageAndFirestore(imagesToUpload);
    } else {
      // Show toast message if no images are selected
      Fluttertoast.showToast(
        msg: "Please select at least one image.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.deepOrangeAccent,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<File?> pickImageOne(BuildContext context) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        _imageOne = File(pickedImage.path);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Hmm something is off, please try again',
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.deepOrangeAccent,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    return _imageOne;
  }

  Future<File?> pickImageTwo(BuildContext context) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        _imageTwo = File(pickedImage.path);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Hmm something is off, please try again',
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.deepOrangeAccent,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    return _imageTwo;
  }

  // for selecting imageOne
  void selectImageOne() async {
    _imageOne = await pickImageOne(context);
    setState(() {});
  }

  // for selecting imageTwo
  void selectImageTwo() async {
    _imageTwo = await pickImageTwo(context);
    setState(() {});
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
          actions: [
            PopupMenuButton(
                color: const Color.fromRGBO(255, 255, 255, 1.0),
                icon: const Icon(
                  Icons.menu,
                  color: Color.fromRGBO(255, 255, 255, 1.0),
                ),
                itemBuilder: (context) => [
                      const PopupMenuItem<int>(
                        value: 0,
                        child: Text(
                          "Modify your Autobiography",
                          style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1.0)),
                        ),
                      ),
                      const PopupMenuItem<int>(
                        value: 1,
                        child: Text(
                          "Modify your Images",
                          style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1.0)),
                        ),
                      ),
                      const PopupMenuItem<int>(
                        value: 2,
                        child: Text(
                          "Club Performance Feedback",
                          style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1.0)),
                        ),
                      ),
                    ],
                onSelected: (item) async {
                  setState(() {
                    // Set the flag based on the selected item
                    isModifyingAutobiography = item == 0;
                  });

                  if (item == 2) {
                    // Fluttertoast.showToast(
                    //   msg: 'Coming soon. Thanks',
                    //   // Show success message (you can replace it with actual banner generation logic)
                    //   gravity: ToastGravity.CENTER,
                    //   backgroundColor: Colors.white,
                    //   textColor: Colors.black,
                    //   fontSize: 16.0,
                    // );

                    addCoachesCommentDialog(context);
                  }
                  else {
                    modifyProfile(); // Use modifyProfile function instead of _showAutobiographyModificationDialog or _showImageModificationDialog
                  }
                }),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              if (coachesNotifier.currentCoaches.imageTwo.toString().isEmpty) ...[
                Tooltip(
                    message: coachesNotifier.currentCoaches.name,
                    child: GestureDetector(
                      onTap: () => setState(() {
                        crossFadeView = crossFadeView == CrossFadeState.showFirst ? CrossFadeState.showSecond : CrossFadeState.showFirst;
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
                            crossFadeState: crossFadeView == CrossFadeState.showFirst ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                            duration: const Duration(milliseconds: 1000),
                            firstChild: CachedNetworkImage(
                              imageUrl: coachesNotifier.currentCoaches.image!,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(MdiIcons.alertRhombus),
                            ),
                            secondChild: CachedNetworkImage(
                              imageUrl: coachesNotifier.currentCoaches.image!,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(MdiIcons.alertRhombus),
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
                        crossFadeView = crossFadeView == CrossFadeState.showFirst ? CrossFadeState.showSecond : CrossFadeState.showFirst;
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
                            crossFadeState: crossFadeView == CrossFadeState.showFirst ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                            duration: const Duration(milliseconds: 1000),
                            firstChild: CachedNetworkImage(
                              imageUrl: coachesNotifier.currentCoaches.image!,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(MdiIcons.alertRhombus),
                            ),
                            secondChild: CachedNetworkImage(
                              imageUrl: coachesNotifier.currentCoaches.imageTwo!,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(MdiIcons.alertRhombus),
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
                      borderSide: BorderSide(color: shapeDecorationColor.withOpacity(0.80), width: 4.0, style: BorderStyle.solid),
                    ),
                    margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0, bottom: 16.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              coachesNotifier.currentCoaches.name!.toUpperCase(),
                              style: GoogleFonts.blinker(color: shapeDecorationTextColorTwo, fontSize: 30, fontWeight: FontWeight.w500),
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
                  padding: const EdgeInsets.only(top: 20, bottom: 20, left: 8.0, right: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                            child: Container(
                              decoration: BoxDecoration(color: shapeDecorationColor.withAlpha(70)),
                              // borderRadius: BorderRadius.circular(10)),
                              child: Material(
                                color: shapeDecorationColor.withAlpha(70),
                                child: InkWell(
                                  splashColor: splashColorThree,
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8, top: 8, left: 14, right: 14),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        padding: const EdgeInsets.all(4),
                                      ),
                                      child: Text(
                                        // _name.replaceAll(" ", "'s'") + autoBioDetails,
                                        _name.substring(0, _name.indexOf(' ')) + "'s" + autoBioDetails,
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
                            if (_autoBio.toString().isNotEmpty ||
                                _bestMoment.toString().isNotEmpty ||
                                _dob.toString().isNotEmpty ||
                                _hobbies.toString().isNotEmpty ||
                                _philosophy.toString().isNotEmpty ||
                                _country.toString().isNotEmpty ||
                                _regionFrom.toString().isNotEmpty ||
                                _yearOfInception.toString().isNotEmpty ||
                                _staffPosition.toString().isNotEmpty ||
                                _whyLoveFootballCoaching.toString().isNotEmpty ||
                                _sportingIcon.toString().isNotEmpty ||
                                _worstMoment.toString().isNotEmpty) {
                              return Visibility(
                                visible: !_isVisible,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Container(
                                    decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                                    child: Material(
                                      color: materialBackgroundColor,
                                      child: InkWell(
                                        splashColor: splashColorThree,
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
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
                                                    text: _autoBio,
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
                                ),
                              );
                            } else {
                              return Visibility(
                                  visible: _isVisible,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Container(
                                      decoration:
                                          BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                                      child: Material(
                                        color: materialBackgroundColor,
                                        child: InkWell(
                                          splashColor: splashColorThree,
                                          onTap: () {},
                                          child: Padding(
                                            padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
                                            child: Text.rich(
                                              TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: 'No Information\n',
                                                      style: GoogleFonts.aBeeZee(
                                                        color: textColor,
                                                        fontSize: 19,
                                                        fontWeight: FontWeight.bold,
                                                      )),
                                                  TextSpan(
                                                      text: " ${_name.substring(0, _name.indexOf(' '))} hasn't filled his data",
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
                                  ));
                            }
                          }()),
                          (() {
                            if (_whyLoveFootballCoaching.toString().isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                                  child: Material(
                                    color: materialBackgroundColor,
                                    child: InkWell(
                                      splashColor: splashColorThree,
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
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
                                    decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                  decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                                  child: Material(
                                    color: materialBackgroundColor,
                                    child: InkWell(
                                      splashColor: splashColorThree,
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
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
                                    decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                  decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                                  child: Material(
                                    color: materialBackgroundColor,
                                    child: InkWell(
                                      splashColor: splashColorThree,
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
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
                                    decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                                    child: Material(
                                      color: materialBackgroundColor,
                                      child: InkWell(
                                        splashColor: splashColorThree,
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
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
                                  decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                                  child: Material(
                                    color: materialBackgroundColor,
                                    child: InkWell(
                                      splashColor: splashColorThree,
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
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
                                    decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                                    child: Material(
                                      color: materialBackgroundColor,
                                      child: InkWell(
                                        splashColor: splashColorThree,
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
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
                                  decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                                  child: Material(
                                    color: materialBackgroundColor,
                                    child: InkWell(
                                      splashColor: splashColorThree,
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
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
                                    decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                  decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                                  child: Material(
                                    color: materialBackgroundColor,
                                    child: InkWell(
                                      splashColor: splashColorThree,
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
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
                                    decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                  decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                                  child: Material(
                                    color: materialBackgroundColor,
                                    child: InkWell(
                                      splashColor: splashColorThree,
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
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
                                    decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                                    child: Material(
                                      color: materialBackgroundColor,
                                      child: InkWell(
                                        splashColor: splashColorThree,
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
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
                                                    text: " ${_name.substring(0, _name.indexOf(' '))} hasn't filled his data",
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
                                  decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                                  child: Material(
                                    color: materialBackgroundColor,
                                    child: InkWell(
                                      splashColor: splashColorThree,
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
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
                                    decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                  decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                                  child: Material(
                                    color: materialBackgroundColor,
                                    child: InkWell(
                                      splashColor: splashColorThree,
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
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
                                    decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                                    child: Material(
                                      color: materialBackgroundColor,
                                      child: InkWell(
                                        splashColor: splashColorThree,
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
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
                            if (_dob.toString().isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                                  child: Material(
                                    color: materialBackgroundColor,
                                    child: InkWell(
                                      splashColor: splashColorThree,
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
                                        child: Text.rich(
                                          TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: dobTitle,
                                                  style: GoogleFonts.aBeeZee(
                                                    color: textColor,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              TextSpan(
                                                  text: ' $_dob',
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
                                    decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                                    child: Material(
                                      color: materialBackgroundColor,
                                      child: InkWell(
                                        splashColor: splashColorThree,
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
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
                                  decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                                  child: Material(
                                    color: materialBackgroundColor,
                                    child: InkWell(
                                      splashColor: splashColorThree,
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
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
                                    decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                                    child: Material(
                                      color: materialBackgroundColor,
                                      child: InkWell(
                                        splashColor: splashColorThree,
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
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
                                  decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                                  child: Material(
                                    color: materialBackgroundColor,
                                    child: InkWell(
                                      splashColor: splashColorThree,
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
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
                                    decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                                    child: Material(
                                      color: materialBackgroundColor,
                                      child: InkWell(
                                        splashColor: splashColorThree,
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
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

  Future<DateTime?> pickDate() => showDatePicker(
      context: context, initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime(2100), barrierColor: backgroundColor);

  @override
  initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _confettiController = ConfettiController(duration: const Duration(seconds: 7));
    _confettiController?.play();

    CoachesNotifier coachesNotifier = Provider.of<CoachesNotifier>(context, listen: false);

    _autoBio = coachesNotifier.currentCoaches.autoBio;
    _dob = coachesNotifier.currentCoaches.dob;
    _staffPosition = coachesNotifier.currentCoaches.staffPosition;
    _bestMoment = coachesNotifier.currentCoaches.bestMoment;
    _worstMoment = coachesNotifier.currentCoaches.worstMoment;
    _country = coachesNotifier.currentCoaches.nationality;
    _whyLoveFootballCoaching = coachesNotifier.currentCoaches.whyLoveCoachingOrFCManagement;
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

    loadFormData();

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
                      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: Icon(MdiIcons.dialpad, color: iconTextColor),
                    label: Text(callButton, style: GoogleFonts.abel(color: iconTextColor, fontSize: 18, fontWeight: FontWeight.w300)),
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
                        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      icon: Icon(MdiIcons.dialpad, color: iconTextColor),
                      label: Text(callButton, style: GoogleFonts.abel(color: iconTextColor, fontSize: 18, fontWeight: FontWeight.w300)),
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
                      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: Icon(MdiIcons.message, color: iconTextColor),
                    label: Text(messageButton, style: GoogleFonts.abel(color: iconTextColor, fontSize: 18, fontWeight: FontWeight.w300)),
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
                        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      icon: Icon(MdiIcons.message, color: iconTextColor),
                      label: Text(messageButton, style: GoogleFonts.abel(color: iconTextColor, fontSize: 18, fontWeight: FontWeight.w300)),
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
                      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: Icon(MdiIcons.whatsapp, color: iconTextColor),
                    label: Text(whatsAppButton, style: GoogleFonts.abel(color: iconTextColor, fontSize: 18, fontWeight: FontWeight.w300)),
                    onPressed: () {
                      if (_phone.toString().startsWith('0')) {
                        var most = _phone.toString().substring(1);
                        var firstName = _name.toString().substring(0, _name.toString().indexOf(" "));
                        launchURL(whatsAppFIRST + most + whatsAppSECOND + firstName + whatsAppTHIRD);
                      } else {
                        var firstName = _name.toString().substring(0, _name.toString().indexOf(" "));
                        launchURL(whatsAppFIRST + _phone + whatsAppSECOND + firstName + whatsAppTHIRD);
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
                        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      icon: Icon(MdiIcons.message, color: iconTextColor),
                      label: Text(messageButton, style: GoogleFonts.abel(color: iconTextColor, fontSize: 18, fontWeight: FontWeight.w300)),
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
                      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: Icon(MdiIcons.gmail, color: iconTextColor),
                    label: Text(emailButton, style: GoogleFonts.abel(color: iconTextColor, fontSize: 18, fontWeight: FontWeight.w300)),
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
                        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      icon: Icon(MdiIcons.gmail, color: iconTextColor),
                      label: Text(emailButton, style: GoogleFonts.abel(color: iconTextColor, fontSize: 18, fontWeight: FontWeight.w300)),
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
                      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: Icon(MdiIcons.twitter, color: iconTextColor),
                    label: Text(twitterButton, style: GoogleFonts.abel(color: iconTextColor, fontSize: 18, fontWeight: FontWeight.w300)),
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
                        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      icon: Icon(MdiIcons.twitter, color: iconTextColor),
                      label: Text(twitterButton, style: GoogleFonts.abel(color: iconTextColor, fontSize: 18, fontWeight: FontWeight.w300)),
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
                      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    icon: Icon(MdiIcons.instagram, color: iconTextColor),
                    label: Text(instagramButton, style: GoogleFonts.abel(color: iconTextColor, fontSize: 18, fontWeight: FontWeight.w300)),
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
                        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      icon: Icon(MdiIcons.instagram, color: iconTextColor),
                      label: Text(instagramButton, style: GoogleFonts.abel(color: iconTextColor, fontSize: 18, fontWeight: FontWeight.w300)),
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
                      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      icon: Icon(MdiIcons.facebook, color: iconTextColor),
                      label: Text(
                        'My Facebook',
                        style: GoogleFonts.abel(color: iconTextColor, fontSize: 18, fontWeight: FontWeight.w300),
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
                      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                  decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                  child: Material(
                    color: materialBackgroundColor,
                    child: InkWell(
                      splashColor: splashColorThree,
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
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
                    decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                  decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                  child: Material(
                    color: materialBackgroundColor,
                    child: InkWell(
                      splashColor: splashColorThree,
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
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
                    decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                  decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                  child: Material(
                    color: materialBackgroundColor,
                    child: InkWell(
                      splashColor: splashColorThree,
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
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
                    decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                    child: Material(
                      color: materialBackgroundColor,
                      child: InkWell(
                        splashColor: splashColorThree,
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
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
                  decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                  child: Material(
                    color: materialBackgroundColor,
                    child: InkWell(
                      splashColor: splashColorThree,
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
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
                    decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                    child: Material(
                      color: materialBackgroundColor,
                      child: InkWell(
                        splashColor: splashColorThree,
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
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
                  decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                  child: Material(
                    color: materialBackgroundColor,
                    child: InkWell(
                      splashColor: splashColorThree,
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
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
                    decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                  decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                  child: Material(
                    color: materialBackgroundColor,
                    child: InkWell(
                      splashColor: splashColorThree,
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
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
                    decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                  decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                  child: Material(
                    color: materialBackgroundColor,
                    child: InkWell(
                      splashColor: splashColorThree,
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
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
                    decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                    child: Material(
                      color: materialBackgroundColor,
                      child: InkWell(
                        splashColor: splashColorThree,
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
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
                  decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                  child: Material(
                    color: materialBackgroundColor,
                    child: InkWell(
                      splashColor: splashColorThree,
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
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
                    decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                  decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                  child: Material(
                    color: materialBackgroundColor,
                    child: InkWell(
                      splashColor: splashColorThree,
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
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
                    decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                    child: Material(
                      color: materialBackgroundColor,
                      child: InkWell(
                        splashColor: splashColorThree,
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
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
                  decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                  child: Material(
                    color: materialBackgroundColor,
                    child: InkWell(
                      splashColor: splashColorThree,
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
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
                    decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                    child: Material(
                      color: materialBackgroundColor,
                      child: InkWell(
                        splashColor: splashColorThree,
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
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
                  decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                  child: Material(
                    color: materialBackgroundColor,
                    child: InkWell(
                      splashColor: splashColorThree,
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
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
                    decoration: BoxDecoration(color: shapeDecorationColorTwo.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                    child: Material(
                      color: materialBackgroundColor,
                      child: InkWell(
                        splashColor: splashColorThree,
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15, top: 15, left: 25),
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

  Future<void> loadFormData() async {
    String collectionName = 'Coaches';

    try {
      // Query the Firestore collection
      QuerySnapshot querySnapshot = await firestore.collection(collectionName).where('name', isEqualTo: _name).limit(1).get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the first document from the query results
        DocumentSnapshot documentSnapshot = querySnapshot.docs[0];

        // Set the initial values for your form fields based on the data from Firebase
        setState(() {
          _myClubInceptionController.text = documentSnapshot['year_of_inception'];
          _myATFavController.text = documentSnapshot['fav_sporting_icon'];
          _myBestMomentInClubController.text = documentSnapshot['best_moment'];
          _myWorstMomentInClubController.text = documentSnapshot['worst_moment'];
          _myHobbiesController.text = documentSnapshot['hobbies'];
          _myNationalityController.text = documentSnapshot['nationality'];
          _myRegionOfOriginController.text = documentSnapshot['region_of_origin'];
          _myAutobiographyController.text = documentSnapshot['autobio'];
          _myPhilosophyController.text = documentSnapshot['philosophy'];
          _myWhyLoveForCoachingController.text = documentSnapshot['why_you_love_coaching_or_fc_management'];

          formattedDate = documentSnapshot['d_o_b'] ?? getFormattedDate(selectedDateA).toUpperCase();

          // _selectedCoachingTeamPositionRole = documentSnapshot['staff_position'] ?? 'Select One';

          if (documentSnapshot['staff_position'] == "") {
            _selectedCoachingTeamPositionRole = 'Select One';
          } else {
            _selectedCoachingTeamPositionRole = documentSnapshot['staff_position'];
          }
        });
      } else {
        print('Document not found.');
      }
    } catch (e) {
      print('Error loading form data: $e');
    }
  }

  Future<void> _sendOtpToPhoneNumber() async {
    // String phoneNumber = "+447541315929"; // Replace with your hardcoded phone number
    String phoneNumber = "+$_phone"; // Replace with your hardcoded phone number

    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Handle auto verification completed (if needed)
          await auth.signInWithCredential(credential);
          print('Logged In Successfully');

          Fluttertoast.showToast(
            msg: 'You’re Welcome',
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.deepOrangeAccent,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        },
        verificationFailed: (FirebaseAuthException e) {
          // Handle verification failed
          print("Verification failed: ${e.message}");

          Fluttertoast.showToast(
            msg: 'Hmm. Check your Internet Connection or maybe too many OTP requests',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.deepOrangeAccent,
            textColor: Colors.white,
            fontSize: 16.0,
          );

          // You might want to handle the error here or throw an exception
          throw Exception("Error sending OTP: ${e.message}");
        },
        codeSent: (String verificationId, int? resendToken) async {
          // Save the verification ID to use it later
          _receivedId = verificationId;

          // Display a message to the user to check their messages for the OTP
          Fluttertoast.showToast(
            msg: 'Success! OTP sent to your phone number',
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.deepOrangeAccent,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          // Optionally, you can set a timer to automatically fill the OTP field after some delay
          // For example, wait for 30 seconds before filling the OTP field
          await Future.delayed(const Duration(seconds: 5));

          // Once OTP is successfully sent, set isOtpGenerated to true
          setState(() {
            isOtpGenerated = true;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle timeout (if needed)
          print('TimeOut');
        },
      );
    } catch (e) {
      print('Error sending OTP: $e');
      Fluttertoast.showToast(
        msg: 'Error sending OTP. Please try again.',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      // Handle any other errors that might occur during the verification process
      throw Exception("Error sending OTP: $e");
    }
  }

  Future<void> verifyOTPCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _receivedId,
      smsCode: otpCode,
    );
    try {
      await auth.signInWithCredential(credential).then((value) async {
        print('User verification is Successful');

        // Save the verification timestamp only if it's not already set
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? userProperties = prefs.getString('verificationUserProperties');
        String currentProperties = _name; // You can adjust this combination based on your requirements

        if (userProperties == null || userProperties != currentProperties) {
          // Only update the timestamp if the user's properties are not set or have changed
          prefs.setString('verificationUserProperties', currentProperties);
          prefs.setInt('verificationTime', DateTime.now().millisecondsSinceEpoch);
        }

        // // Start the 30-minute timer
        // isUserVerifiedRecently();

        // Set isOtpVerified to true upon successful OTP verification
        setState(() {
          isOtpVerified = true;
        });

        Fluttertoast.showToast(
          msg: 'Verified. Thank you.',
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.deepOrangeAccent,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        // Close the OTP verification dialog upon success
        // Navigator.pop(context);

        // Check if modifying autobiography or image and show the appropriate dialog
        if (isModifyingAutobiography) {
          _showAutobiographyModificationDialog();
        } else {
          _showImageModificationDialog();
        }
      });
    } catch (e) {
      print('Error verifying OTP: $e');
      Fluttertoast.showToast(
        msg: 'OTP incorrect. Please retype.',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.deepOrangeAccent,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // Handle any other errors that might occur during the verification process
      throw Exception("Error verifying OTP: $e");
    }
  }

  void modifyProfile() async {
    if (await isUserVerifiedRecently()) {
      // User has been verified in the last 30 minutes
      // Modify profile without asking for OTP
      if (isModifyingAutobiography) {
        _showAutobiographyModificationDialog();
      } else {
        _showImageModificationDialog();
      }
    } else {
      // User needs to send OTP for verification
      await _showDialogAndVerify(); // Pass the context to the function
      Fluttertoast.showToast(
        msg: "Click 'Generate OTP' first",
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
  }

  Future<void> _showDialogAndVerify() async {
    final GlobalKey<FormState> dialogFormKey = GlobalKey<FormState>();

    showDialog<String>(
      // barrierColor: const Color.fromRGBO(66, 67, 69, 1.0),
        context: context,
        builder: (BuildContext context) => WillPopScope(
          onWillPop: () async {
            // Clear the fields or perform any cleanup actions
            otpCode = '';
            isOTPComplete = false;

            return true; // Allow the dialog to be popped
          },
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            backgroundColor: const Color.fromRGBO(223, 225, 229, 1.0),
            title: const Text(
              "Please click 'Generate OTP', input your OTP from the sent sms.",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  // User needs to send OTP for verification
                  await _sendOtpToPhoneNumber();
                },
                child: const Text('Generate OTP', style: TextStyle(color: Colors.black)),
              ),
              TextButton(
                onPressed: isOTPComplete
                    ? () {
                  verifyOTPCode();
                  setState(() {
                    otpCode = '';
                  });
                  Navigator.of(context).pop(); // Move this line here
                }
                    : null,
                child: const Text('Verify OTP', style: TextStyle(color: Colors.black)),
              ),
            ],
            content: Padding(
              padding: const EdgeInsets.all(6.0),
              child: AbsorbPointer(
                absorbing: !isOtpGenerated,
                child: Form(
                  key: dialogFormKey,
                  child: GestureDetector(
                    onTap: () {
                      // Show toast message if OTP is not generated
                      if (!isOtpGenerated) {
                        Fluttertoast.showToast(
                          msg: 'Please generate OTP first',
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    },
                    child: PinFieldAutoFill(
                      autoFocus: true,
                      currentCode: otpCode,
                      decoration: BoxLooseDecoration(
                        gapSpace: 5,
                        radius: const Radius.circular(8),
                        strokeColorBuilder: isOtpGenerated
                            ? const FixedColorBuilder(Color(0xFFE16641))
                            : const FixedColorBuilder(Colors.grey), // Use grey color if OTP is not generated
                      ),
                      codeLength: 6,
                      onCodeChanged: (code) {
                        print("OnCodeChanged : $code");
                        otpCode = code.toString();
                        isOTPComplete = code!.length == 6;
                      },
                      onCodeSubmitted: (val) {
                        print("OnCodeSubmitted : $val");
                        isOTPComplete = val.isEmpty;
                        otpCode = '';
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Future<bool> isUserVerifiedRecently() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userProperties = prefs.getString('verificationUserProperties');
    String currentProperties = _name; // Adjust this combination based on what you used for verification
    print("User properties from SharedPreferences: $userProperties");

    if (userProperties != null && userProperties == currentProperties) {
      // Check if the last verification was within the last 30 minutes
      int? verificationTime = prefs.getInt('verificationTime');
      if (verificationTime != null) {
        DateTime now = DateTime.now();
        DateTime verificationDateTime = DateTime.fromMillisecondsSinceEpoch(verificationTime);

        return now
            .difference(verificationDateTime)
            .inMinutes <= 30;
      }
    }
    return false;
  }

  void resetVerificationTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('verificationUserProperties');
    prefs.remove('verificationTime');
  }

  void _showAutobiographyModificationDialog() {
    // final GlobalKey<FormState> dialogFormKey = GlobalKey<FormState>();

    showDialog<String>(
      barrierColor: const Color.fromRGBO(66, 67, 69, 1.0),
      context: context,
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: const Color.fromRGBO(223, 225, 229, 1.0),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                DropdownButtonFormField<String>(
                  value: _selectedCoachingTeamPositionRole,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCoachingTeamPositionRole = newValue!;
                    });
                  },
                  items: _coachingTeamOptions.map((role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(
                        role,
                        style: const TextStyle(fontSize: 14),
                      ),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    labelText: 'My Coaching Team',
                    labelStyle: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  cursorColor: Colors.black54,
                  style: GoogleFonts.cabin(color: Colors.black87),
                  controller: _myClubInceptionController,
                  decoration: const InputDecoration(
                    labelText: 'When did you join the football club',
                    labelStyle: TextStyle(fontSize: 14, color: Colors.black54),
                    floatingLabelStyle: TextStyle(color: Colors.black87),
                    hintText: "May 2017",
                    hintStyle: TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  cursorColor: Colors.black54,
                  style: GoogleFonts.cabin(color: Colors.black87),
                  controller: _myATFavController,
                  decoration: const InputDecoration(
                    labelText: 'Your Favourite All Time Sport Icon',
                    labelStyle: TextStyle(fontSize: 14, color: Colors.black54),
                    floatingLabelStyle: TextStyle(color: Colors.black87),
                    hintText: "Maradona",
                    hintStyle: TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  cursorColor: Colors.black54,
                  style: GoogleFonts.cabin(color: Colors.black87),
                  controller: _myBestMomentInClubController,
                  decoration: const InputDecoration(
                    labelText: 'Your Best Moment so far',
                    labelStyle: TextStyle(fontSize: 14, color: Colors.black54),
                    floatingLabelStyle: TextStyle(color: Colors.black87),
                    hintText: "When my team won the championship cup, 2022 ",
                    hintStyle: TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  cursorColor: Colors.black54,
                  style: GoogleFonts.cabin(color: Colors.black87),
                  controller: _myWorstMomentInClubController,
                  decoration: const InputDecoration(
                    labelText: 'Your Worst Moment so far',
                    labelStyle: TextStyle(fontSize: 14, color: Colors.black54),
                    floatingLabelStyle: TextStyle(color: Colors.black87),
                    hintText: "When we conceded too many goals in last year's last match of the season",
                    hintStyle: TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  cursorColor: Colors.black54,
                  style: GoogleFonts.cabin(color: Colors.black87),
                  controller: _myHobbiesController,
                  decoration: const InputDecoration(
                    labelText: 'Your Hobbies',
                    labelStyle: TextStyle(fontSize: 14, color: Colors.black54),
                    floatingLabelStyle: TextStyle(color: Colors.black87),
                    hintText: "Travelling, Megavalanche, Poetry",
                    hintStyle: TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Your Birthday',
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.width * 0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(225, 231, 241, 1.0),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            date = await pickDate();
                            if (date == null) return;

                            final newDateTime =
                            DateTime(date!.year, date!.month, date!.day, selectedDateA.hour, selectedDateA.minute);

                            setState(() {
                              selectedDateA = newDateTime;
                              formattedDate = getFormattedDate(selectedDateA).toUpperCase();
                            });
                          },
                          splashColor: splashColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  formattedDate != "" ? formattedDate!.toUpperCase() : 'Choose your birth date',
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.visible,
                                  style: const TextStyle(
                                    color: Colors.black87,
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
                  ],
                ),
                TextFormField(
                  cursorColor: Colors.black54,
                  style: GoogleFonts.cabin(color: Colors.black87),
                  controller: _myNationalityController,
                  decoration: const InputDecoration(
                    labelText: 'Your Nationality',
                    labelStyle: TextStyle(fontSize: 14, color: Colors.black54),
                    floatingLabelStyle: TextStyle(color: Colors.black87),
                    hintText: "Nigerian",
                    hintStyle: TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  cursorColor: Colors.black54,
                  style: GoogleFonts.cabin(color: Colors.black87),
                  controller: _myRegionOfOriginController,
                  decoration: const InputDecoration(
                    labelText: 'Your Region of Origin',
                    labelStyle: TextStyle(fontSize: 14, color: Colors.black54),
                    floatingLabelStyle: TextStyle(color: Colors.black87),
                    hintText: "Southend-on-Sea, Essex",
                    hintStyle: TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  cursorColor: Colors.black54,
                  style: GoogleFonts.cabin(color: Colors.black87),
                  controller: _myAutobiographyController,
                  decoration: const InputDecoration(
                    labelText: 'Your Autobiography',
                    labelStyle: TextStyle(fontSize: 14, color: Colors.black54),
                    floatingLabelStyle: TextStyle(color: Colors.black87),
                    hintText: "I have coached all over The UK, and played all over Europe",
                    hintStyle: TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  cursorColor: Colors.black54,
                  style: GoogleFonts.cabin(color: Colors.black87),
                  controller: _myPhilosophyController,
                  decoration: const InputDecoration(
                    labelText: 'Your Philosophy',
                    labelStyle: TextStyle(fontSize: 14, color: Colors.black54),
                    floatingLabelStyle: TextStyle(color: Colors.black87),
                    hintText: "When there's no enemy within, the enemy outside can do us no harm",
                    hintStyle: TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  cursorColor: Colors.black54,
                  style: GoogleFonts.cabin(color: Colors.black87),
                  controller: _myWhyLoveForCoachingController,
                  decoration: const InputDecoration(
                    labelText: 'Why do you enjoy football coaching and assisting others realise their full potentials',
                    labelStyle: TextStyle(fontSize: 14, color: Colors.black54),
                    floatingLabelStyle: TextStyle(color: Colors.black87),
                    hintText: "I strongly believe in working  and training with others, I may need them tomorrow",
                    hintStyle: TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () async {
                    await _submitForm();
                    Navigator.pop(context); // Close the dialog
                  },
                  child: const Text('Update Autobiography'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showImageModificationDialog() {
    // final GlobalKey<FormState> dialogFormKey = GlobalKey<FormState>();

    showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: const Color.fromRGBO(223, 225, 229, 1.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * .6,
                      child: const Text(
                        'Click each image to replace your profile pictures',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                // Display the selected images or placeholder icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () => selectImageOne(),
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width / 4.1,
                        height: MediaQuery.sizeOf(context).width / 3.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black.withAlpha(20),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: _imageOne != null
                            ? Image.file(_imageOne!, height: 100, width: 100)
                            : CachedNetworkImage(
                          imageUrl: coachesNotifier.currentCoaches.image!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(MdiIcons.alertRhombus),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => selectImageTwo(),
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width / 4.1,
                        height: MediaQuery.sizeOf(context).width / 3.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black.withAlpha(20),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: _imageTwo != null
                            ? Image.file(_imageTwo!, height: 100, width: 100)
                            : CachedNetworkImage(
                          imageUrl: coachesNotifier.currentCoaches.imageTwo!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(MdiIcons.alertRhombus),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                // Button to upload the selected images to Firebase Storage
                ElevatedButton(
                  onPressed: () async {
                    await _checkAndUpdatePhoto();
                  },
                  child: const Text('Upload Photos'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addCoachesCommentDialog(context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: const Color.fromRGBO(57, 62, 70, 1),
        title: const Text(
          'Provide past-match review analysis',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: commentController,
              decoration: const InputDecoration(
                hintText: 'More goals has been scored this past mon...',
                hintStyle: TextStyle(color: Colors.white38),
              ),
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 11
              ),
              maxLines: 2, // Allow multiple lines for bug description
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String commentDescription = commentController.text.trim();
                commentController.clear();

                // Check if commentDescription is not empty before storing
                if (commentDescription.isNotEmpty) {
                  DateTime currentDateTime = DateTime.now();
                  String formattedTimestamp = DateFormat('MMMM yyyy').format(currentDateTime);

                  // Store bug report in Firestore
                  await FirebaseFirestore.instance.collection('CoachesMonthlyComments').add({
                    'name': coachesNotifier.currentCoaches.name,
                    'image': coachesNotifier.currentCoaches.image,
                    'comment': commentDescription,
                    'month': DateFormat('MM').format(currentDateTime),
                    'year': DateFormat('yyyy').format(currentDateTime),
                    'date': formattedTimestamp,
                    'id': '10',
                  });

                Navigator.pop(context);
                  // You can add a toast or any other UI feedback for successful bug submission
                  Fluttertoast.showToast(
                    msg: 'Thank you, your Comment has been added!',
                    backgroundColor: shapeDecorationColorTwo,
                    textColor: Colors.white,
                    toastLength: Toast.LENGTH_LONG
                  );
                } else {
                  // Show a toast for empty bug description
                  Fluttertoast.showToast(
                    msg: 'Please enter your match description',
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

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
          facebookProfileSharedPreferencesContentOne + _facebook + facebookProfileSharedPreferencesContentTwo,
          textAlign: TextAlign.justify,
          style: TextStyle(color: cardBackgroundColor),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              launchURL(urlFacebook);
              Fluttertoast.showToast(msg: "Loading up Facebook.com", gravity: ToastGravity.BOTTOM, backgroundColor: backgroundColor);
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
          linkedInProfileSharedPreferencesContentOne + _linkedIn + linkedInProfileSharedPreferencesContentTwo,
          textAlign: TextAlign.justify,
          style: TextStyle(color: cardBackgroundColor),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              launchURL(urlLinkedIn);
              Fluttertoast.showToast(msg: "Loading up LinkedIn.com", gravity: ToastGravity.BOTTOM, backgroundColor: backgroundColor);
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
