import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:coventry_phoenix_fc/bloc_navigation_bloc/navigation_bloc.dart';

Color conColor = const Color.fromRGBO(194, 194, 220, 1.0);
Color conColorTwo = const Color.fromRGBO(151, 147, 151, 1.0);
Color textColor = const Color.fromRGBO(222, 214, 214, 1.0);
Color whiteColor = const Color.fromRGBO(255, 253, 253, 1.0);
Color twitterColor = const Color.fromRGBO(36, 81, 149, 1.0);
Color instagramColor = const Color.fromRGBO(255, 255, 255, 1.0);
Color facebookColor = const Color.fromRGBO(43, 103, 195, 1.0);
Color snapchatColor = const Color.fromRGBO(222, 163, 36, 1.0);
Color youtubeColor = const Color.fromRGBO(220, 45, 45, 1.0);
Color websiteColor = const Color.fromRGBO(104, 79, 178, 1.0);
Color emailColor = const Color.fromRGBO(230, 45, 45, 1.0);
Color phoneColor = const Color.fromRGBO(20, 134, 46, 1.0);
Color backgroundColor = const Color.fromRGBO(237, 241, 241, 1.0);

class MyAddClubMemberPage extends StatefulWidget with NavigationStates {
  MyAddClubMemberPage({Key? key}) : super(key: key);

  @override
  State<MyAddClubMemberPage> createState() => MyAddClubMemberPageState();
}

class MyAddClubMemberPageState extends State<MyAddClubMemberPage> {

  // Define variables to store form input
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  String _selectedRole = 'Returning Player'; // Default value

  // Create a list of role options for the dropdown menu
  List<String> _roleOptions = ['Returning Player', 'New Player', 'Coach', 'Manager'];

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
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final firestore = FirebaseFirestore.instance;
      final firstName = _firstNameController.text;
      final lastName = _lastNameController.text;
      final fullName = '$firstName $lastName'; // Combine first and last names
      final role = _selectedRole;
      String collectionName = '';
      Map<String, dynamic> data = {};

