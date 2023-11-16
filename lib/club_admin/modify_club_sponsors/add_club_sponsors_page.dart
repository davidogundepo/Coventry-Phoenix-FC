import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../bloc_navigation_bloc/navigation_bloc.dart';

Color backgroundColor = const Color.fromRGBO(235, 238, 239, 1.0);

class MyAddClubSponsorPage extends StatefulWidget with NavigationStates {
  MyAddClubSponsorPage({super.key});

  @override
  State<MyAddClubSponsorPage> createState() => MyAddClubSponsorPageState();
}

class MyAddClubSponsorPageState extends State<MyAddClubSponsorPage> {
  // Define variables to store form input
  TextEditingController _sponsorNameController = TextEditingController();
  TextEditingController _clubSponsoringSummaryController = TextEditingController();

  // Create a GlobalKey for the form
  final _formKey = GlobalKey<FormState>();

  // Firebase Firestore instance
  final firestore = FirebaseFirestore.instance;

  // Function to check if a member with the same name exists
  Future<bool> doesNameExist(String fullName, String collectionName) async {
    final querySnapshot = await firestore.collection(collectionName).where('name', isEqualTo: fullName).get();
    return querySnapshot.docs.isNotEmpty;
  }

  // Implement a function to handle form submission
  _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final firestore = FirebaseFirestore.instance;
      final sponsorName = _sponsorNameController.text;
      final clubSponsorSummary = _clubSponsoringSummaryController.text;

      String collectionName = 'ClubSponsors';
      Map<String, dynamic> data = {
        'id': '10',
        'about_us': clubSponsorSummary,
        'address': '',
        'category': '',
        'email': '',
        'facebook': '',
        'image':
            'https://firebasestorage.googleapis.com/v0/b/cov-phoenix-fc.appspot.com/o/ClubSponsors%2Fclub_sponsor_default.jpeg?alt=media&token=20a8e9c6-b2dd-413a-9bbc-cc189d7bfe9f',
        'image_two':
            'https://firebasestorage.googleapis.com/v0/b/cov-phoenix-fc.appspot.com/o/ClubSponsors%2Fclub_sponsor_default.jpeg?alt=media&token=20a8e9c6-b2dd-413a-9bbc-cc189d7bfe9f',
        'image_three':
            'https://firebasestorage.googleapis.com/v0/b/cov-phoenix-fc.appspot.com/o/ClubSponsors%2Fclub_sponsor_default.jpeg?alt=media&token=20a8e9c6-b2dd-413a-9bbc-cc189d7bfe9f',
        'image_four':
            'https://firebasestorage.googleapis.com/v0/b/cov-phoenix-fc.appspot.com/o/ClubSponsors%2Fclub_sponsor_default.jpeg?alt=media&token=20a8e9c6-b2dd-413a-9bbc-cc189d7bfe9f',
        'image_five':
            'https://firebasestorage.googleapis.com/v0/b/cov-phoenix-fc.appspot.com/o/ClubSponsors%2Fclub_sponsor_default.jpeg?alt=media&token=20a8e9c6-b2dd-413a-9bbc-cc189d7bfe9f',
        'instagram': '',
        'name': sponsorName,
        'our_services': '',
        'phone': '',
        'snapchat': '',
        'sponsor_icon': '',
        'twitter': '',
        'website': '',
        'youtube': '',
      };

