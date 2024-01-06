import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coventry_phoenix_fc/api/club_sponsors_api.dart';
import 'package:coventry_phoenix_fc/model/club_sponsors.dart';
import 'package:coventry_phoenix_fc/notifier/club_sponsors_notifier.dart';
import 'package:flutter/material.dart';
import '../../bloc_navigation_bloc/navigation_bloc.dart';
import 'package:provider/provider.dart';

Color backgroundColor = const Color.fromRGBO(235, 238, 239, 1.0);
Color appBackgroundColor = const Color.fromRGBO(147, 165, 193, 1.0);

late ClubSponsorsNotifier clubSponsorsNotifier;

class MyRemoveClubSponsorPage extends StatefulWidget with NavigationStates {
  MyRemoveClubSponsorPage({Key? key}) : super(key: key);

  @override
  State<MyRemoveClubSponsorPage> createState() => MyRemoveClubSponsorPageState();
}

class MyRemoveClubSponsorPageState extends State<MyRemoveClubSponsorPage> {
  bool isEditing = false; // Flag to determine if user is in "Edit" mode
  List<ClubSponsors> selectedClubSponsors = []; // List to store selected management

  @override
  Widget build(BuildContext context) {
    clubSponsorsNotifier = Provider.of<ClubSponsorsNotifier>(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.share_location_outlined, color: Colors.black38),
          onPressed: () {},
        ),
        title: const Text('All Sponsors'),
        actions: [
          IconButton(
            icon: Icon(
              isEditing ? Icons.done : Icons.edit,
              color: Colors.black,
            ),
            onPressed: () {
              // Toggle "Edit" mode and clear selected management list
              setState(() {
                isEditing = !isEditing;
                selectedClubSponsors.clear();
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
                itemCount: clubSponsorsNotifier.clubSponsorsList.length,
                itemBuilder: (context, index) {
                  final clubSponsor = clubSponsorsNotifier.clubSponsorsList[index];
                  return ListTile(
                    title: Text(clubSponsor.name ?? 'No Name'),
                    trailing: isEditing
                        ? Checkbox(
                            activeColor: Colors.black87,
                            checkColor: Colors.white,
                            value: selectedClubSponsors.contains(clubSponsor),
                            onChanged: (value) {
                              setState(() {
                                if (value != null && value) {
                                  selectedClubSponsors.add(clubSponsor);
                                } else {
                                  selectedClubSponsors.remove(clubSponsor);
                                }
                              });
                            },
                          )
                        : null, // Show checkbox only in "Edit" mode
                    // Add other clubSponsor information you want to display
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
                color: appBackgroundColor,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.27,
                ),
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    // const Text('Selected Sponsors:'),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal, // Set the scroll direction to horizontal
                        child: Wrap(
                          children: selectedClubSponsors.map((clubSponsor) {
                            return Chip(
                              label: Text(
                                clubSponsor.name ?? '',
                                style: const TextStyle(fontSize: 12),
                              ),
                              onDeleted: () {
                                setState(() {
                                  selectedClubSponsors.remove(clubSponsor);
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
                        await deleteSelectedClubSponsors(selectedClubSponsors);
                        // Clear selected management list after deletion
                        setState(() {
                          selectedClubSponsors.clear();
                        });
                      },
                      child: const Text('Delete Selected', style: TextStyle(color: Colors.redAccent)),
                    ),
                  ],
                ),
              ),
            )
          : null, // Show selected management at the bottom only in "Edit" mode
    );
  }

  Future<void> deleteSelectedClubSponsors(List<ClubSponsors> selectedClubSponsors) async {
    final firestore = FirebaseFirestore.instance;

    // Create a list to hold updated management after deletion
    final updatedList = List<ClubSponsors>.from(clubSponsorsNotifier.clubSponsorsList);

    // Iterate through the selected management and delete them
    for (final clubSponsor in selectedClubSponsors) {
      final clubSponsorsName = clubSponsor.name; // Get the name of the clubSponsor
      if (clubSponsorsName != null) {
        // Delete management with matching names
        await firestore.collection('ClubSponsors').where('name', isEqualTo: clubSponsorsName).get().then((querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            doc.reference.delete();
          });
        });

        // Remove the clubSponsor from the updated list
        updatedList.remove(clubSponsor);
      }
    }

    // Update the management list in the notifier
    clubSponsorsNotifier.clubSponsorsList = updatedList;
  }

  @override
  void initState() {
    ClubSponsorsNotifier clubSponsorsNotifier = Provider.of<ClubSponsorsNotifier>(context, listen: false);
    getClubSponsors(clubSponsorsNotifier);

    super.initState();
  }
}
