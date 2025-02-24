import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coventry_phoenix_fc/bloc_navigation_bloc/navigation_bloc.dart';
import '../../api/management_body_api.dart';
import '../../model/management_body.dart';
import '../../notifier/management_body_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Color backgroundColor = const Color.fromRGBO(187, 192, 195, 1.0);

late ManagementBodyNotifier managementBodyNotifier;

class MyModifyManagementBodyPage extends StatefulWidget with NavigationStates {
  MyModifyManagementBodyPage({Key? key}) : super(key: key);

  @override
  State<MyModifyManagementBodyPage> createState() => MyModifyManagementBodyPageState();
}

class MyModifyManagementBodyPageState extends State<MyModifyManagementBodyPage> {
  bool isEditing = false; // Flag to determine if user is in "Edit" mode
  List<ManagementBody> selectedManagementBody = []; // List to store selected management

  @override
  Widget build(BuildContext context) {
    managementBodyNotifier = Provider.of<ManagementBodyNotifier>(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text('All Club Managers'),
        actions: [
          // Add a button to toggle "Edit" mode
          IconButton(
            icon: Icon(isEditing ? Icons.done : Icons.edit),
            onPressed: () {
              // Toggle "Edit" mode and clear selected management list
              setState(() {
                isEditing = !isEditing;
                selectedManagementBody.clear();
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
                itemCount: managementBodyNotifier.managementBodyList.length,
                itemBuilder: (context, index) {
                  final managementBody = managementBodyNotifier.managementBodyList[index];
                  return ListTile(
                    title: Text(managementBody.name ?? 'No Name'),
                    trailing: isEditing
                        ? Checkbox(
                      activeColor: Colors.white,
                      checkColor: Colors.black,
                            value: selectedManagementBody.contains(managementBody),
                            onChanged: (value) {
                              setState(() {
                                if (value != null && value) {
                                  selectedManagementBody.add(managementBody);
                                } else {
                                  selectedManagementBody.remove(managementBody);
                                }
                              });
                            },
                          )
                        : null, // Show checkbox only in "Edit" mode
                    // Add other managementBody information you want to display
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
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.27,
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // const Text('Selected\nManagement:'),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal, // Set the scroll direction to horizontal
                          child: Wrap(
                            children: selectedManagementBody.map((managementBody) {
                              return Chip(
                                label: Text(
                                  managementBody.name ?? '',
                                  style: const TextStyle(fontSize: 12),
                                ),
                                onDeleted: () {
                                  setState(() {
                                    selectedManagementBody.remove(managementBody);
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
                          await deleteSelectedManagementBody(selectedManagementBody);
                          // Clear selected management list after deletion
                          setState(() {
                            selectedManagementBody.clear();
                          });
                        },
                        child: const Text(
                          'Delete Selected',
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          : null, // Show selected management at the bottom only in "Edit" mode
    );
  }

  Future<void> deleteSelectedManagementBody(List<ManagementBody> selectedManagementBody) async {
    final firestore = FirebaseFirestore.instance;

    // Create a list to hold updated management after deletion
    final updatedList = List<ManagementBody>.from(managementBodyNotifier.managementBodyList);

    // Iterate through the selected management and delete them
    for (final managementBody in selectedManagementBody) {
      final managementBodyName = managementBody.name; // Get the name of the managementBody
      if (managementBodyName != null) {
        // Delete management with matching names
        await firestore.collection('ManagementBody').where('name', isEqualTo: managementBodyName).get().then((querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            doc.reference.delete();
          });
        });

        // Remove the managementBody from the updated list
        updatedList.remove(managementBody);
      }
    }

    // Update the management list in the notifier
    managementBodyNotifier.managementBodyList = updatedList;
  }

  @override
  void initState() {
    ManagementBodyNotifier managementBodyNotifier = Provider.of<ManagementBodyNotifier>(context, listen: false);
    getManagementBody(managementBodyNotifier);

    super.initState();
  }
}
