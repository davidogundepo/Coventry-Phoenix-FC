import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../notifier/first_team_class_notifier.dart';

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
String urlLinkedIn = "https://linkedin.com/";
String urlInstagram = "https://www.instagram.com/";
String urlSnapchat = "https://www.snapchat.com/add/";
String urlTikTok = "https://www.tiktok.com/@";

String reachDetails = "Contacts";
String autoBioDetails = "  AutoBiography";

String callButton = "Call me";
String messageButton = "Send me a Message";
String whatsAppButton = "Send me a WhatsApp Message";
String emailButton = "Send me an Email";
String twitterButton = "My Twitter";
String instagramButton = "My Instagram";
String facebookButton = "My Facebook";
String linkedInButton = "My LinkedIn";
String snapchatButton = "My Snapchat";
String tikTokButton = "My TikTok";

String autobiographyTitle = "My Autobiography\n";
String nicknameTitle = "My Nickname\n";
String bestMomentTitle = "My best moment so far in $clubName\n";
String worstMomentTitle = "My worst moment so far in $clubName\n";
String dreamFCTitle = "My Dream Football Club\n";
String positionPlayingTitle = "My Play Position\n";
String dobTitle = "My Birthday\n";
// String prefectPositionTitle = "Position held as a Prefect\n";
String regionOfOriginTitle = "My Region of Origin\n";
String countryTitle = "My Nationality\n";
String otherPositionsOfPlayTitle = "Other Positions I Can Play\n";
String favFootballLegendTitle = "My All Time Favourite Football Legend\n";
String yearOfInceptionTitle = "Inception with $clubName\n";
String leftOrRightFootedTitle = "Left or Right Footed\n";
String adidasOrNikeTitle = "Adidas or Nike\n";
String ronaldoOrMessiTitle = "Ronaldo or Messi\n";
String hobbiesTitle = "My Hobbies\n";
String philosophyTitle = "My Philosophy about Life\n";
String droplineTitle = "My Dropline to my fellow $clubName footballers\n";

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

Color backgroundColor = const Color.fromRGBO(33, 37, 41, 1.0);
Color appBarTextColor = Colors.white;
Color appBarBackgroundColor = const Color.fromRGBO(33, 37, 41, 1.0);
Color appBarIconColor = Colors.white;
Color materialBackgroundColor = Colors.transparent;
Color shapeDecorationColor = const Color.fromRGBO(33, 37, 41, 1.0);
Color shapeDecorationColorTwo = Colors.white;
Color shapeDecorationColorThree = const Color.fromRGBO(33, 37, 41, 1.0);
Color shapeDecorationTextColor = const Color.fromRGBO(255, 107, 53, 1.0);
Color shapeDecorationIconColor = const Color.fromRGBO(255, 107, 53, 1.0);
Color cardBackgroundColor = Colors.white;
Color splashColor = const Color.fromRGBO(33, 37, 41, 1.0);
Color splashColorTwo = Colors.white;
Color splashColorThree = const Color.fromRGBO(33, 37, 41, 1.0);
Color iconTextColor = Colors.white;
Color iconTextColorTwo = const Color.fromRGBO(33, 37, 41, 1.0);
Color buttonColor = const Color.fromRGBO(33, 37, 41, 1.0);
Color textColor = const Color.fromRGBO(33, 37, 41, 1.0);

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

late FirstTeamClassNotifier firstTeamClassNotifier;

Map<int, Widget>? userBIO;

var crossFadeView = CrossFadeState.showFirst;

dynamic _autoBio;
dynamic _bestMoment;
dynamic _dob;
dynamic _dreamFC;
dynamic _positionPlaying;
dynamic _email;
dynamic _facebook;
dynamic _linkedIn;
dynamic _hobbies;
dynamic _instagram;
dynamic _name;
dynamic _nickname;
dynamic _philosophy;
dynamic _phone;
dynamic _captain;
dynamic _myDropline;
dynamic _prefectPosition;
dynamic _country;
dynamic _regionFrom;
dynamic _snapchat;
dynamic _tikTok;
dynamic _otherPositionsOfPlay;
dynamic _favFootballLegend;
dynamic _yearOfInception;
dynamic _leftOrRightFooted;
dynamic _adidasOrNike;
dynamic _ronaldoOrMessi;
dynamic _twitter;
dynamic _worstMoment;

class SubPage extends StatefulWidget {
  const SubPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<SubPage> createState() => _SubPageState();
}

class _SubPageState extends State<SubPage> {
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
  final TextEditingController _myOtherPlayPositionController = TextEditingController();
  final TextEditingController _myClubInceptionController = TextEditingController();
  final TextEditingController _myDreamFCController = TextEditingController();
  final TextEditingController _myATFavController = TextEditingController();
  final TextEditingController _myBestMomentInClubController = TextEditingController();
  final TextEditingController _myWorstMomentInClubController = TextEditingController();
  final TextEditingController _myNicknameController = TextEditingController();
  final TextEditingController _myHobbiesController = TextEditingController();
  final TextEditingController _myNationalityController = TextEditingController();
  final TextEditingController _myRegionOfOriginController = TextEditingController();
  final TextEditingController _myAutobiographyController = TextEditingController();
  final TextEditingController _myPhilosophyController = TextEditingController();
  final TextEditingController _myDroplineController = TextEditingController();

  String _selectedFootballPositionRole = 'Select One'; // Default value
  String _selectedLOrRFootedRole = 'Select One'; // Default value
  String _selectedAdidasOrNikeRole = 'Select One'; // Default value
  String _selectedRonaldoOrMessiRole = 'Select One'; // Default value
  String _selectedCaptainRole = 'Select One'; // Default value
  String _selectedCaptainTeamRole = 'Select One'; // Default value

