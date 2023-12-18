import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coventry_phoenix_fc/bloc_navigation_bloc/navigation_bloc.dart';
import '../../api/club_captains_api.dart';
import '../../model/captains.dart';
import '../../notifier/club_captains_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
Color backgroundColor = const Color.fromRGBO(20, 36, 62, 1.0);

late CaptainsNotifier clubCaptainsNotifier;

class MyModifyRemoveClubCaptainsPage extends StatefulWidget with NavigationStates {
  MyModifyRemoveClubCaptainsPage({Key? key}) : super(key: key);

  @override
  State<MyModifyRemoveClubCaptainsPage> createState() => MyModifyRemoveClubCaptainsPageState();
}

class MyModifyRemoveClubCaptainsPageState extends State<MyModifyRemoveClubCaptainsPage> {
  bool isEditing = false; // Flag to determine if user is in "Edit" mode
  List<Captains> selectedClubCaptains = []; // List to store selected management

  @override
  Widget build(BuildContext context) {
    clubCaptainsNotifier = Provider.of<CaptainsNotifier>(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.accessibility, color: Colors.white38),
          onPressed: () {},
        ),
        title: const Text(
          'All Captains',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          // Add a button to toggle "Edit" mode
          IconButton(
            icon: Icon(
              isEditing ? Icons.done : Icons.edit,
              color: Colors.white,
            ),
            onPressed: () {
              // Toggle "Edit" mode and clear selected management list
              setState(() {
                isEditing = !isEditing;
                selectedClubCaptains.clear();
              });
            },
          ),
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // Hide the keyboard when tapping outside the text field
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.25),
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              // You can add logic here to show/hide the scrollbar based on scroll position
              return true;
            },
            child: Scrollbar(
              child: ListView.builder(
                itemCount: clubCaptainsNotifier.captainsList.length,
                itemBuilder: (context, index) {
                  final clubCaptains = clubCaptainsNotifier.captainsList[index];
                  return ListTile(
                    title: Text(
                      '${clubCaptains.name!} (${clubCaptains.teamCaptaining!})' ?? 'No Name',
                      style: const TextStyle(color: Colors.white),
                    ),
                    trailing: isEditing
                        ? Checkbox(
                            activeColor: Colors.white,
                            checkColor: backgroundColor,
                            value: selectedClubCaptains.contains(clubCaptains),
                            onChanged: (value) {
                              setState(() {
                                if (value != null && value) {
                                  selectedClubCaptains.add(clubCaptains);
                                } else {
                                  selectedClubCaptains.remove(clubCaptains);
                                }
                              });
                            },
                          )
                        : null, // Show checkbox only in "Edit" mode
                    // Add other clubCaptains information you want to display
                  );
                },
              ),
            ),
          ),
        ),
      ),
      bottomSheet: isEditing
          ? SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                color: twitterColor,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.27,
                ),
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    // const Text(
                    //   'Selected\nCaptains:',
                    //   style: TextStyle(color: Colors.black),
                    // ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal, // Set the scroll direction to horizontal
                        child: Wrap(
                          children: selectedClubCaptains.map((clubCaptains) {
                            return Chip(
                              label: Text(clubCaptains.name ?? '',
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.redAccent
                                ),
                              ),
                              onDeleted: () {
                                setState(() {
                                  selectedClubCaptains.remove(clubCaptains);
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    ElevatedButton(
                      onPressed: () async {
                        await deleteSelectedClubCaptains(selectedClubCaptains);
                        // Clear selected management list after deletion
                        setState(() {
                          selectedClubCaptains.clear();
                        });
                      },
                      child: const Text(
                        'Delete Selected',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null, // Show selected management at the bottom only in "Edit" mode
    );
  }

  Future<void> deleteSelectedClubCaptains(List<Captains> selectedClubCaptains) async {
    final firestore = FirebaseFirestore.instance;

    // Create a list to hold updated management after deletion
    final updatedList = List<Captains>.from(clubCaptainsNotifier.captainsList);

    // Iterate through the selected management and delete them
    for (final clubCaptains in selectedClubCaptains) {
      final clubCaptainsName = clubCaptains.name; // Get the name of the clubCaptains
      if (clubCaptainsName != null) {
        // Delete management with matching names
        await firestore.collection('Captains').where('name', isEqualTo: clubCaptainsName).get().then((querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            doc.reference.delete();
          });
        });

        // Remove the clubCaptains from the updated list
        updatedList.remove(clubCaptains);
      }
    }

    // Update the captains list in the notifier
    clubCaptainsNotifier.captainsList = updatedList;
  }

  @override
  void initState() {
    CaptainsNotifier clubCaptainsNotifier = Provider.of<CaptainsNotifier>(context, listen: false);
    getCaptains(clubCaptainsNotifier);

    super.initState();
  }
}