      switch (role) {
        case 'Returning Player':
          collectionName = 'FirstTeamClassPlayers';
          data = {
            'id': '10',
            'autobio': '',
            'best_moment': '',
            'email': '',
            'facebook': '',
            'image': 'https://firebasestorage.googleapis.com/v0/b/uk-football-club-template.appspot.com/o/Footballers%2Ff_8.jpeg?alt=media&token=753c98c2-fb09-4ef4-94fa-8557ba42320d',
            'image_two': 'https://firebasestorage.googleapis.com/v0/b/uk-football-club-template.appspot.com/o/Footballers%2Ff_8.jpeg?alt=media&token=753c98c2-fb09-4ef4-94fa-8557ba42320d',
            'instagram': '',
            'name': fullName,
            'nickname': '',
            'phone': '',
            'team_captaining': '',
            'captain': '',
            'constituent_country': '',
            'region_from': '',
            'twitter': '',
            'd_o_b': '',
            'dream_fc': '',
            'position_playing': '',
            'snapchat': '',
            'tiktok': '',
            'linkedIn': '',
            'other_positions_of_play': '',
            'fav_football_legend': '',
            'year_of_inception': '',
            'adidas_or_nike': '',
            'ronaldo_or_messi': '',
            'left_or_right': '',
            'hobbies': '',
            'my_dropline': '',
            'philosophy': '',
            'worst_moment': '',
          };
          break;
        case 'New Player':
          collectionName = 'SecondTeamClassPlayers';
          data = {
            'id': '10',
            'autobio': '',
            'best_moment': '',
            'email': '',
            'facebook': '',
            'image': 'https://firebasestorage.googleapis.com/v0/b/uk-football-club-template.appspot.com/o/Footballers%2Ff_8.jpeg?alt=media&token=753c98c2-fb09-4ef4-94fa-8557ba42320d',
            'image_two': 'https://firebasestorage.googleapis.com/v0/b/uk-football-club-template.appspot.com/o/Footballers%2Ff_8.jpeg?alt=media&token=753c98c2-fb09-4ef4-94fa-8557ba42320d',
            'instagram': '',
            'name': fullName,
            'nickname': '',
            'phone': '',
            'team_captaining': '',
            'captain': '',
            'constituent_country': '',
            'region_from': '',
            'twitter': '',
            'd_o_b': '',
            'dream_fc': '',
            'position_playing': '',
            'snapchat': '',
            'tiktok': '',
            'linkedIn': '',
            'other_positions_of_play': '',
            'fav_football_legend': '',
            'year_of_inception': '',
            'adidas_or_nike': '',
            'ronaldo_or_messi': '',
            'left_or_right': '',
            'hobbies': '',
            'my_dropline': '',
            'philosophy': '',
            'worst_moment': '',
          };
          break;
        case 'Coach':
          collectionName = 'Coaches';
          data = {
            'id': '10',
            'autobio': '',
            'email': '',
            'facebook': '',
            'image': 'https://firebasestorage.googleapis.com/v0/b/uk-football-club-template.appspot.com/o/Footballers%2Ff_8.jpeg?alt=media&token=753c98c2-fb09-4ef4-94fa-8557ba42320d',
            'image_two': 'https://firebasestorage.googleapis.com/v0/b/uk-football-club-template.appspot.com/o/Footballers%2Ff_8.jpeg?alt=media&token=753c98c2-fb09-4ef4-94fa-8557ba42320d',
            'instagram': '',
            'name': fullName,
            'phone': '',
            'twitter': '',
            'linkedIn': '',
            'year_of_inception': '',
            'region_of_origin': '',
            'nationality': '',
            'hobbies': '',
            'best_moment': '',
            'worst_moment': '',
            'staff_position': '',
            'philosophy': '',
            'why_you_love_coaching_or_fc_management': '',
            'fav_sporting_icon': '',
          };
          break;
        case 'Manager':
          collectionName = 'ManagementBody';
          data = {
            'id': '10',
            'autobio': '',
            'email': '',
            'facebook': '',
            'image': 'https://firebasestorage.googleapis.com/v0/b/uk-football-club-template.appspot.com/o/Footballers%2Ff_8.jpeg?alt=media&token=753c98c2-fb09-4ef4-94fa-8557ba42320d',
            'image_two': 'https://firebasestorage.googleapis.com/v0/b/uk-football-club-template.appspot.com/o/Footballers%2Ff_8.jpeg?alt=media&token=753c98c2-fb09-4ef4-94fa-8557ba42320d',
            'instagram': '',
            'name': fullName,
            'phone': '',
            'twitter': '',
            'linkedIn': '',
            'year_of_inception': '',
            'region_of_origin': '',
            'nationality': '',
            'hobbies': '',
            'best_moment': '',
            'worst_moment': '',
            'staff_position': '',
            'philosophy': '',
            'why_you_love_coaching_or_fc_management': '',
            'fav_sporting_icon': '',
          };
          break;
        default:
          break;
      }

      try {
        if (collectionName.isNotEmpty) {
          data['name'] = fullName;
          data['role'] = role;

          // Check if the member already exists
          bool nameExists = await doesNameExist(fullName, collectionName);

          if (nameExists) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('The name "$fullName" already exists in the $collectionName collection.'),
              ),
            );
          } else {
            // Add the new member if the name doesn't exist
            await firestore.collection(collectionName).add(data);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('New member added to $collectionName collection'),
              ),
            );

            _firstNameController.clear();
            _lastNameController.clear();
            setState(() {
              _selectedRole = 'Returning Player';
            });
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Unsupported role: $role'),
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error adding member: $e'),
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
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Second Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedRole,
                onChanged: (newValue) {
                  setState(() {
                    _selectedRole = newValue!;
                  });
                },
                items: _roleOptions.map((role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Role'),
              ),
              SizedBox(height: 80),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Add Club Member'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}