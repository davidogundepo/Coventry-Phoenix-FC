import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  final TextEditingController _sponsorNameController = TextEditingController();
  final TextEditingController _clubSponsoringSummaryController = TextEditingController();

  String? sponsorName;

  bool _isSubmitting = false;

  // Create a GlobalKey for the form
  final _formKey = GlobalKey<FormState>();

  // Firebase Firestore instance
  final firestore = FirebaseFirestore.instance;

  // Function to check if a member with the same name exists
  Future<bool> doesNameExist(String fullName, String collectionName) async {
    final querySnapshot = await firestore.collection(collectionName).where('name', isEqualTo: fullName).get();
    return querySnapshot.docs.isNotEmpty;
  }

  Map<String, dynamic> data = {
    'id': '10',
    'about_us': '',
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
    'name': '',
    'our_services': '',
    'phone': '',
    'snapchat': '',
    'sponsor_icon': '',
    'twitter': '',
    'website': '',
    'youtube': '',
  };

  // Implement a function to handle form submission
  _submitForm() async {
    if (_formKey.currentState!.validate() && !_isSubmitting) {
      setState(() {
        _isSubmitting = true; // Start submitting
      });
      final firestore = FirebaseFirestore.instance;
      sponsorName = _sponsorNameController.text;
      final clubSponsorSummary = _clubSponsoringSummaryController.text;

      String collectionName = 'ClubSponsors';

      // Check if the name already exists
      bool nameExists = await doesNameExist(sponsorName!, collectionName);

      if (nameExists) {
        // Show error toast
        _showErrorToast('Sponsor name already exists.');
        setState(() {
          _isSubmitting = false; // Stop submitting
        });
        return;
      }

      // Update the data values
      data['name'] = sponsorName;
      data['about_us'] = clubSponsorSummary;

      try {
        if (collectionName.isNotEmpty) {
          /// Add the new member if the name doesn't exist
          DocumentReference newSponsorRef = await firestore.collection(collectionName).add(data);

          // Check if images are selected before calling _uploadAndSaveImages
          if (_imageOne != null || _imageTwo != null || _imageThree != null || _imageFour != null || _imageFive != null) {
            // Upload and update images
            await _uploadAndSaveImages(newSponsorRef.id);
          }

          // Show success toast
          _showSuccessToast();

          // Update UI to reflect changes
          setState(() {
            _sponsorNameController.clear();
            _clubSponsoringSummaryController.clear();

            // Reset images to null
            _imageOne = null;
            _imageTwo = null;
            _imageThree = null;
            _imageFour = null;
            _imageFive = null;

            _isSubmitting = false; // Stop submitting
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Unsupported role: $collectionName'),
            ),
          );
          // Update UI to stop submitting
          setState(() {
            _isSubmitting = false;
          });
        }
      } catch (e) {
        // Show error toast
        _showErrorToast(e.toString());
        // Update UI to stop submitting
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  ////

  final ImagePicker _picker = ImagePicker();
  File? _imageOne;
  File? _imageTwo;
  File? _imageThree;
  File? _imageFour;
  File? _imageFive;

  Future<void> _uploadAndSaveImages(String documentId) async {
    try {
      String? imageUrlOne = _imageOne != null ? await _uploadImageToStorage(_imageOne!, 'image_one.jpg') : null;
      String? imageUrlTwo = _imageTwo != null ? await _uploadImageToStorage(_imageTwo!, 'image_two.jpg') : null;
      String? imageUrlThree = _imageThree != null ? await _uploadImageToStorage(_imageThree!, 'image_three.jpg') : null;
      String? imageUrlFour = _imageFour != null ? await _uploadImageToStorage(_imageFour!, 'image_four.jpg') : null;
      String? imageUrlFive = _imageFive != null ? await _uploadImageToStorage(_imageFive!, 'image_five.jpg') : null;

      // Update Firestore document with image URLs
      await firestore.collection('ClubSponsors').doc(documentId).update({
        'image': imageUrlOne ?? data['image'],
        'image_two': imageUrlTwo ?? data['image_two'],
        'image_three': imageUrlThree ?? data['image_three'],
        'image_four': imageUrlFour ?? data['image_four'],
        'image_five': imageUrlFive ?? data['image_five'],
      });
    } catch (e) {
      print('Error uploading images: $e');
    }
  }

  Future<String?> _uploadImageToStorage(File imageFile, String imageName) async {
    try {
      final Reference storageReference = FirebaseStorage.instance.ref().child('club_sponsor_images').child(sponsorName!).child(imageName);
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
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 30),
              // Display the selected images or placeholder icons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () async {
                      final File? image = await pickImage();
                      if (image != null) {
                        setState(() {
                          _imageOne = image;
                        });
                      }
                    },
                    child: Container(
                        width: MediaQuery.sizeOf(context).width / 4.1,
                        height: MediaQuery.sizeOf(context).width / 3.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black.withAlpha(20),
                          border: Border.all(color: Colors.black26, width: 2),
                        ),
                        child: _imageOne != null
                            ? Image.file(_imageOne!, height: 100, width: 100, fit: BoxFit.cover)
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
                          border: Border.all(color: Colors.black26, width: 2),
                        ),
                        child: _imageTwo != null
                            ? Image.file(_imageTwo!, height: 100, width: 100, fit: BoxFit.cover)
                            : const Column(
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
                          border: Border.all(color: Colors.black26, width: 2),
                        ),
                        child: _imageThree != null
                            ? Image.file(_imageThree!, height: 100, width: 100, fit: BoxFit.cover)
                            : const Column(
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
                          border: Border.all(color: Colors.black26, width: 2),
                        ),
                        child: _imageFour != null
                            ? Image.file(_imageFour!, height: 100, width: 100, fit: BoxFit.cover)
                            : const Column(
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
                          border: Border.all(color: Colors.black26, width: 2),
                        ),
                        child: _imageFive != null
                            ? Image.file(_imageFive!, height: 100, width: 100, fit: BoxFit.cover)
                            : const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Icon(Icons.person, size: 60), Text('Five')],
                              )),
                  ),
                ],
              ),
              const SizedBox(height: 70),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submitForm,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
                ),
                child: _isSubmitting
                    ? const CircularProgressIndicator() // Show circular progress indicator
                    : const Text('Add Club Sponsor'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to show a success toast
  void _showSuccessToast() {
    Fluttertoast.showToast(
      msg: "Club sponsor added successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  // Function to show an error toast
  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: "Error: $message",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
