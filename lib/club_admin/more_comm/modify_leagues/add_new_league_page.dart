import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../bloc_navigation_bloc/navigation_bloc.dart';

class MyAddNewLeaguePage extends StatefulWidget with NavigationStates {
  MyAddNewLeaguePage({super.key});

  @override
  State<MyAddNewLeaguePage> createState() => MyAddNewLeaguePageState();
}

class MyAddNewLeaguePageState extends State<MyAddNewLeaguePage> {
  final TextEditingController _leagueNameController = TextEditingController();
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
                controller: _leagueNameController,
                decoration: const InputDecoration(
                  labelText: 'League Name',
                  hintText: "Premier League",
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
                  primary: const Color.fromRGBO(147, 165, 193, 1.0), // Change this color to your desired background color
                ),
                child: _isSubmitting
                    ? const CircularProgressIndicator()
                    : const Text(
                        'Add New League',
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

      final leagueName = _leagueNameController.text;

      try {
        // Update Firestore document with data
        await FirebaseFirestore.instance.collection('MatchDayBannerForLeague').add({
          'id': '10',
          'league': leagueName,
        });

        // Show success toast
        _showSuccessToast();

        // Reset form and UI
        _formKey.currentState!.reset();
        setState(() {
          _leagueNameController.text = '';
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
      msg: "League added successfully",
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
