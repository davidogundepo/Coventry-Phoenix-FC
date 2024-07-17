import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../bloc_navigation_bloc/navigation_bloc.dart';

class MyAddNewHomeTeamPage extends StatefulWidget with NavigationStates {
  MyAddNewHomeTeamPage({super.key});

  @override
  State<MyAddNewHomeTeamPage> createState() => MyAddNewHomeTeamPageState();
}

class MyAddNewHomeTeamPageState extends State<MyAddNewHomeTeamPage> {
  final TextEditingController _homeTeamNameController = TextEditingController();
  bool _isSubmitting = false;
  final _formKey = GlobalKey<FormState>();

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
                controller: _homeTeamNameController,
                decoration: const InputDecoration(
                  labelText: 'Home Team Name',
                  hintText: "Coventry Phoenix U14",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(147, 165, 193, 1.0), // Change this color to your desired background color
                ),
                child: _isSubmitting
                    ? const CircularProgressIndicator()
                    : const Text(
                        'Add Home Team',
                        style: TextStyle(color: Colors.white70),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && !_isSubmitting) {
      setState(() {
        _isSubmitting = true;
      });

      final homeTeamName = _homeTeamNameController.text;

      try {
        // Update Firestore document with data
        await FirebaseFirestore.instance.collection('MatchDayBannerForClub').add({
          'id': '10',
          'club_name': homeTeamName,
          'club_icon':
              'https://firebasestorage.googleapis.com/v0/b/cov-phoenix-fc.appspot.com/o/ClubLogos%2Fcov_phoenix_fc_bg_less.png?alt=media&token=66244d85-23d2-443a-8251-0d35b6ae2137', // Provide a default URL if image is not selected
        });

        // Show success toast
        _showSuccessToast();

        // Reset form and UI
        _formKey.currentState!.reset();
        setState(() {
          _homeTeamNameController.text = '';
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

  void _showSuccessToast() {
    Fluttertoast.showToast(
      msg: "Home Team added successfully",
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
