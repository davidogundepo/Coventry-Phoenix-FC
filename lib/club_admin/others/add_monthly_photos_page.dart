import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

Color backgroundColor = const Color.fromRGBO(97, 101, 137, 1.0);
Color appBarBackgroundColor = const Color.fromRGBO(48, 50, 74, 1.0);
Color appBarArrowColor = const Color.fromRGBO(187, 192, 195, 1.0);

class MyAddMonthlyPhotosPage extends StatefulWidget {
  const MyAddMonthlyPhotosPage({Key? key}) : super(key: key);

  @override
  State<MyAddMonthlyPhotosPage> createState() => MyAddMonthlyPhotosPageState();
}

class MyAddMonthlyPhotosPageState extends State<MyAddMonthlyPhotosPage> {
  bool _isSubmitting = false;
  final _formKey = GlobalKey<FormState>();
  final firestore = FirebaseFirestore.instance;

  int _highestId = 0;

  @override
  void initState() {
    super.initState();
    _getHighestId();
  }

  Future<void> _getHighestId() async {
    final snapshot = await firestore.collection('TrainingsAndGamesReels').orderBy('id', descending: true).limit(1).get();
    if (snapshot.docs.isNotEmpty) {
      _highestId = snapshot.docs.first['id'] as int;
    }
  }

  int _getNewId() {
    _highestId++;
    return _highestId;
  }

  final ImagePicker _picker = ImagePicker();
  File? _imageOne;
  File? _imageTwo;
  File? _imageThree;
  File? _imageFour;
  File? _imageFive;

  Future<void> _uploadAndSaveImages(String documentId, int imageIndex) async {
    try {
      File? image;

      switch (imageIndex) {
        case 1:
          image = _imageOne;
          break;
        case 2:
          image = _imageTwo;
          break;
        case 3:
          image = _imageThree;
          break;
        case 4:
          image = _imageFour;
          break;
        case 5:
          image = _imageFive;
          break;
      }

      if (image != null) {
        String? imageUrl = await _uploadImageToStorage(image, 'image_${DateTime.now().millisecondsSinceEpoch}.jpg');

        await firestore.collection('TrainingsAndGamesReels').doc(documentId).set({
          'id': _getNewId(),
          'image': imageUrl,
        });
      }
    } catch (e) {
      print('Error uploading images: $e');
    }
  }

  Future<String?> _uploadImageToStorage(File imageFile, String imageName) async {
    try {
      final Reference storageReference = FirebaseStorage.instance.ref().child('club_training_match_images').child(imageName);
      final UploadTask uploadTask = storageReference.putFile(imageFile);

      await uploadTask.whenComplete(() {});
      final String imageUrl = await storageReference.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  _submitForm() async {
    if (_formKey.currentState!.validate() && !_isSubmitting) {
      bool imagesSelected = _imageOne != null ||
          _imageTwo != null ||
          _imageThree != null ||
          _imageFour != null ||
          _imageFive != null;

      if (!imagesSelected) {
        _showErrorToast("Please select one or more images.");
        return;
      }

      setState(() {
        _isSubmitting = true;
      });

      try {
        // Update _highestId with the latest value from Firestore
        await _getHighestId();

        for (int i = 1; i <= 5; i++) {
          String collectionName = 'TrainingsAndGamesReels';

          if (collectionName.isNotEmpty) {
            if ((i == 1 && _imageOne != null) ||
                (i == 2 && _imageTwo != null) ||
                (i == 3 && _imageThree != null) ||
                (i == 4 && _imageFour != null) ||
                (i == 5 && _imageFive != null)) {
              DocumentReference newTrainingsAndGamesReelsRef = await firestore.collection(collectionName).add({
                'id': _getNewId(),
                'image': '',
              });

              await _uploadAndSaveImages(newTrainingsAndGamesReelsRef.id, i);
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Unsupported role: $collectionName'),
              ),
            );
          }
        }

        _showSuccessToast();

        setState(() {
          _imageOne = null;
          _imageTwo = null;
          _imageThree = null;
          _imageFour = null;
          _imageFive = null;

          _isSubmitting = false;
        });
      } catch (e) {
        _showErrorToast(e.toString());

        setState(() {
          _isSubmitting = false;
        });
      }
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
      appBar: AppBar(
        backgroundColor: appBarBackgroundColor,
        title: const Text(
          'Add Monthly Photos',
          style: TextStyle(color: Colors.white70),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: appBarArrowColor),
          onPressed: () {
            navigateMyApp(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 20),
              // Display the GIF image
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                child: Image.asset(
                  'assets/images/monthly_photos.gif',
                  height: MediaQuery.sizeOf(context).height * 0.13,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Click to upload images (5 max per time)",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  color: Colors.white70
                ),
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
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black26),
                ),
                child: _isSubmitting
                    ? const CircularProgressIndicator()
                    : const Text(
                    'Add Training and Match Photos',
                  style: TextStyle(
                    color: Colors.white70
                  ),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future navigateMyApp(context) async {
  Navigator.of(context).pop(false);
}

void _showSuccessToast() {
  Fluttertoast.showToast(
    msg: "Club Images added successfully",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

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
