import 'dart:ui' as ui;
import 'dart:ui';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image/image.dart' as img;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:coventry_phoenix_fc/bloc_navigation_bloc/navigation_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../api/club_sponsors_api.dart';
import '../../notifier/club_sponsors_notifier.dart';
import 'package:provider/provider.dart';

Color modalBackgroundColor = const Color.fromRGBO(33, 37, 41, 1.0);
Color alertDialogBackgroundColor = const Color.fromRGBO(255, 255, 255, 1.0);
Color iconColor = const Color.fromRGBO(255, 107, 53, 1.0);
Color backgroundColor = const Color.fromRGBO(34, 36, 54, 1.0);
Color appBarTextColor = const Color.fromRGBO(255, 107, 53, 1.0);
Color appBarBackgroundColor = const Color.fromRGBO(34, 36, 54, 1.0);
Color appBarIconColor = const Color.fromRGBO(255, 255, 255, 1.0);
Color textColor = Colors.white;
Color textColorTwo = const Color.fromRGBO(211, 124, 36, 1.0);
Color textColorThree = const Color.fromRGBO(254, 130, 4, 1.0);
Color dialogBackgroundColor = const Color.fromRGBO(33, 37, 41, 1.0);
Color materialBackgroundColor = Colors.white;
Color splashColor = const Color.fromRGBO(211, 124, 36, 1.0);
Color splashColorTwo = const Color.fromRGBO(215, 145, 119, 1.0);

ClubSponsorsNotifier? clubSponsorsNotifier;

class ImageUrls {
  String lowResUrl;
  String highResUrl;

  ImageUrls({required this.lowResUrl, required this.highResUrl});
}

List<ImageUrls> recentImageUrls = [];

class CreateNewSponsorsShoutOutSMPost extends StatefulWidget with NavigationStates {
  CreateNewSponsorsShoutOutSMPost({super.key});

  @override
  State<CreateNewSponsorsShoutOutSMPost> createState() => _CreateNewSponsorsShoutOutSMPostState();
}

class _CreateNewSponsorsShoutOutSMPostState extends State<CreateNewSponsorsShoutOutSMPost> {
  String? selectedBannerLowResImageUrl;
  String? selectedBannerHighResImageUrl;

  String? formattedSponsorNameText;

  int? selectedSponsorIndex;
  final GlobalKey _bannerContentKeyed = GlobalKey();