      try {
        if (collectionName.isNotEmpty) {
          data['name'] = sponsorName;
          data['about_us'] = clubSponsorSummary;

          // Add the new member if the name doesn't exist
          await firestore.collection(collectionName).add(data);

          _sponsorNameController.clear();
          _clubSponsoringSummaryController.clear();
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
            content: Text('Error creating sponsor: $e'),
          ),
        );
      }
    }
  }

  ////

  final ImagePicker _picker = ImagePicker();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  File? _imageOne;
  File? _imageTwo;
  File? _imageThree;
  File? _imageFour;
  File? _imageFive;
  String _userName = 'name'; // Replace with the actual user's name

  Future<String?> uploadImageToStorage(File imageFile, String imageName) async {
    try {
      final Reference storageReference = FirebaseStorage.instance.ref().child('players_images').child(_userName).child(imageName);
      final UploadTask uploadTask = storageReference.putFile(imageFile);

      await uploadTask.whenComplete(() {});
      final String imageUrl = await storageReference.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<File?> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;

    return File(image.path);
  }

  Future<void> _checkAndUpdatePhoto(String imageUrl, String imageName) async {
    try {
      // Fetch the document based on the user name (or any other criteria)
      QuerySnapshot querySnapshot = await _firestore
          .collection('ClubSponsors')
          .where('name', isEqualTo: _userName) // Replace with the actual field used for user identification
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the first document from the query results
        DocumentSnapshot documentSnapshot = querySnapshot.docs[0];

        // Update the user document with the new image URL
        await documentSnapshot.reference.update({imageName: imageUrl});
      } else {
        print('Document not found for user: $_userName');
      }
    } catch (e) {
      print('Error updating photo: $e');
    }

    // Usage
    // Upload image one to storage
    String? imageUrlOne = await uploadImageToStorage(_imageOne!, 'image_one.jpg');

    // Check if imageUrlOne is not null before using it
    if (imageUrlOne != null) {
      await _checkAndUpdatePhoto(imageUrlOne, 'image_one');
    } else {
      print('Image upload failed for image one');
    }

    // Similarly, for the second image
    String? imageUrlTwo = await uploadImageToStorage(_imageTwo!, 'image_two.jpg');

    // Check if imageUrlTwo is not null before using it
    if (imageUrlTwo != null) {
      await _checkAndUpdatePhoto(imageUrlTwo, 'image_two');
    } else {
      print('Image upload failed for image two');
    }

    // Upload image three to storage
    String? imageUrlThree = await uploadImageToStorage(_imageOne!, 'image_three.jpg');

    // Check if imageUrlThree is not null before using it
    if (imageUrlThree != null) {
      await _checkAndUpdatePhoto(imageUrlThree, 'image_three');
    } else {
      print('Image upload failed for image three');
    }

    // Similarly, for the fourth image
    String? imageUrlFour = await uploadImageToStorage(_imageTwo!, 'image_four.jpg');

    // Check if imageUrlFour is not null before using it
    if (imageUrlTwo != null) {
      await _checkAndUpdatePhoto(imageUrlTwo, 'image_four');
    } else {
      print('Image upload failed for image four');
    }

    // Upload image five to storage
    String? imageUrlFive = await uploadImageToStorage(_imageOne!, 'image_five.jpg');

    // Check if imageUrlFive is not null before using it
    if (imageUrlFive != null) {
      await _checkAndUpdatePhoto(imageUrlFive, 'image_five');
    } else {
      print('Image upload failed for image five');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _sponsorNameController,
                decoration: const InputDecoration(
                  labelText: 'Sponsor Name',
                  hintText: "Nouvellesoft Inc.",
                  hintStyle: TextStyle(color: Colors.black54, fontSize: 13),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _clubSponsoringSummaryController,
                decoration: const InputDecoration(
                  labelText: "Sponsor's Role",
                  hintText: "We sponsor the Over 35's road trips all over The UK, during their matchday to and fro.",
                  hintStyle: TextStyle(color: Colors.black54, fontSize: 13),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a role';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 50),
              const Text(
                "Click to upload sponsor's images (5 max)",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600
                ),
              ),
              const SizedBox(height: 30),
              // Display the selected images or placeholder icons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () async {
                      // final File? image = await pickImage();
                      // if (image != null) {
                      //   setState(() {
                      //     _imageOne = image;
                      //   });
                      // }
                    },
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
                            : const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Icon(Icons.person, size: 60), Text('One')],
                              )),
                  ),
                  InkWell(
                    onTap: () async {
                      final File? image = await pickImage();
                      if (image != null) {
                        setState(() {
                          _imageTwo = image;
                        });
                      }
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                        width: MediaQuery.sizeOf(context).width / 4.1,
                        height: MediaQuery.sizeOf(context).width / 3.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black.withAlpha(20),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: _imageTwo != null ? Image.file(_imageTwo!, height: 100, width: 100) : const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Icon(Icons.person, size: 60), Text('Two')],
                              )),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () async {
                      final File? image = await pickImage();
                      if (image != null) {
                        setState(() {
                          _imageThree = image;
                        });
                      }
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                        width: MediaQuery.sizeOf(context).width / 4.1,
                        height: MediaQuery.sizeOf(context).width / 3.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black.withAlpha(20),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: _imageThree != null ? Image.file(_imageThree!, height: 100, width: 100) : const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Icon(Icons.person, size: 60), Text('Three')],
                              )),
                  ),
                  InkWell(
                    onTap: () async {
                      final File? image = await pickImage();
                      if (image != null) {
                        setState(() {
                          _imageFour = image;
                        });
                      }
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                        width: MediaQuery.sizeOf(context).width / 4.1,
                        height: MediaQuery.sizeOf(context).width / 3.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black.withAlpha(20),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: _imageFour != null ? Image.file(_imageFour!, height: 100, width: 100) : const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Icon(Icons.person, size: 60), Text('Four')],
                              )),
                  ),
                  InkWell(
                    onTap: () async {
                      final File? image = await pickImage();
                      if (image != null) {
                        setState(() {
                          _imageFive = image;
                        });
                      }
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                        width: MediaQuery.sizeOf(context).width / 4.1,
                        height: MediaQuery.sizeOf(context).width / 3.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black.withAlpha(20),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: _imageFive != null ? Image.file(_imageFive!, height: 100, width: 100) : const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Icon(Icons.person, size: 60), Text('Five')],
                              )),
                  ),
                ],
              ),
              const SizedBox(height: 70),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Add Club Sponsor'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
