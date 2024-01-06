import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../../bloc_navigation_bloc/navigation_bloc.dart';

class MyAddNewOppTeamPage extends StatefulWidget with NavigationStates {
  MyAddNewOppTeamPage({super.key});

  @override
  State<MyAddNewOppTeamPage> createState() => MyAddNewOppTeamPageState();
}

class MyAddNewOppTeamPageState extends State<MyAddNewOppTeamPage> {
  final TextEditingController _awayTeamNameController = TextEditingController();
  bool _isSubmitting = false;
  final _formKey = GlobalKey<FormState>();

  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
              TextFormField(
                controller: _awayTeamNameController,
                decoration: const InputDecoration(
                  labelText: 'Opposition Team Name',
                  hintText: "Alan Higgs FC",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () async {
                  final File? image = await _pickImage();
                  if (image != null) {
                    setState(() {
                      _selectedImage = image;
                    });
                  }
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black26, width: 2),
                  ),
                  child: _selectedImage != null
                      ? ClipOval(
                          child: Image.file(
                            _selectedImage!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Icon(Icons.add_a_photo, size: 40),
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(147, 165, 193, 1.0), // Change this color to your desired background color
                ),
                child: _isSubmitting
                    ? const CircularProgressIndicator()
                    : const Text(
                        'Add Opposition Team',
                        style: TextStyle(color: Colors.white70),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<File?> _pickImage() async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return null;

    return File(image.path);
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && !_isSubmitting) {
      setState(() {
        _isSubmitting = true;
      });

      final awayTeamName = _awayTeamNameController.text;

      try {
        // Upload image
        String? imageUrl = _selectedImage != null ? await _uploadImageToStorage(_selectedImage!, 'away_team_icon.jpg') : null;

        // Update Firestore document with data
        await FirebaseFirestore.instance.collection('MatchDayBannerForClubOpp').add({
          'id': '10',
          'club_name': awayTeamName,
          'club_icon': imageUrl ??
              'https://firebasestorage.googleapis.com/v0/b/cov-phoenix-fc.appspot.com/o/ClubLogos%2Fno_club_image.jpeg?alt=media&token=bfe1214e-8669-446b-ba88-b719fa9ec628', // Provide a default URL if image is not selected
        });

        // Show success toast
        _showSuccessToast();

        // Reset form and UI
        _formKey.currentState!.reset();
        setState(() {
          _awayTeamNameController.text = '';
          _selectedImage = null;
          _isSubmitting = false;
        });
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

  Future<String?> _uploadImageToStorage(File imageFile, String imageName) async {
    try {
      // Generate a unique filename using the current date and time
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      String uniqueImageName = 'away_team_icon_$timestamp.jpg';

      final Reference storageReference = FirebaseStorage.instance.ref().child('away_team_icons').child(uniqueImageName);
      final UploadTask uploadTask = storageReference.putFile(imageFile);

      await uploadTask.whenComplete(() {});
      final String imageUrl = await storageReference.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  void _showSuccessToast() {
    Fluttertoast.showToast(
      msg: "Away Team added successfully",
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
}
