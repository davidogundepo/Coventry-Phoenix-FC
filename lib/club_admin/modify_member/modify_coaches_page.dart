import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coventry_phoenix_fc/bloc_navigation_bloc/navigation_bloc.dart';
import '../../api/coaching_staff_api.dart';
import '../../model/coaches.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../notifier/coaching_staff_notifier.dart';

Color backgroundColor = const Color.fromRGBO(187, 192, 195, 1.0);

late CoachesNotifier coachesNotifier;

class MyModifyCoachesPage extends StatefulWidget with NavigationStates {
  MyModifyCoachesPage({Key? key}) : super(key: key);

  @override
  State<MyModifyCoachesPage> createState() => MyModifyCoachesPageState();
}

class MyModifyCoachesPageState extends State<MyModifyCoachesPage> {
  bool isEditing = false; // Flag to determine if user is in "Edit" mode
  List<Coaches> selectedCoaches = []; // List to store selected coaches

  @override
  Widget build(BuildContext context) {
    coachesNotifier = Provider.of<CoachesNotifier>(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text('All Coaches'),
        actions: [
          // Add a button to toggle "Edit" mode
          IconButton(
            icon: Icon(isEditing ? Icons.done : Icons.edit),
            onPressed: () {
              // Toggle "Edit" mode and clear selected coaches list
              setState(() {
                isEditing = !isEditing;
                selectedCoaches.clear();
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: coachesNotifier.coachesList.length,
        itemBuilder: (context, index) {
          final coach = coachesNotifier.coachesList[index];
          return ListTile(
            title: Text(coach.name ?? 'No Name'),
            trailing: isEditing
                ? Checkbox(
                    value: selectedCoaches.contains(coach),
                    onChanged: (value) {
                      setState(() {
                        if (value != null && value) {
                          selectedCoaches.add(coach);
                        } else {
                          selectedCoaches.remove(coach);
                        }
                      });
                    },
                  )
                : null, // Show checkbox only in "Edit" mode
            // Add other coach information you want to display
          );
        },
      ),
      bottomSheet: isEditing
          ? SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.27,
                ),
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Text('Selected Coaches:'),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Wrap(
                        children: selectedCoaches.map((coach) {
                          return Chip(
                            label: Text(coach.name ?? ''),
                            onDeleted: () {
                              setState(() {
                                selectedCoaches.remove(coach);
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await deleteSelectedCoaches(selectedCoaches);
                        // Clear selected coaches list after deletion
                        setState(() {
                          selectedCoaches.clear();
                        });
                      },
                      child: const Text('Delete Selected'),
                    ),
                  ],
                ),
              ),
            )
          : null, // Show selected coaches at the bottom only in "Edit" mode
    );
  }

  Future<void> deleteSelectedCoaches(List<Coaches> selectedCoaches) async {
    final firestore = FirebaseFirestore.instance;

    // Create a list to hold updated coaches after deletion
    final updatedList = List<Coaches>.from(coachesNotifier.coachesList);

    // Iterate through the selected coaches and delete them
    for (final coach in selectedCoaches) {
      final coachName = coach.name; // Get the name of the coach
      if (coachName != null) {
        // Delete coaches with matching names
        await firestore.collection('Coaches').where('name', isEqualTo: coachName).get().then((querySnapshot) {
          for (var doc in querySnapshot.docs) {
            doc.reference.delete();
          }
        });

        // Remove the coach from the updated list
        updatedList.remove(coach);
      }
    }

    // Update the coaches list in the notifier
    coachesNotifier.coachesList = updatedList;
  }

  @override
  void initState() {
    CoachesNotifier coachesNotifier = Provider.of<CoachesNotifier>(context, listen: false);
    getCoaches(coachesNotifier);

    super.initState();
  }
}
