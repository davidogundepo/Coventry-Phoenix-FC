import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

Color backgroundColor = const Color.fromRGBO(48, 50, 74, 1.0);
Color appBarBackgroundColor = const Color.fromRGBO(48, 50, 74, 1.0);
Color appBarArrowColor = const Color.fromRGBO(187, 192, 195, 1.0);

class MyChangePagesCoverPhotoPage extends StatefulWidget {
  const MyChangePagesCoverPhotoPage({Key? key}) : super(key: key);

  @override
  State<MyChangePagesCoverPhotoPage> createState() => MyChangePagesCoverPhotoPageState();
}

class MyChangePagesCoverPhotoPageState extends State<MyChangePagesCoverPhotoPage> {
  bool _isSubmitting = false;
  final firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  final ImagePicker _picker = ImagePicker();
  final Map<int, File?> _imageMap = {};

  Future<void> _uploadAndSaveImage(String documentId, int imageIndex, File image) async {
    try {
      String imageUrl = await _uploadImageToStorage(image, 'sliver_image_${DateTime.now().millisecondsSinceEpoch}.jpg');

      if (documentId == 'non_slivers_pages' && imageIndex == 5) {
        // Update 'sidebar_page' field in the 'non_slivers_pages' document
        await firestore.collection('SliversPages').doc(documentId).update({
          'sidebar_page': imageUrl,
        });
      } else {
        // Update 'slivers_page_$imageIndex' field in other documents
        await firestore.collection('SliversPages').doc(documentId).update({
          'slivers_page_$imageIndex': imageUrl,
        });
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<String> _uploadImageToStorage(File imageFile, String imageName) async {
    try {
      final Reference storageReference = FirebaseStorage.instance.ref().child('sliver_image').child(imageName);
      final UploadTask uploadTask = storageReference.putFile(imageFile);

      await uploadTask.whenComplete(() {});
      final String imageUrl = await storageReference.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
      rethrow;
    }
  }

  final Map<String, int> fieldIndexes = {
    'Players List-I Page': 1,
    'Players List-II Page': 2,
    'Captains Page': 4,
    'Coaches Page': 5,
    'Management Body Page': 6,
    'Home Page': 7,
  };


  Future<void> _submitForm() async {
    if (!_isSubmitting) {
      setState(() {
        _isSubmitting = true;
      });

      try {
        // Check if any image is selected
        bool hasImage = _imageMap.values.any((image) => image != null);

        if (!hasImage) {
          // No image selected, show a toast
          _showNoImageSelectedToast();
          return;
        }

        String collectionName = 'SliversPages'; // Use your actual collection name

        if (collectionName.isNotEmpty) {
          QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firestore.collection(collectionName).where('slivers_pages', isEqualTo: 'slivers_pages').get();

          if (querySnapshot.docs.isNotEmpty) {
            // Assuming there is only one document with 'document_name' equal to 'slivers_pages'
            DocumentReference existingDocumentRef = querySnapshot.docs.first.reference;

            // Update the desired fields in the existing document
            fieldIndexes.forEach((itemName, imageIndex) async {
              if (_imageMap.containsKey(imageIndex) && _imageMap[imageIndex] != null) {
                await _uploadAndSaveImage(existingDocumentRef.id, imageIndex, _imageMap[imageIndex]!);
              }
            });

            _showSuccessToast();

            setState(() {
              _imageMap.clear();
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Document with name "slivers_pages" not found.'),
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Unsupported role: $collectionName'),
            ),
          );
        }
      } catch (e) {
        _showErrorToast(e.toString());
      } finally {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  void _showNoImageSelectedToast() {
    Fluttertoast.showToast(
      msg: "Please select a photo before submitting.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.orange, // You can customize the color
      textColor: Colors.white,
      fontSize: 16.0,
    );
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
          'Change Pages Covers',
          style: TextStyle(color: Colors.white70),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: appBarArrowColor),
          onPressed: () {
            navigateMyApp(context);
          },
        ),
      ),
      body: ListView(
        children: [
          ClosableMenuItem(
            image: _imageMap[1],
            pickImage: () => _pickImage(1),
            submitForm: () => _submitForm(),
            gifPath: 'assets/images/first_page_sliver.gif',
            itemName: 'Players List-I Page',
            isSubmitting: false, // Set it to false
          ),
          ClosableMenuItem(
            image: _imageMap[2],
            pickImage: () => _pickImage(2),
            submitForm: () => _submitForm(),
            gifPath: 'assets/images/second_page_sliver.gif',
            itemName: 'Players List-II Page',
            isSubmitting: false, // Set it to false
          ),
          ClosableMenuItem(
            image: _imageMap[4],
            pickImage: () => _pickImage(4),
            submitForm: () => _submitForm(),
            gifPath: 'assets/images/captains_page_sliver.gif',
            itemName: 'Captains Page',
            isSubmitting: false, // Set it to false
          ),
          ClosableMenuItem(
            image: _imageMap[5],
            pickImage: () => _pickImage(5),
            submitForm: () => _submitForm(),
            gifPath: 'assets/images/coach_page_sliver.gif',
            itemName: 'Coaches Page',
            isSubmitting: false, // Set it to false
          ),
          ClosableMenuItem(
            image: _imageMap[6],
            pickImage: () => _pickImage(6),
            submitForm: () => _submitForm(),
            gifPath: 'assets/images/mgmt_page_sliver.gif',
            itemName: 'Management Body Page',
            isSubmitting: false, // Set it to false
          ),
          ClosableMenuItem(
            image: _imageMap[7],
            pickImage: () => _pickImage(7),
            submitForm: () => _submitForm(),
            gifPath: 'assets/images/sidebar_page_sliver.gif',
            itemName: 'Home Page',
            isSubmitting: false, // Set it to false
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(int imageIndex) async {
    File? pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        _imageMap[imageIndex] = pickedImage;
      });
    }
  }
}

class ClosableMenuItem extends StatefulWidget {
  final File? image;
  final Future<void> Function() pickImage;
  final void Function() submitForm;
  final String gifPath;
  final String itemName; // New parameter for the item name
  final bool isSubmitting; // Add this line

  const ClosableMenuItem({
    Key? key,
    required this.image,
    required this.pickImage,
    required this.submitForm,
    required this.gifPath,
    required this.itemName,
    required this.isSubmitting,
  }) : super(key: key);

  @override
  ClosableMenuItemState createState() => ClosableMenuItemState(); // Remove isSubmitting from here
}

class ClosableMenuItemState extends State<ClosableMenuItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        ListTile(
          title: Row(
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _isExpanded
                    ? Icon(Icons.keyboard_arrow_up, color: Colors.white38, key: UniqueKey())
                    : Icon(Icons.keyboard_arrow_down, color: Colors.white38, key: UniqueKey()),
              ),
              const SizedBox(width: 8),
              Text(
                widget.itemName,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white38,
                ),
              ),
            ],
          ),
          onTap: () async {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
        ),
        if (_isExpanded)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
            ),
            margin: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).width * 0.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.asset(
                      widget.gifPath,
                      width: 390,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () async {
                    await widget.pickImage();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    height: MediaQuery.of(context).size.width / 4.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black.withAlpha(20),
                      border: Border.all(color: Colors.black26, width: 2),
                    ),
                    child: widget.image != null
                        ? Image.file(widget.image!, height: 100, width: 100, fit: BoxFit.cover)
                        : const Icon(Icons.image_rounded, color: Colors.white38, size: 60),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: widget.isSubmitting ? null : () => widget.submitForm(),
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(3.0), // Add this line for elevation
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white38),
                      ),
                      icon: Icon(
                        widget.isSubmitting ? Icons.hourglass_empty : Icons.cloud_upload,
                        color: Colors.black54,
                      ),
                      label: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Submit Image",
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                          if (widget.isSubmitting)
                            const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.black54,
                                strokeWidth: 3,
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
