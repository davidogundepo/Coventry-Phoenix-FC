import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coventry_phoenix_fc/bloc_navigation_bloc/navigation_bloc.dart';
import '../../api/club_captains_api.dart';
import '../../model/captains.dart';
import '../../notifier/club_captains_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


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
      appBar: AppBar(
        title: Text('All Captains'),
        actions: [
          // Add a button to toggle "Edit" mode
          IconButton(
            icon: Icon(isEditing ? Icons.done : Icons.edit),
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
      body: ListView.builder(
        itemCount: clubCaptainsNotifier.captainsList.length,
        itemBuilder: (context, index) {
          final clubCaptains = clubCaptainsNotifier.captainsList[index];
          return ListTile(
            title: Text(clubCaptains.name ?? 'No Name'),
            trailing: isEditing
                ? Checkbox(
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
      bottomSheet: isEditing
          ? Container(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Text('Selected Captains:'),
            SizedBox(width: 8.0),
            Expanded(
              child: Wrap(
                children: selectedClubCaptains.map((clubCaptains) {
                  return Chip(
                    label: Text(clubCaptains.name ?? ''),
                    onDeleted: () {
                      setState(() {
                        selectedClubCaptains.remove(clubCaptains);
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await deleteSelectedClubCaptains(selectedClubCaptains);
                // Clear selected management list after deletion
                setState(() {
                  selectedClubCaptains.clear();
                });
              },
              child: Text('Delete Selected'),
            ),
          ],
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
        await firestore
            .collection('Captains')
            .where('name', isEqualTo: clubCaptainsName)
            .get()
            .then((querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            doc.reference.delete();
          });
        });

        // Remove the clubCaptains from the updated list
        updatedList.remove(clubCaptains);
      }
    }

    // Update the management list in the notifier
    clubCaptainsNotifier.captainsList = updatedList;
  }

  @override
  void initState() {
    CaptainsNotifier clubCaptainsNotifier =
    Provider.of<CaptainsNotifier>(context, listen: false);
    getCaptains(clubCaptainsNotifier);

    super.initState();
  }

}