  @override
  Widget build(BuildContext context) {
    clubSponsorsNotifier = Provider.of<ClubSponsorsNotifier>(context);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: appBarIconColor,
            ),
            onPressed: () async {
              bool shouldPop = await _onWillPop();
              if (shouldPop) {
                Navigator.pop(context);
              }
            },
          ),
          backgroundColor: appBarBackgroundColor,
          title: const Center(child: Text('S/O a New Sponsor')),
          titleTextStyle: TextStyle(color: textColor, fontSize: 20),
        ),
        body: Column(
          children: [
            Form(
              key: _formKey,
              child: Center(
                heightFactor: 1.3,
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  height: MediaQuery.sizeOf(context).height * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: materialBackgroundColor.withAlpha(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.7,
                          height: MediaQuery.sizeOf(context).height * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: materialBackgroundColor.withAlpha(20),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                showAndSelectSponsorsDialog();
                              },
                              splashColor: splashColor,
                              child: Center(
                                child: Text(
                                  selectedSponsorIndex != null
                                      ? clubSponsorsNotifier!.clubSponsorsList[selectedSponsorIndex!].name!
                                      : 'Choose a Sponsor',
                                  style: TextStyle(fontSize: 16, color: materialBackgroundColor, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (selectedSponsorIndex != null)
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              CircleAvatar(
                                radius: MediaQuery.sizeOf(context).width * 0.09,
                                backgroundColor: Colors.transparent, // Set background color to transparent to avoid unwanted padding
                                child: ClipOval( // ClipOval to ensure the image is circular
                                  child: CachedNetworkImage(
                                    imageUrl: clubSponsorsNotifier!.clubSponsorsList[selectedSponsorIndex!].sponsorIcon!,
                                    fit: BoxFit.cover, // Use BoxFit.cover to ensure the image covers the entire circle
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width * 0.45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: materialBackgroundColor.withAlpha(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    clubSponsorsNotifier!.clubSponsorsList[selectedSponsorIndex!].name!,
                                    style: TextStyle(fontSize: 14, color: materialBackgroundColor, fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      // const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.sizeOf(context).width * 0.7,
              height: MediaQuery.sizeOf(context).height * 0.05,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: materialBackgroundColor.withAlpha(20),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    generateBanner();
                  },
                  splashColor: splashColor,
                  child: Center(
                    child: Text(
                      'Display Shout-Out Banner',
                      style: TextStyle(
                        color: textColorTwo,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showAndSelectSponsorsDialog() async {
    int? previousSponsorIndex = selectedSponsorIndex;
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: modalBackgroundColor,
          title: const Text(
            "Select Sponsor",
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
                      return RadioListTile<int>(
                        activeColor: iconColor,
                        title: Text(
                          clubSponsorsNotifier!.clubSponsorsList[index].name!,
                          style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                        value: index,
                        groupValue: selectedSponsorIndex,
                        onChanged: (int? value) {
                          setState(() {
                            selectedSponsorIndex = value;
                          });
                          // Close the dialog when a sponsor is selected
                          Navigator.of(context).pop();
                        },
                        secondary: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                clubSponsorsNotifier!.clubSponsorsList[index].sponsorIcon!,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    // If no sponsor was selected, revert to the previous selection
    if (selectedSponsorIndex == null) {
      setState(() {
        selectedSponsorIndex = previousSponsorIndex;
      });
    }
  }

  void generateBanner() async {
    // Create a GlobalKey for the RepaintBoundary
    GlobalKey boundaryKey = GlobalKey();
    bool isSharing = false; // Add this variable to track the sharing state

    if (selectedSponsorIndex != null) {
      // Get the selected sponsor's information
      final selectedSponsor = clubSponsorsNotifier!.clubSponsorsList[selectedSponsorIndex!];

      String website = selectedSponsor.website ?? '';

      // Remove "https://", if present
      website = website.replaceFirst('https://', '');

      // Show a dialog with the generated banner
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: alertDialogBackgroundColor,
            title: const Text(
              "Generated Banner",
              style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
            ),
            content: RepaintBoundary(
              key: boundaryKey,
              child: AspectRatio(
                aspectRatio: 1.0, // Make the content square
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/cpfc_new_sponsor_banner.png'), // Update with your asset image path
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    key: _bannerContentKeyed,
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.4,
                              child: Text(
                                'We are delighted to introduce ${selectedSponsor.name!}.\n Welcome aboard to the team!'.toUpperCase(),
                                style: GoogleFonts.courierPrime(fontSize: 9, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text(
                                website.isNotEmpty ? website : '', // Show an empty string if the website is empty
                                style: GoogleFonts.monomaniacOne(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w200),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel', style: TextStyle(color: Colors.black)),
              ),
              isSharing
                  ? const CircularProgressIndicator() // Show the progress indicator when sharing
                  : TextButton(
                      onPressed: () async {
                        setState(() {
                          isSharing = true; // Set the state to indicate sharing is in progress
                        });
                        // Navigator.of(context).pop();
                        await _submitForm();
                        _shareContent(boundaryKey);
                        Fluttertoast.showToast(
                          msg: 'Success! Generated',
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.deepOrangeAccent,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        Navigator.of(context).pop(); // Close the dialog after sharing
                      },
                      child: const Text('Share', style: TextStyle(color: Colors.black)),
                    ),
            ],
          );
        },
      );
    } else {
      // Show a toast message if no sponsor is selected
      Fluttertoast.showToast(
        msg: "Please select a sponsor before generating the banner.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: textColorTwo,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void _shareContent(GlobalKey boundaryKey) async {
    // Get the RenderObject from the RepaintBoundary using its key
    RenderRepaintBoundary boundary = boundaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    // Increase the pixelRatio for higher resolution
    double pixelRatio = 10.0; // You can adjust this value based on your needs
    double sharePixelRatio = 8.0; // You can adjust this value based on your needs
    ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
    ui.Image shareImage = await boundary.toImage(pixelRatio: sharePixelRatio);

    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    ByteData? shareByteData = await shareImage.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? pngBytes = byteData?.buffer.asUint8List();
    Uint8List? sharePngBytes = shareByteData?.buffer.asUint8List();

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
    var storageRefLowRes = FirebaseStorage.instance.ref().child('new_sponsor_event_banners/low_resolution/$fileNameLowRes');
    var storageRefHighRes = FirebaseStorage.instance.ref().child('new_sponsor_event_banners/high_resolution/$fileNameHighRes');

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

    String text = "You are welcome and appreciated to be a part of our club:";

    // Share the image with caption and text
    // await Share.file(
    //   'Event Information',
    //   'event_info.png',
    //   sharePngBytes as List<int>,
    //   'image/png',
    //   text: text,
    // );

    // Save the image temporarily

    final directory = await getTemporaryDirectory();
    final imagePath = '${directory.path}/event_info.png';
    await File(imagePath).writeAsBytes(sharePngBytes!);

    // Share the image with caption and text
    await Share.shareXFiles([XFile(imagePath)], text: text, subject: 'Coventry Phoenix FC');

    // await Share(sharePngBytes).writeAsBytesSync(bytes);

    // Return the high-resolution image URLs
    // return [lowResDownloadURL, highResDownloadURL];
  }

  // Create a GlobalKey for the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Firebase Firestore instance
  final firestore = FirebaseFirestore.instance;

  // Implement a function to handle form submission
  _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final firestore = FirebaseFirestore.instance;
      final newSponsorName = clubSponsorsNotifier!.clubSponsorsList[selectedSponsorIndex!].name!;

      String collectionName = 'NewSponsorBanners';
      Map<String, dynamic> data = {
        'id': '10',
        'new_sponsor_name': newSponsorName,
      };

      try {
        if (collectionName.isNotEmpty) {
          data['new_sponsor_name'] = newSponsorName;

          // Add the new member if the name doesn't exist
          await firestore.collection(collectionName).add(data);

          // _eventNameController.clear();
          // _eventSummaryController.clear();
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

  @override
  void initState() {
    ClubSponsorsNotifier clubSponsorsNotifier = Provider.of<ClubSponsorsNotifier>(context, listen: false);
    getClubSponsors(clubSponsorsNotifier);

    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  Future<bool> _onWillPop() async {
    bool shouldPop = false;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        backgroundColor: dialogBackgroundColor,
        title: const Text(
          'Are you sure?',
          style: TextStyle(color: Colors.white70),
        ),
        content: const Text(
          'Exiting now will discard your current work.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              shouldPop = false;
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          TextButton(
            onPressed: () {
              shouldPop = true;
              Navigator.of(context).pop();
            },
            child: const Text(
              'Exit',
              style: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );

    return shouldPop;
  }
}
