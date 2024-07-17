import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:coventry_phoenix_fc/bloc_navigation_bloc/navigation_bloc.dart';


Color backgroundColor = const Color.fromRGBO(237, 241, 241, 1.0);

class MyAddClubMemberPage extends StatefulWidget with NavigationStates {
  MyAddClubMemberPage({Key? key}) : super(key: key);

  @override
  State<MyAddClubMemberPage> createState() => MyAddClubMemberPageState();
}

class MyAddClubMemberPageState extends State<MyAddClubMemberPage> {

  // Define variables to store form input
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  String _selectedRole = 'Coventry Phoenix I Players'; // Default value

  // Create a list of role options for the dropdown menu
  final List<String> _roleOptions = ['Coventry Phoenix I Players', 'Coventry Phoenix II Players', 'Coach', 'Manager'];

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
        case 'Coventry Phoenix I Players':
          collectionName = 'FirstTeamClassPlayers';
          data = {
            'id': '10',
            'autobio': '',
            'best_moment': '',
            'email': '',
            'facebook': '',
            'image': 'https://firebasestorage.googleapis.com/v0/b/cov-phoenix-fc.appspot.com/o/Players%2FAI_GENERATED%2Fai_player_1.jpg?alt=media&token=585caeeb-2d2c-4dd9-a298-c802f9998356',
            'image_two': 'https://firebasestorage.googleapis.com/v0/b/cov-phoenix-fc.appspot.com/o/Players%2FAI_GENERATED%2Fai_player_2.jpg?alt=media&token=6f10032a-813e-476e-92ee-d34bb35bfff0',
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
        case 'Coventry Phoenix II Players':
          collectionName = 'SecondTeamClassPlayers';
          data = {
            'id': '10',
            'autobio': '',
            'best_moment': '',
            'email': '',
            'facebook': '',
            'image': 'https://firebasestorage.googleapis.com/v0/b/cov-phoenix-fc.appspot.com/o/Players%2FAI_GENERATED%2Fai_player_1.jpg?alt=media&token=585caeeb-2d2c-4dd9-a298-c802f9998356',
            'image_two': 'https://firebasestorage.googleapis.com/v0/b/cov-phoenix-fc.appspot.com/o/Players%2FAI_GENERATED%2Fai_player_2.jpg?alt=media&token=6f10032a-813e-476e-92ee-d34bb35bfff0',
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
            'image': 'https://firebasestorage.googleapis.com/v0/b/cov-phoenix-fc.appspot.com/o/Players%2FAI_GENERATED%2Fai_coach_1.jpg?alt=media&token=d5960c59-a7b7-4556-87e3-4095c638a056',
            'image_two': 'https://firebasestorage.googleapis.com/v0/b/cov-phoenix-fc.appspot.com/o/Players%2FAI_GENERATED%2Fai_coach_2.jpg?alt=media&token=487a3e8c-2692-4d3d-92a4-471a2a547920',
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
            'd_o_b': '',
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
            'image': 'https://firebasestorage.googleapis.com/v0/b/cov-phoenix-fc.appspot.com/o/Players%2FAI_GENERATED%2Fai_manager_2.jpg?alt=media&token=afc23732-5674-4008-9662-9b756b66e9f6',
            'image_two': 'https://firebasestorage.googleapis.com/v0/b/cov-phoenix-fc.appspot.com/o/Players%2FAI_GENERATED%2Fai_manager_1.jpg?alt=media&token=eb2ce227-a66b-4fa3-a642-f4742f3ad40e',
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
            'd_o_b': '',
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
              _selectedRole = 'Coventry Phoenix I Players';
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(147, 165, 193, 1.0), // Change this color to your desired background color
                ),
                child: const Text(
                  'Add Club Member',
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