  final List<String> _lOrRFootedOptions = ['Select One', 'Right Foot', 'Left Foot'];
  final List<String> _adidasOrNikeOptions = ['Select One', 'Adidas', 'Nike'];
  final List<String> _ronaldoOrMessiOptions = ['Select One', 'Ronaldo', 'Messi'];
  final List<String> _captainOptions = ['Select One', 'Yes', 'No'];
  final List<String> _captainTeamOptions = ['Select One', 'First Team', 'Reserve Team', 'Third Team', 'Under 18 Team', 'Over 35 Team'];
  final List<String> _footballPositionOptions = [
    'Select One',
    'Goalkeeper',
    'Center Forward',
    'Left Winger',
    'Right Winger',
    'Defensive Midfielder',
    'Central Midfielder',
    'Attacking Midfielder',
    'Right Midfielder',
    'Left Midfielder',
    'Center Back',
    'Left Back',
    'Right Back'
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
      final otherPlayPositionName = _myOtherPlayPositionController.text;
      final clubInceptionName = _myClubInceptionController.text;
      final dreamFCName = _myDreamFCController.text;
      final atFavName = _myATFavController.text;
      final bestMomentInClubName = _myBestMomentInClubController.text;
      final worstMomentInClubName = _myWorstMomentInClubController.text;
      final nicknameName = _myNicknameController.text;
      final hobbiesName = _myHobbiesController.text;
      final nationalityName = _myNationalityController.text;
      final regionOfOriginName = _myRegionOfOriginController.text;
      final autobiographyName = _myAutobiographyController.text;
      final philosophyName = _myPhilosophyController.text;
      final droplineName = _myDroplineController.text;
      final fullName = fullName2;

      String collectionName = 'FirstTeamClassPlayers';

      // Find the corresponding document in the firestore by querying for the full name
      QuerySnapshot querySnapshot = await firestore.collection(collectionName).where('name', isEqualTo: fullName).get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the first document from the query results
        DocumentSnapshot documentSnapshot = querySnapshot.docs[0];

        // Update the fields with the new data, but only if the value is not "select"
        if (_selectedFootballPositionRole != "Select One") {
          documentSnapshot.reference.update({'position_playing': _selectedFootballPositionRole});
        } else {
          documentSnapshot.reference.update({'position_playing': ''});
        }
        if (_selectedLOrRFootedRole != "Select One") {
          documentSnapshot.reference.update({'left_or_right': _selectedLOrRFootedRole});
        } else {
          documentSnapshot.reference.update({'left_or_right': ''});
        }
        if (_selectedAdidasOrNikeRole != "Select One") {
          documentSnapshot.reference.update({'adidas_or_nike': _selectedAdidasOrNikeRole});
        } else {
          documentSnapshot.reference.update({'adidas_or_nike': ''});
        }
        if (_selectedRonaldoOrMessiRole != "Select One") {
          documentSnapshot.reference.update({
            'ronaldo_or_messi': _selectedRonaldoOrMessiRole,
          });
        } else {
          documentSnapshot.reference.update({'ronaldo_or_messi': ''});
        }
        if (_selectedCaptainRole != "Select One") {
          documentSnapshot.reference.update({'captain': _selectedCaptainRole});
        } else {
          documentSnapshot.reference.update({'captain': ''});
        }
        if (_selectedCaptainTeamRole != "Select One") {
          documentSnapshot.reference.update({'team_captaining': _selectedCaptainTeamRole});
        } else {
          documentSnapshot.reference.update({'team_captaining': ''});
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
          'nickname': nicknameName,
          'constituent_country': nationalityName,
          'region_from': regionOfOriginName,
          'dream_fc': dreamFCName,
          'other_positions_of_play': otherPlayPositionName,
          'fav_football_legend': atFavName,
          'year_of_inception': clubInceptionName,
          'hobbies': hobbiesName,
          'my_dropline': droplineName,
          'philosophy': philosophyName,
          'worst_moment': worstMomentInClubName,
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

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('FirstTeamClassPlayers').get();

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
          final Reference storageReference = FirebaseStorage.instance.ref().child('players_images').child(_queryName).child(imageName);
          final UploadTask uploadTask = storageReference.putFile(imageFiles[i]);
          await uploadTask.whenComplete(() {});

          // Get download URL of the uploaded image
          final String imageUrl = await storageReference.getDownloadURL();

          // Store the image reference (download URL) in Firestore under the user's name
          String imageField = i == 0 ? 'image' : 'image_two'; // Set the field name based on the image index

          // Update the existing document for the specified user (_queryName)
          await FirebaseFirestore.instance.collection('FirstTeamClassPlayers').doc(documentId).update({
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
    firstTeamClassNotifier = Provider.of<FirstTeamClassNotifier>(context, listen: true);

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
          title: Text(
            firstTeamClassNotifier.currentFirstTeamClass.nickname!,
            style: GoogleFonts.sanchez(color: appBarTextColor, fontSize: 25, fontWeight: FontWeight.w400),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          elevation: 10,
          backgroundColor: appBarBackgroundColor,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: appBarIconColor,
            ),
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
                    ],
                onSelected: (item) async {
                  setState(() {
                    // Set the flag based on the selected item
                    isModifyingAutobiography = item == 0;
                  });

                  modifyProfile(); // Use modifyProfile function instead of _showAutobiographyModificationDialog or _showImageModificationDialog
                })
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              if (firstTeamClassNotifier.currentFirstTeamClass.imageTwo.toString().isEmpty) ...[
                Tooltip(
                    message: firstTeamClassNotifier.currentFirstTeamClass.name,
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
                              imageUrl: firstTeamClassNotifier.currentFirstTeamClass.image!,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(MdiIcons.alertRhombus),
                            ),
                            secondChild: CachedNetworkImage(
                              imageUrl: firstTeamClassNotifier.currentFirstTeamClass.image!,
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
                    message: firstTeamClassNotifier.currentFirstTeamClass.name,
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
                              imageUrl: firstTeamClassNotifier.currentFirstTeamClass.image!,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(MdiIcons.alertRhombus),
                            ),
                            secondChild: CachedNetworkImage(
                              imageUrl: firstTeamClassNotifier.currentFirstTeamClass.imageTwo!,
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
                      borderSide: BorderSide(color: shapeDecorationColor.withOpacity(0.20), width: 4.0, style: BorderStyle.solid),
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
                              firstTeamClassNotifier.currentFirstTeamClass.name!.toUpperCase(),
                              style: GoogleFonts.blinker(color: shapeDecorationTextColor, fontSize: 30, fontWeight: FontWeight.w500),
                            ),
                            (() {
                              if (firstTeamClassNotifier.currentFirstTeamClass.captain == "Yes") {
                                return Row(
                                  children: <Widget>[
                                    const SizedBox(width: 10),
                                    Icon(
                                      MdiIcons.shieldCheck,
                                      color: shapeDecorationIconColor,
                                    ),
                                  ],
                                );
                              } else {
                                return Visibility(
                                  visible: !_isVisible,
                                  child: Icon(
                                    MdiIcons.shieldCheck,
                                    color: shapeDecorationIconColor,
                                  ),
                                );
                              }
                            }()),
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
                      /** 0: Useful for CPFC 1st Version and other FC Apps, DND */
                      // Padding(
                      //   padding: const EdgeInsets.only(bottom: 35),
                      //   child: CupertinoSlidingSegmentedControl<int>(
                      //     padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                      //     thumbColor: shapeDecorationColorTwo,
                      //     backgroundColor: shapeDecorationColorThree.withAlpha(50),
                      //     children: {
                      //       0: Text(
                      //         reachDetails,
                      //         style: GoogleFonts.sacramento(
                      //             color: shapeDecorationColorThree,
                      //             fontSize: 25,
                      //             fontStyle: FontStyle.normal,
                      //             fontWeight: FontWeight.w400),
                      //       ),
                      //       1: Text(
                      //         autoBioDetails,
                      //         style: GoogleFonts.sacramento(
                      //           color: shapeDecorationColorThree,
                      //           fontSize: 25,
                      //           fontStyle: FontStyle.normal,
                      //           fontWeight: FontWeight.w400,
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

                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                            child: Container(
                              decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50)),
                              // borderRadius: BorderRadius.circular(10)),
                              child: Material(
                                color: materialBackgroundColor.withAlpha(110),
                                child: InkWell(
                                  splashColor: shapeDecorationColorThree.withOpacity(0.1),
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
                                _dreamFC.toString().isNotEmpty ||
                                _positionPlaying.toString().isNotEmpty ||
                                _hobbies.toString().isNotEmpty ||
                                _nickname.toString().isNotEmpty ||
                                _philosophy.toString().isNotEmpty ||
                                _myDropline.toString().isNotEmpty ||
                                _country.toString().isNotEmpty ||
                                _regionFrom.toString().isNotEmpty ||
                                _otherPositionsOfPlay.toString().isNotEmpty ||
                                _favFootballLegend.toString().isNotEmpty ||
                                _yearOfInception.toString().isNotEmpty ||
                                _leftOrRightFooted.toString().isNotEmpty ||
                                _adidasOrNike.toString().isNotEmpty ||
                                _ronaldoOrMessi.toString().isNotEmpty ||
                                _worstMoment.toString().isNotEmpty ||
                                _captain.toString().isNotEmpty ||
                                _prefectPosition.toString().isNotEmpty) {
                              return Visibility(
                                visible: !_isVisible,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Container(
                                    decoration:
                                        BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                          BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                            if (_positionPlaying.toString().isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                                  text: positionPlayingTitle,
                                                  style: GoogleFonts.aBeeZee(
                                                    color: textColor,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              TextSpan(
                                                  text: ' $_positionPlaying',
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Container(
                                      decoration:
                                          BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                                      child: Material(
                                        color: materialBackgroundColor,
                                        // child: InkWell(
                                        //   splashColor: splashColorThree,
                                        //   onTap: () {},
                                        //   child: Padding(
                                        //     padding:
                                        //     const EdgeInsets.only(bottom: 15, top: 15, left: 25),
                                        //     child: Text.rich(
                                        //       TextSpan(
                                        //         children: <TextSpan>[
                                        //           TextSpan(
                                        //               text: dreamUniversityCourseTitle,
                                        //               style: GoogleFonts.aBeeZee(
                                        //                 color: textColor,
                                        //                 fontSize: 19,
                                        //                 fontWeight: FontWeight.bold,
                                        //               )),
                                        //           TextSpan(
                                        //               text: ' ' + _dreamUniversityCourse,
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
                                    ),
                                  ));
                            }
                          }()),

                          (() {
                            if (_otherPositionsOfPlay.toString().isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                                  text: otherPositionsOfPlayTitle,
                                                  style: GoogleFonts.aBeeZee(
                                                    color: textColor,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              TextSpan(
                                                  text: ' $_otherPositionsOfPlay',
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Container(
                                      decoration:
                                          BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                                      child: Material(
                                        color: materialBackgroundColor,
                                        // child: InkWell(
                                        //   splashColor: splashColorThree,
                                        //   onTap: () {},
                                        //   child: Padding(
                                        //     padding:
                                        //     const EdgeInsets.only(bottom: 15, top: 15, left: 25),
                                        //     child: Text.rich(
                                        //       TextSpan(
                                        //         children: <TextSpan>[
                                        //           TextSpan(
                                        //               text: favWatchedMovieTitle,
                                        //               style: GoogleFonts.aBeeZee(
                                        //                 color: textColor,
                                        //                 fontSize: 19,
                                        //                 fontWeight: FontWeight.bold,
                                        //               )),
                                        //           TextSpan(
                                        //               text: ' ' + _favWatchedMovie,
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
                                    ),
                                  ));
                            }
                          }()),

                          (() {
                            if (_leftOrRightFooted.toString().isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                                  text: leftOrRightFootedTitle,
                                                  style: GoogleFonts.aBeeZee(
                                                    color: textColor,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              TextSpan(
                                                  text: ' $_leftOrRightFooted',
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Container(
                                      decoration:
                                          BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                                      child: Material(
                                        color: materialBackgroundColor,
                                        // child: InkWell(
                                        //   splashColor: splashColorThree,
                                        //   onTap: () {},
                                        //   child: Padding(
                                        //     padding:
                                        //     const EdgeInsets.only(bottom: 15, top: 15, left: 25),
                                        //     child: Text.rich(
                                        //       TextSpan(
                                        //         children: <TextSpan>[
                                        //           TextSpan(
                                        //               text: favPlaceInCampusTitle,
                                        //               style: GoogleFonts.aBeeZee(
                                        //                 color: textColor,
                                        //                 fontSize: 19,
                                        //                 fontWeight: FontWeight.bold,
                                        //               )),
                                        //           TextSpan(
                                        //               text: ' ' + _favPlaceInCampus,
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
                                    ),
                                  ));
                            }
                          }()),

                          (() {
                            if (_yearOfInception.toString().isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Container(
                                      decoration:
                                          BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                                      child: Material(
                                        color: materialBackgroundColor,
                                        // child: InkWell(
                                        //   splashColor: splashColorThree,
                                        //   onTap: () {},
                                        //   child: Padding(
                                        //     padding:
                                        //     const EdgeInsets.only(bottom: 15, top: 15, left: 25),
                                        //     child: Text.rich(
                                        //       TextSpan(
                                        //         children: <TextSpan>[
                                        //           TextSpan(
                                        //               text: chosenSubjectsTitle,
                                        //               style: GoogleFonts.aBeeZee(
                                        //                 color: textColor,
                                        //                 fontSize: 19,
                                        //                 fontWeight: FontWeight.bold,
                                        //               )),
                                        //           TextSpan(
                                        //               text: ' ' + _chosenSubjects,
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
                                    ),
                                  ));
                            }
                          }()),

                          (() {
                            if (_dreamFC.toString().isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                                  text: dreamFCTitle,
                                                  style: GoogleFonts.aBeeZee(
                                                    color: textColor,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              TextSpan(
                                                  text: ' $_dreamFC',
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Container(
                                      decoration:
                                          BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                                      child: Material(
                                        color: materialBackgroundColor,
                                        // child: InkWell(
                                        //   splashColor: splashColorThree,
                                        //   onTap: () {},
                                        //   child: Padding(
                                        //     padding:
                                        //     const EdgeInsets.only(bottom: 15, top: 15, left: 25),
                                        //     child: Text.rich(
                                        //       TextSpan(
                                        //         children: <TextSpan>[
                                        //           TextSpan(
                                        //               text: dreamUniversityTitle,
                                        //               style: GoogleFonts.aBeeZee(
                                        //                 color: textColor,
                                        //                 fontSize: 19,
                                        //                 fontWeight: FontWeight.bold,
                                        //               )),
                                        //           TextSpan(
                                        //               text: ' ' + _dreamUniversity,
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
                                    ),
                                  ));
                            }
                          }()),

                          (() {
                            if (_favFootballLegend.toString().isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                                  text: favFootballLegendTitle,
                                                  style: GoogleFonts.aBeeZee(
                                                    color: textColor,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              TextSpan(
                                                  text: ' $_favFootballLegend',
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Container(
                                      decoration:
                                          BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                                      child: Material(
                                        color: materialBackgroundColor,
                                        // child: InkWell(
                                        //   splashColor: splashColorThree,
                                        //   onTap: () {},
                                        //   child: Padding(
                                        //     padding:
                                        //     const EdgeInsets.only(bottom: 15, top: 15, left: 25),
                                        //     child: Text.rich(
                                        //       TextSpan(
                                        //         children: <TextSpan>[
                                        //           TextSpan(
                                        //               text: favSportInCampusTitle,
                                        //               style: GoogleFonts.aBeeZee(
                                        //                 color: textColor,
                                        //                 fontSize: 19,
                                        //                 fontWeight: FontWeight.bold,
                                        //               )),
                                        //           TextSpan(
                                        //               text: ' ' + _favSportInCampus,
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
                                    ),
                                  ));
                            }
                          }()),

                          (() {
                            if (_adidasOrNike.toString().isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                                  text: adidasOrNikeTitle,
                                                  style: GoogleFonts.aBeeZee(
                                                    color: textColor,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              TextSpan(
                                                  text: ' $_adidasOrNike',
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Container(
                                      decoration:
                                          BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                                      child: Material(
                                        color: materialBackgroundColor,
                                        // child: InkWell(
                                        //   splashColor: splashColorThree,
                                        //   onTap: () {},
                                        //   child: Padding(
                                        //     padding:
                                        //     const EdgeInsets.only(bottom: 15, top: 15, left: 25),
                                        //     child: Text.rich(
                                        //       TextSpan(
                                        //         children: <TextSpan>[
                                        //           TextSpan(
                                        //               text: favClubActivityTitle,
                                        //               style: GoogleFonts.aBeeZee(
                                        //                 color: textColor,
                                        //                 fontSize: 19,
                                        //                 fontWeight: FontWeight.bold,
                                        //               )),
                                        //           TextSpan(
                                        //               text: ' ' + _favClubActivity,
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
                                    ),
                                  ));
                            }
                          }()),

                          (() {
                            if (_ronaldoOrMessi.toString().isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                                  text: ronaldoOrMessiTitle,
                                                  style: GoogleFonts.aBeeZee(
                                                    color: textColor,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              TextSpan(
                                                  text: ' $_ronaldoOrMessi',
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Container(
                                      decoration:
                                          BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                                      child: Material(
                                        color: materialBackgroundColor,
                                        // child: InkWell(
                                        //   splashColor: splashColorThree,
                                        //   onTap: () {},
                                        //   child: Padding(
                                        //     padding:
                                        //     const EdgeInsets.only(bottom: 15, top: 15, left: 25),
                                        //     child: Text.rich(
                                        //       TextSpan(
                                        //         children: <TextSpan>[
                                        //           TextSpan(
                                        //               text: favClassmateTitle,
                                        //               style: GoogleFonts.aBeeZee(
                                        //                 color: textColor,
                                        //                 fontSize: 19,
                                        //                 fontWeight: FontWeight.bold,
                                        //               )),
                                        //           TextSpan(
                                        //               text: ' ' + _favClassmate,
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
                                    ),
                                  ));
                            }
                          }()),

                          (() {
                            if (_bestMoment.toString().isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Container(
                                      decoration:
                                          BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                  ));
                            }
                          }()),

                          (() {
                            if (_worstMoment.toString().isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Container(
                                      decoration:
                                          BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                  ));
                            }
                          }()),

                          (() {
                            if (_nickname.toString().isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                                  text: nicknameTitle,
                                                  style: GoogleFonts.aBeeZee(
                                                    color: textColor,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              TextSpan(
                                                  text: ' $_nickname',
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Container(
                                      decoration:
                                          BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                                      text: nicknameTitle,
                                                      style: GoogleFonts.aBeeZee(
                                                        color: textColor,
                                                        fontSize: 19,
                                                        fontWeight: FontWeight.bold,
                                                      )),
                                                  TextSpan(
                                                      text: ' $_nickname',
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
                            if (_hobbies.toString().isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Container(
                                      decoration:
                                          BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                  ));
                            }
                          }()),

                          (() {
                            if (_dob.toString().isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Container(
                                      decoration:
                                          BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                  ));
                            }
                          }()),

                          (() {
                            if (_country.toString().isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Container(
                                      decoration:
                                          BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                  ));
                            }
                          }()),

                          (() {
                            if (_regionFrom.toString().isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Container(
                                      decoration:
                                          BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                  ));
                            }
                          }()),

                          (() {
                            if (_autoBio.toString().isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Container(
                                  decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                              );
                            } else {
                              return Visibility(
                                  visible: !_isVisible,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Container(
                                      decoration:
                                          BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                  ));
                            }
                          }()),

                          (() {
                            if (_philosophy.toString().isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Container(
                                      decoration:
                                          BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                  ));
                            }
                          }()),

                          (() {
                            if (_myDropline.toString().isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                                  text: droplineTitle,
                                                  style: GoogleFonts.aBeeZee(
                                                    color: textColor,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                              TextSpan(
                                                  text: ' $_myDropline',
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Container(
                                      decoration:
                                          BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                                      text: droplineTitle,
                                                      style: GoogleFonts.aBeeZee(
                                                        color: textColor,
                                                        fontSize: 19,
                                                        fontWeight: FontWeight.bold,
                                                      )),
                                                  TextSpan(
                                                      text: ' $_myDropline',
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

                          // (() {
                          //   if (_captain.toString() == "Yes") {
                          //     return Padding(
                          //       padding: const EdgeInsets.only(top: 20.0),
                          //       child: Container(
                          //         child: Material(
                          //           color: materialBackgroundColor,
                          //           child: InkWell(
                          //             splashColor: splashColorThree,
                          //             onTap: () {},
                          //             child: Padding(
                          //               padding:
                          //               const EdgeInsets.only(bottom: 15, top: 15, left: 25),
                          //               child: Text.rich(
                          //                 TextSpan(
                          //                   children: <TextSpan>[
                          //                     TextSpan(
                          //                         text: prefectPositionTitle,
                          //                         style: GoogleFonts.aBeeZee(
                          //                           color: textColor,
                          //                           fontSize: 19,
                          //                           fontWeight: FontWeight.bold,
                          //                         )),
                          //                     TextSpan(
                          //                         text: ' ' + _prefectPosition,
                          //                         style: GoogleFonts.trykker(
                          //                           color: textColor,
                          //                           fontSize: 19,
                          //                           fontWeight: FontWeight.w300,
                          //                         )),
                          //                   ],
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //         decoration: BoxDecoration(
                          //             color: shapeDecorationColorThree.withAlpha(50),
                          //             borderRadius: new BorderRadius.circular(10)),
                          //       ),
                          //     );
                          //   } else {
                          //     return Visibility(
                          //         visible: !_isVisible,
                          //         child: Padding(
                          //           padding: const EdgeInsets.only(top: 20.0),
                          //           child: Container(
                          //             child: Material(
                          //               color: materialBackgroundColor,
                          //               child: InkWell(
                          //                 splashColor: splashColorThree,
                          //                 onTap: () {},
                          //                 child: Padding(
                          //                   padding:
                          //                   const EdgeInsets.only(bottom: 15, top: 15, left: 25),
                          //                   child: Text.rich(
                          //                     TextSpan(
                          //                       children: <TextSpan>[
                          //                         TextSpan(
                          //                             text: prefectPositionTitle,
                          //                             style: GoogleFonts.aBeeZee(
                          //                               color: textColor,
                          //                               fontSize: 19,
                          //                               fontWeight: FontWeight.bold,
                          //                             )),
                          //                         TextSpan(
                          //                             text: ' ' + _prefectPosition,
                          //                             style: GoogleFonts.trykker(
                          //                               color: textColor,
                          //                               fontSize: 19,
                          //                               fontWeight: FontWeight.w300,
                          //                             )),
                          //                       ],
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //             decoration: BoxDecoration(
                          //                 color: shapeDecorationColorThree.withAlpha(50),
                          //                 borderRadius: new BorderRadius.circular(10)),
                          //           ),
                          //         )
                          //     );
                          //   }
                          // }()),
                        ],
                      ),
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
    _confettiController!.play();

    FirstTeamClassNotifier firstTeamClassNotifier = Provider.of<FirstTeamClassNotifier>(context, listen: false);

    _autoBio = firstTeamClassNotifier.currentFirstTeamClass.autoBio;
    _bestMoment = firstTeamClassNotifier.currentFirstTeamClass.bestMoment;
    _dob = firstTeamClassNotifier.currentFirstTeamClass.dob;
    _dreamFC = firstTeamClassNotifier.currentFirstTeamClass.dreamFC;
    _positionPlaying = firstTeamClassNotifier.currentFirstTeamClass.positionPlaying;
    _email = firstTeamClassNotifier.currentFirstTeamClass.email;
    _facebook = firstTeamClassNotifier.currentFirstTeamClass.facebook;
    _linkedIn = firstTeamClassNotifier.currentFirstTeamClass.linkedIn;
    _hobbies = firstTeamClassNotifier.currentFirstTeamClass.hobbies;
    _instagram = firstTeamClassNotifier.currentFirstTeamClass.instagram;
    _myDropline = firstTeamClassNotifier.currentFirstTeamClass.myDropline;
    _name = firstTeamClassNotifier.currentFirstTeamClass.name;
    _nickname = firstTeamClassNotifier.currentFirstTeamClass.nickname;
    _philosophy = firstTeamClassNotifier.currentFirstTeamClass.philosophy;
    _phone = firstTeamClassNotifier.currentFirstTeamClass.phone;
    _captain = firstTeamClassNotifier.currentFirstTeamClass.captain;
    _prefectPosition = firstTeamClassNotifier.currentFirstTeamClass.teamCaptaining;
    _country = firstTeamClassNotifier.currentFirstTeamClass.constituentCountry;
    _regionFrom = firstTeamClassNotifier.currentFirstTeamClass.regionFrom;
    _twitter = firstTeamClassNotifier.currentFirstTeamClass.twitter;
    _snapchat = firstTeamClassNotifier.currentFirstTeamClass.snapchat;
    _tikTok = firstTeamClassNotifier.currentFirstTeamClass.tikTok;
    _otherPositionsOfPlay = firstTeamClassNotifier.currentFirstTeamClass.otherPositionsOfPlay;
    _favFootballLegend = firstTeamClassNotifier.currentFirstTeamClass.favFootballLegend;
    _yearOfInception = firstTeamClassNotifier.currentFirstTeamClass.yearOfInception;
    _leftOrRightFooted = firstTeamClassNotifier.currentFirstTeamClass.leftOrRightFooted;
    _adidasOrNike = firstTeamClassNotifier.currentFirstTeamClass.adidasOrNike;
    _ronaldoOrMessi = firstTeamClassNotifier.currentFirstTeamClass.ronaldoOrMessi;
    _worstMoment = firstTeamClassNotifier.currentFirstTeamClass.worstMoment;

    loadFormData();

    // resetVerificationTime();

    userBIO = <int, Widget>{
      /** 0: Useful for CPFC 1st Version and other FC Apps, DND */
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
                    icon: Icon(
                      MdiIcons.dialpad,
                      color: iconTextColor,
                    ),
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
                      icon: Icon(
                        MdiIcons.dialpad,
                        color: iconTextColor,
                      ),
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
                    icon: Icon(
                      MdiIcons.message,
                      color: iconTextColor,
                    ),
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
                      icon: Icon(
                        MdiIcons.message,
                        color: iconTextColor,
                      ),
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
                    icon: Icon(
                      MdiIcons.whatsapp,
                      color: iconTextColor,
                    ),
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
                      icon: Icon(
                        MdiIcons.message,
                        color: iconTextColor,
                      ),
                      label: Text(whatsAppButton, style: GoogleFonts.abel(color: iconTextColor, fontSize: 18, fontWeight: FontWeight.w300)),
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
                    icon: Icon(
                      MdiIcons.gmail,
                      color: iconTextColor,
                    ),
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
                        icon: Icon(
                          MdiIcons.gmail,
                          color: iconTextColor,
                        ),
                        label: Text(emailButton, style: GoogleFonts.abel(color: iconTextColor, fontSize: 18, fontWeight: FontWeight.w300)),
                        onPressed: () {
                          launchURL(mailFIRST + _email + mailSECOND + _name);
                        },
                      ),
                    ),
                  ));
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
                    icon: Icon(
                      MdiIcons.instagram,
                      color: iconTextColor,
                    ),
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
                        icon: Icon(
                          MdiIcons.instagram,
                          color: iconTextColor,
                        ),
                        label: Text(instagramButton, style: GoogleFonts.abel(color: iconTextColor, fontSize: 18, fontWeight: FontWeight.w300)),
                        onPressed: () {
                          launchURL(urlInstagram + _instagram);
                        },
                      ),
                    ),
                  ));
            }
          }()),
          (() {
            if (_snapchat.toString().isNotEmpty) {
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
                    icon: Icon(
                      MdiIcons.snapchat,
                      color: iconTextColor,
                    ),
                    label: Text(snapchatButton, style: GoogleFonts.abel(color: iconTextColor, fontSize: 18, fontWeight: FontWeight.w300)),
                    onPressed: () {
                      if (_snapchat.toString().startsWith('@')) {
                        var most = _instagram.toString().substring(1);
                        launchURL(urlSnapchat + most);
                      } else {
                        launchURL(urlSnapchat + _snapchat);
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
                      icon: Icon(
                        MdiIcons.snapchat,
                        color: iconTextColorTwo,
                      ),
                      label: Text(snapchatButton, style: GoogleFonts.abel(color: iconTextColorTwo, fontSize: 18, fontWeight: FontWeight.w300)),
                      onPressed: () {
                        launchURL(urlSnapchat + _snapchat);
                      },
                    ),
                  ),
                ),
              );
            }
          }()),
          (() {
            if (_tikTok.toString().isNotEmpty) {
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
                    icon: FaIcon(
                      FontAwesomeIcons.tiktok,
                      color: iconTextColor,
                    ),
                    label: Text(tikTokButton, style: GoogleFonts.abel(color: iconTextColor, fontSize: 18, fontWeight: FontWeight.w300)),
                    onPressed: () {
                      if (_tikTok.toString().startsWith('@')) {
                        var most = _tikTok.toString().substring(1);
                        launchURL(urlTikTok + most);
                      } else {
                        launchURL(urlTikTok + _tikTok);
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
                      icon: FaIcon(
                        FontAwesomeIcons.tiktok,
                        color: iconTextColorTwo,
                      ),
                      label: Text(tikTokButton, style: GoogleFonts.abel(color: iconTextColorTwo, fontSize: 18, fontWeight: FontWeight.w300)),
                      onPressed: () {
                        launchURL(urlTikTok + _tikTok);
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
                    icon: Icon(
                      MdiIcons.facebook,
                      color: iconTextColor,
                    ),
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
                      splashColor: splashColorTwo,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          elevation: 2,
                          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        icon: Icon(
                          MdiIcons.facebook,
                          color: iconTextColor,
                        ),
                        label: Text(
                          facebookButton,
                          style: GoogleFonts.abel(color: iconTextColor, fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                        onPressed: () {
                          launchURL(urlFacebook + _facebook);
                        },
                      ),
                    ),
                  ));
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
                    icon: Icon(
                      MdiIcons.linkedin,
                      color: iconTextColor,
                    ),
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
                        icon: Icon(
                          MdiIcons.facebook,
                          color: iconTextColor,
                        ),
                        label: Text(
                          facebookButton,
                          style: GoogleFonts.abel(color: iconTextColor, fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                        onPressed: () {
                          launchURL(urlFacebook + _facebook);
                        },
                      ),
                    ),
                  ));
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
            if (_positionPlaying.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                  text: positionPlayingTitle,
                                  style: GoogleFonts.aBeeZee(
                                    color: textColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  )),
                              TextSpan(
                                  text: ' $_positionPlaying',
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                      child: Material(
                        color: materialBackgroundColor,
                        // child: InkWell(
                        //   splashColor: splashColorThree,
                        //   onTap: () {},
                        //   child: Padding(
                        //     padding:
                        //     const EdgeInsets.only(bottom: 15, top: 15, left: 25),
                        //     child: Text.rich(
                        //       TextSpan(
                        //         children: <TextSpan>[
                        //           TextSpan(
                        //               text: dreamUniversityCourseTitle,
                        //               style: GoogleFonts.aBeeZee(
                        //                 color: textColor,
                        //                 fontSize: 19,
                        //                 fontWeight: FontWeight.bold,
                        //               )),
                        //           TextSpan(
                        //               text: ' ' + _dreamUniversityCourse,
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
                    ),
                  ));
            }
          }()),

          (() {
            if (_otherPositionsOfPlay.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                  text: otherPositionsOfPlayTitle,
                                  style: GoogleFonts.aBeeZee(
                                    color: textColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  )),
                              TextSpan(
                                  text: ' $_otherPositionsOfPlay',
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                      child: Material(
                        color: materialBackgroundColor,
                        // child: InkWell(
                        //   splashColor: splashColorThree,
                        //   onTap: () {},
                        //   child: Padding(
                        //     padding:
                        //     const EdgeInsets.only(bottom: 15, top: 15, left: 25),
                        //     child: Text.rich(
                        //       TextSpan(
                        //         children: <TextSpan>[
                        //           TextSpan(
                        //               text: favWatchedMovieTitle,
                        //               style: GoogleFonts.aBeeZee(
                        //                 color: textColor,
                        //                 fontSize: 19,
                        //                 fontWeight: FontWeight.bold,
                        //               )),
                        //           TextSpan(
                        //               text: ' ' + _favWatchedMovie,
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
                    ),
                  ));
            }
          }()),

          (() {
            if (_leftOrRightFooted.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                  text: leftOrRightFootedTitle,
                                  style: GoogleFonts.aBeeZee(
                                    color: textColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  )),
                              TextSpan(
                                  text: ' $_leftOrRightFooted',
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                      child: Material(
                        color: materialBackgroundColor,
                        // child: InkWell(
                        //   splashColor: splashColorThree,
                        //   onTap: () {},
                        //   child: Padding(
                        //     padding:
                        //     const EdgeInsets.only(bottom: 15, top: 15, left: 25),
                        //     child: Text.rich(
                        //       TextSpan(
                        //         children: <TextSpan>[
                        //           TextSpan(
                        //               text: favPlaceInCampusTitle,
                        //               style: GoogleFonts.aBeeZee(
                        //                 color: textColor,
                        //                 fontSize: 19,
                        //                 fontWeight: FontWeight.bold,
                        //               )),
                        //           TextSpan(
                        //               text: ' ' + _favPlaceInCampus,
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
                    ),
                  ));
            }
          }()),

          (() {
            if (_yearOfInception.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                      child: Material(
                        color: materialBackgroundColor,
                        // child: InkWell(
                        //   splashColor: splashColorThree,
                        //   onTap: () {},
                        //   child: Padding(
                        //     padding:
                        //     const EdgeInsets.only(bottom: 15, top: 15, left: 25),
                        //     child: Text.rich(
                        //       TextSpan(
                        //         children: <TextSpan>[
                        //           TextSpan(
                        //               text: chosenSubjectsTitle,
                        //               style: GoogleFonts.aBeeZee(
                        //                 color: textColor,
                        //                 fontSize: 19,
                        //                 fontWeight: FontWeight.bold,
                        //               )),
                        //           TextSpan(
                        //               text: ' ' + _chosenSubjects,
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
                    ),
                  ));
            }
          }()),

          (() {
            if (_dreamFC.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                  text: dreamFCTitle,
                                  style: GoogleFonts.aBeeZee(
                                    color: textColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  )),
                              TextSpan(
                                  text: ' $_dreamFC',
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                      child: Material(
                        color: materialBackgroundColor,
                        // child: InkWell(
                        //   splashColor: splashColorThree,
                        //   onTap: () {},
                        //   child: Padding(
                        //     padding:
                        //     const EdgeInsets.only(bottom: 15, top: 15, left: 25),
                        //     child: Text.rich(
                        //       TextSpan(
                        //         children: <TextSpan>[
                        //           TextSpan(
                        //               text: dreamUniversityTitle,
                        //               style: GoogleFonts.aBeeZee(
                        //                 color: textColor,
                        //                 fontSize: 19,
                        //                 fontWeight: FontWeight.bold,
                        //               )),
                        //           TextSpan(
                        //               text: ' ' + _dreamUniversity,
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
                    ),
                  ));
            }
          }()),

          (() {
            if (_favFootballLegend.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                  text: favFootballLegendTitle,
                                  style: GoogleFonts.aBeeZee(
                                    color: textColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  )),
                              TextSpan(
                                  text: ' $_favFootballLegend',
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                      child: Material(
                        color: materialBackgroundColor,
                        // child: InkWell(
                        //   splashColor: splashColorThree,
                        //   onTap: () {},
                        //   child: Padding(
                        //     padding:
                        //     const EdgeInsets.only(bottom: 15, top: 15, left: 25),
                        //     child: Text.rich(
                        //       TextSpan(
                        //         children: <TextSpan>[
                        //           TextSpan(
                        //               text: favSportInCampusTitle,
                        //               style: GoogleFonts.aBeeZee(
                        //                 color: textColor,
                        //                 fontSize: 19,
                        //                 fontWeight: FontWeight.bold,
                        //               )),
                        //           TextSpan(
                        //               text: ' ' + _favSportInCampus,
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
                    ),
                  ));
            }
          }()),

          (() {
            if (_adidasOrNike.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                  text: adidasOrNikeTitle,
                                  style: GoogleFonts.aBeeZee(
                                    color: textColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  )),
                              TextSpan(
                                  text: ' $_adidasOrNike',
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                      child: Material(
                        color: materialBackgroundColor,
                        // child: InkWell(
                        //   splashColor: splashColorThree,
                        //   onTap: () {},
                        //   child: Padding(
                        //     padding:
                        //     const EdgeInsets.only(bottom: 15, top: 15, left: 25),
                        //     child: Text.rich(
                        //       TextSpan(
                        //         children: <TextSpan>[
                        //           TextSpan(
                        //               text: favClubActivityTitle,
                        //               style: GoogleFonts.aBeeZee(
                        //                 color: textColor,
                        //                 fontSize: 19,
                        //                 fontWeight: FontWeight.bold,
                        //               )),
                        //           TextSpan(
                        //               text: ' ' + _favClubActivity,
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
                    ),
                  ));
            }
          }()),

          (() {
            if (_ronaldoOrMessi.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                  text: ronaldoOrMessiTitle,
                                  style: GoogleFonts.aBeeZee(
                                    color: textColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  )),
                              TextSpan(
                                  text: ' $_ronaldoOrMessi',
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
                      child: Material(
                        color: materialBackgroundColor,
                        // child: InkWell(
                        //   splashColor: splashColorThree,
                        //   onTap: () {},
                        //   child: Padding(
                        //     padding:
                        //     const EdgeInsets.only(bottom: 15, top: 15, left: 25),
                        //     child: Text.rich(
                        //       TextSpan(
                        //         children: <TextSpan>[
                        //           TextSpan(
                        //               text: favClassmateTitle,
                        //               style: GoogleFonts.aBeeZee(
                        //                 color: textColor,
                        //                 fontSize: 19,
                        //                 fontWeight: FontWeight.bold,
                        //               )),
                        //           TextSpan(
                        //               text: ' ' + _favClassmate,
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
                    ),
                  ));
            }
          }()),

          (() {
            if (_bestMoment.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                  ));
            }
          }()),

          (() {
            if (_worstMoment.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                  ));
            }
          }()),

          (() {
            if (_nickname.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                  text: nicknameTitle,
                                  style: GoogleFonts.aBeeZee(
                                    color: textColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  )),
                              TextSpan(
                                  text: ' $_nickname',
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                      text: nicknameTitle,
                                      style: GoogleFonts.aBeeZee(
                                        color: textColor,
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  TextSpan(
                                      text: ' $_nickname',
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
            if (_hobbies.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                  ));
            }
          }()),

          (() {
            if (_dob.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                  ));
            }
          }()),

          (() {
            if (_country.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                  ));
            }
          }()),

          (() {
            if (_regionFrom.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                  ));
            }
          }()),

          (() {
            if (_autoBio.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                    decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
            if (_philosophy.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                  ));
            }
          }()),

          (() {
            if (_myDropline.toString().isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                  text: droplineTitle,
                                  style: GoogleFonts.aBeeZee(
                                    color: textColor,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  )),
                              TextSpan(
                                  text: ' $_myDropline',
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      decoration: BoxDecoration(color: shapeDecorationColorThree.withAlpha(50), borderRadius: BorderRadius.circular(10)),
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
                                      text: droplineTitle,
                                      style: GoogleFonts.aBeeZee(
                                        color: textColor,
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  TextSpan(
                                      text: ' $_myDropline',
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

          // (() {
          //   if (_captain.toString() == "Yes") {
          //     return Padding(
          //       padding: const EdgeInsets.only(top: 20.0),
          //       child: Container(
          //         child: Material(
          //           color: materialBackgroundColor,
          //           child: InkWell(
          //             splashColor: splashColorThree,
          //             onTap: () {},
          //             child: Padding(
          //               padding:
          //               const EdgeInsets.only(bottom: 15, top: 15, left: 25),
          //               child: Text.rich(
          //                 TextSpan(
          //                   children: <TextSpan>[
          //                     TextSpan(
          //                         text: prefectPositionTitle,
          //                         style: GoogleFonts.aBeeZee(
          //                           color: textColor,
          //                           fontSize: 19,
          //                           fontWeight: FontWeight.bold,
          //                         )),
          //                     TextSpan(
          //                         text: ' ' + _prefectPosition,
          //                         style: GoogleFonts.trykker(
          //                           color: textColor,
          //                           fontSize: 19,
          //                           fontWeight: FontWeight.w300,
          //                         )),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //         decoration: BoxDecoration(
          //             color: shapeDecorationColorThree.withAlpha(50),
          //             borderRadius: new BorderRadius.circular(10)),
          //       ),
          //     );
          //   } else {
          //     return Visibility(
          //         visible: !_isVisible,
          //         child: Padding(
          //           padding: const EdgeInsets.only(top: 20.0),
          //           child: Container(
          //             child: Material(
          //               color: materialBackgroundColor,
          //               child: InkWell(
          //                 splashColor: splashColorThree,
          //                 onTap: () {},
          //                 child: Padding(
          //                   padding:
          //                   const EdgeInsets.only(bottom: 15, top: 15, left: 25),
          //                   child: Text.rich(
          //                     TextSpan(
          //                       children: <TextSpan>[
          //                         TextSpan(
          //                             text: prefectPositionTitle,
          //                             style: GoogleFonts.aBeeZee(
          //                               color: textColor,
          //                               fontSize: 19,
          //                               fontWeight: FontWeight.bold,
          //                             )),
          //                         TextSpan(
          //                             text: ' ' + _prefectPosition,
          //                             style: GoogleFonts.trykker(
          //                               color: textColor,
          //                               fontSize: 19,
          //                               fontWeight: FontWeight.w300,
          //                             )),
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             decoration: BoxDecoration(
          //                 color: shapeDecorationColorThree.withAlpha(50),
          //                 borderRadius: new BorderRadius.circular(10)),
          //           ),
          //         )
          //     );
          //   }
          // }()),
        ],
      ),
    };
    super.initState();
  }

  @override
  void dispose() {
    _confettiController!.dispose();
    print("Unregistered Listener");
    super.dispose();
  }

  Future<void> loadFormData() async {
    String collectionName = 'FirstTeamClassPlayers';

    try {
      // Query the Firestore collection
      QuerySnapshot querySnapshot = await firestore.collection(collectionName).where('name', isEqualTo: _name).limit(1).get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the first document from the query results
        DocumentSnapshot documentSnapshot = querySnapshot.docs[0];

        // Set the initial values for your form fields based on the data from Firebase
        setState(() {
          _myOtherPlayPositionController.text = documentSnapshot['other_positions_of_play'];
          _myClubInceptionController.text = documentSnapshot['year_of_inception'];
          _myDreamFCController.text = documentSnapshot['dream_fc'];
          _myATFavController.text = documentSnapshot['fav_football_legend'];
          _myBestMomentInClubController.text = documentSnapshot['best_moment'];
          _myWorstMomentInClubController.text = documentSnapshot['worst_moment'];
          _myNicknameController.text = documentSnapshot['nickname'];
          _myHobbiesController.text = documentSnapshot['hobbies'];
          _myNationalityController.text = documentSnapshot['constituent_country'];
          _myRegionOfOriginController.text = documentSnapshot['region_from'];
          _myAutobiographyController.text = documentSnapshot['autobio'];
          _myPhilosophyController.text = documentSnapshot['philosophy'];
          _myDroplineController.text = documentSnapshot['my_dropline'];

          formattedDate = documentSnapshot['d_o_b'] ?? getFormattedDate(selectedDateA).toUpperCase();

          // _selectedFootballPositionRole = documentSnapshot['position_playing'] ?? 'Select One';
          // _selectedLOrRFootedRole = documentSnapshot['left_or_right'] ?? 'Select One';
          // _selectedAdidasOrNikeRole = documentSnapshot['adidas_or_nike'] ?? 'Select One';
          // _selectedRonaldoOrMessiRole = documentSnapshot['ronaldo_or_messi'] ?? 'Select One';
          // _selectedCaptainRole = documentSnapshot['captain'] ?? 'Select One';
          // _selectedCaptainTeamRole = documentSnapshot['team_captaining'] ?? 'Select One';

          if (documentSnapshot['position_playing'] == "") {
            _selectedFootballPositionRole = 'Select One';
          } else {
            _selectedFootballPositionRole = documentSnapshot['position_playing'];
          }

          if (documentSnapshot['left_or_right'] == "") {
            _selectedLOrRFootedRole = 'Select One';
          } else {
            _selectedLOrRFootedRole = documentSnapshot['left_or_right'];
          }

          if (documentSnapshot['adidas_or_nike'] == "") {
            _selectedAdidasOrNikeRole = 'Select One';
          } else {
            _selectedAdidasOrNikeRole = documentSnapshot['adidas_or_nike'];
          }

          if (documentSnapshot['ronaldo_or_messi'] == "") {
            _selectedRonaldoOrMessiRole = 'Select One';
          } else {
            _selectedRonaldoOrMessiRole = documentSnapshot['ronaldo_or_messi'];
          }

          if (documentSnapshot['captain'] == "") {
            _selectedCaptainRole = 'Select One';
          } else {
            _selectedCaptainRole = documentSnapshot['captain'];
          }

          if (documentSnapshot['team_captaining'] == "") {
            _selectedCaptainTeamRole = 'Select One';
          } else {
            _selectedCaptainTeamRole = documentSnapshot['team_captaining'];
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
                  value: _selectedFootballPositionRole,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedFootballPositionRole = newValue!;
                    });
                  },
                  items: _footballPositionOptions.map((role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(
                        role,
                        style: const TextStyle(fontSize: 14),
                      ),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    labelText: 'My Play Position',
                    labelStyle: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  cursorColor: Colors.black54,
                  style: GoogleFonts.cabin(color: textColor),
                  controller: _myOtherPlayPositionController,
                  decoration: const InputDecoration(
                    labelText: 'My Other Play Position',
                    labelStyle: TextStyle(fontSize: 14, color: Colors.black54),
                    floatingLabelStyle: TextStyle(color: Colors.black87),
                    hintText: "Left Winger, Right Winger, Left Back",
                    hintStyle: TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _selectedLOrRFootedRole,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedLOrRFootedRole = newValue!;
                    });
                  },
                  items: _lOrRFootedOptions.map((role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(
                        role,
                        style: const TextStyle(fontSize: 14),
                      ),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    labelText: 'Your Dominant Foot',
                    labelStyle: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  cursorColor: Colors.black54,
                  style: GoogleFonts.cabin(color: textColor),
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
                  style: GoogleFonts.cabin(color: textColor),
                  controller: _myDreamFCController,
                  decoration: const InputDecoration(
                    labelText: 'Your Dream Club Fantasy',
                    labelStyle: TextStyle(fontSize: 14, color: Colors.black54),
                    floatingLabelStyle: TextStyle(color: Colors.black87),
                    hintText: "Real Madrid",
                    hintStyle: TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  cursorColor: Colors.black54,
                  style: GoogleFonts.cabin(color: textColor),
                  controller: _myATFavController,
                  decoration: const InputDecoration(
                    labelText: 'Your Favourite All Time Footballer',
                    labelStyle: TextStyle(fontSize: 14, color: Colors.black54),
                    floatingLabelStyle: TextStyle(color: Colors.black87),
                    hintText: "Ronaldinho",
                    hintStyle: TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _selectedAdidasOrNikeRole,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedAdidasOrNikeRole = newValue!;
                    });
                  },
                  items: _adidasOrNikeOptions.map((role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(
                        role,
                        style: const TextStyle(fontSize: 14),
                      ),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    labelText: 'Your Preferred Apparel',
                    labelStyle: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _selectedRonaldoOrMessiRole,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedRonaldoOrMessiRole = newValue!;
                    });
                  },
                  items: _ronaldoOrMessiOptions.map((role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(
                        role,
                        style: const TextStyle(fontSize: 14),
                      ),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    labelText: 'Your Preferred World Class Player',
                    labelStyle: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  cursorColor: Colors.black54,
                  style: GoogleFonts.cabin(color: textColor),
                  controller: _myBestMomentInClubController,
                  decoration: const InputDecoration(
                    labelText: 'Your Best Moment so far',
                    labelStyle: TextStyle(fontSize: 14, color: Colors.black54),
                    floatingLabelStyle: TextStyle(color: Colors.black87),
                    hintText: "When I scored the qualifying goal, 2022 ",
                    hintStyle: TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  cursorColor: Colors.black54,
                  style: GoogleFonts.cabin(color: textColor),
                  controller: _myWorstMomentInClubController,
                  decoration: const InputDecoration(
                    labelText: 'Your Worst Moment so far',
                    labelStyle: TextStyle(fontSize: 14, color: Colors.black54),
                    floatingLabelStyle: TextStyle(color: Colors.black87),
                    hintText: "When Kyle took the penalty instead of me, and missed it",
                    hintStyle: TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  cursorColor: Colors.black54,
                  style: GoogleFonts.cabin(color: textColor),
                  controller: _myNicknameController,
                  decoration: const InputDecoration(
                    labelText: 'Your Nickname',
                    labelStyle: TextStyle(fontSize: 14, color: Colors.black54),
                    floatingLabelStyle: TextStyle(color: Colors.black87),
                    hintText: "Chef Blake",
                    hintStyle: TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  cursorColor: Colors.black54,
                  style: GoogleFonts.cabin(color: textColor),
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

                            final newDateTime = DateTime(date!.year, date!.month, date!.day, selectedDateA.hour, selectedDateA.minute);

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
                  style: GoogleFonts.cabin(color: textColor),
                  controller: _myNationalityController,
                  decoration: const InputDecoration(
                    labelText: 'Your Nationality',
                    labelStyle: TextStyle(fontSize: 14, color: Colors.black54),
                    floatingLabelStyle: TextStyle(color: Colors.black87),
                    hintText: "British",
                    hintStyle: TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  cursorColor: Colors.black54,
                  style: GoogleFonts.cabin(color: textColor),
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
                  style: GoogleFonts.cabin(color: textColor),
                  controller: _myAutobiographyController,
                  decoration: const InputDecoration(
                    labelText: 'Your Autobiography',
                    labelStyle: TextStyle(fontSize: 14, color: Colors.black54),
                    floatingLabelStyle: TextStyle(color: Colors.black87),
                    hintText: "I am filled with so much energy, you can't resist the step-up I emulate",
                    hintStyle: TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  cursorColor: Colors.black54,
                  style: GoogleFonts.cabin(color: textColor),
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
                  style: GoogleFonts.cabin(color: textColor),
                  controller: _myDroplineController,
                  decoration: const InputDecoration(
                    labelText: 'Your Drop-line to fellow Players',
                    labelStyle: TextStyle(fontSize: 14, color: Colors.black54),
                    floatingLabelStyle: TextStyle(color: Colors.black87),
                    hintText: "Failure is only a step to success, stay courageous",
                    hintStyle: TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _selectedCaptainRole,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCaptainRole = newValue!;
                    });
                  },
                  items: _captainOptions.map((role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(
                        role,
                        style: const TextStyle(fontSize: 14),
                      ),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    labelText: 'Are you a Captain',
                    labelStyle: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _selectedCaptainTeamRole,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCaptainTeamRole = newValue!;
                    });
                  },
                  items: _captainTeamOptions.map((role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(
                        role,
                        style: const TextStyle(fontSize: 14),
                      ),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    labelText: 'If Yes, what team',
                    labelStyle: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await _submitForm();
                      Navigator.pop(context); // Close the dialog
                    } catch (e) {
                      print("Error submitting form: $e");
                      // Handle the error, show a message, or log it as needed
                      Fluttertoast.showToast(msg: "Error Loading up ,...", gravity: ToastGravity.BOTTOM, backgroundColor: backgroundColor);
                    }
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            ? Image.file(_imageOne!, height: 100, width: 100, fit: BoxFit.cover)
                            : CachedNetworkImage(
                                imageUrl: firstTeamClassNotifier.currentFirstTeamClass.image!,
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
                            ? Image.file(_imageTwo!, height: 100, width: 100, fit: BoxFit.cover)
                            : CachedNetworkImage(
                                imageUrl: firstTeamClassNotifier.currentFirstTeamClass.imageTwo!,
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
                    Navigator.pop(context); // Close the dialog
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
}
