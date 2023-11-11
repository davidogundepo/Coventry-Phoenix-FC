import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../bloc_navigation_bloc/navigation_bloc.dart';


Color backgroundColor = const Color.fromRGBO(235, 238, 239, 1.0);

class MyAddClubSponsorPage extends StatefulWidget with NavigationStates  {
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
    final querySnapshot = await firestore
        .collection(collectionName)
        .where('name', isEqualTo: fullName)
        .get();
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
        'image': 'https://firebasestorage.googleapis.com/v0/b/cov-phoenix-fc.appspot.com/o/ClubSponsors%2Fclub_sponsor_default.jpeg?alt=media&token=20a8e9c6-b2dd-413a-9bbc-cc189d7bfe9f',
        'image_two': 'https://firebasestorage.googleapis.com/v0/b/cov-phoenix-fc.appspot.com/o/ClubSponsors%2Fclub_sponsor_default.jpeg?alt=media&token=20a8e9c6-b2dd-413a-9bbc-cc189d7bfe9f',
        'image_three': 'https://firebasestorage.googleapis.com/v0/b/cov-phoenix-fc.appspot.com/o/ClubSponsors%2Fclub_sponsor_default.jpeg?alt=media&token=20a8e9c6-b2dd-413a-9bbc-cc189d7bfe9f',
        'image_four': 'https://firebasestorage.googleapis.com/v0/b/cov-phoenix-fc.appspot.com/o/ClubSponsors%2Fclub_sponsor_default.jpeg?alt=media&token=20a8e9c6-b2dd-413a-9bbc-cc189d7bfe9f',
        'image_five': 'https://firebasestorage.googleapis.com/v0/b/cov-phoenix-fc.appspot.com/o/ClubSponsors%2Fclub_sponsor_default.jpeg?alt=media&token=20a8e9c6-b2dd-413a-9bbc-cc189d7bfe9f',
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

  Future<void> addDataToCollection(
      FirebaseFirestore firestore, String collectionName, Map<String, dynamic> data) async {
    await firestore.collection(collectionName).add(data);
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
                  hintStyle: TextStyle(color: Colors.black54, fontSize: 13),),
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
                  hintStyle: TextStyle(color: Colors.black54, fontSize: 13),),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a role';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 70),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Add Club Sponsor'),
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