import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coventry_phoenix_fc/api/c_match_day_banner_for_club_opp_api.dart';
import 'package:coventry_phoenix_fc/notifier/c_match_day_banner_for_club_opp_notifier.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../../bloc_navigation_bloc/navigation_bloc.dart';
import '../../../model/c_match_day_banner_for_club.dart';
import '../../../model/c_match_day_banner_for_club_opp.dart';

late MatchDayBannerForClubOppNotifier matchDayBannerForClubOppNotifier;

class MyRemoveNewOppTeamPage extends StatefulWidget with NavigationStates {
  MyRemoveNewOppTeamPage({super.key});

  @override
  State<MyRemoveNewOppTeamPage> createState() => MyRemoveNewOppTeamPageState();
}

class MyRemoveNewOppTeamPageState extends State<MyRemoveNewOppTeamPage> {
  bool isEditing = false; // Flag to determine if user is in "Edit" mode
  List<MatchDayBannerForClubOpp> selectedAwayTeams = []; // List to store selected away teams

  @override
  Widget build(BuildContext context) {
    matchDayBannerForClubOppNotifier = Provider.of<MatchDayBannerForClubOppNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.accessibility, color: Colors.black38),
          onPressed: () {},
        ),
        title: const Text('Remove Away Teams'),
        actions: [
          // Add a button to toggle "Edit" mode
          IconButton(
            icon: Icon(
              isEditing ? Icons.done : Icons.edit,
              color: Colors.black,
            ),
            onPressed: () {
              // Toggle "Edit" mode and clear selected away teams list
              setState(() {
                isEditing = !isEditing;
                selectedAwayTeams.clear();
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
                itemCount: matchDayBannerForClubOppNotifier.matchDayBannerForClubOppList.length, // Replace with your actual list of away teams
                itemBuilder: (context, index) {
                  final awayTeamName = matchDayBannerForClubOppNotifier.matchDayBannerForClubOppList[index]; // Replace with your actual data structure
                  return ListTile(
                    title: Text(awayTeamName.clubName!),
                    trailing: isEditing
                        ? Checkbox(
                      activeColor:const Color.fromRGBO(147, 165, 193, 1.0),
                      checkColor: Colors.white,
                      value: selectedAwayTeams.contains(awayTeamName),
                      onChanged: (value) {
                        setState(() {
                          if (value != null && value) {
                            selectedAwayTeams.add(awayTeamName);
                          } else {
                            selectedAwayTeams.remove(awayTeamName);
                          }
                        });
                      },
                    )
                        : null, // Show checkbox only in "Edit" mode
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
          color: const Color.fromRGBO(147, 165, 193, 1.0),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.27,
          ),
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // const Text(
              //   'Selected\nAway Teams:',
              //   style: TextStyle(
              //       fontSize: 13,
              //     fontWeight: FontWeight.w600
              //   ),
              // ),
              const SizedBox(width: 8.0),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal, // Set the scroll direction to horizontal
                  child: Wrap(
                    children: selectedAwayTeams.map((awayTeams) {
                      return Chip(
                        label: Text(awayTeams.clubName ?? '',
                          style: const TextStyle(
                              fontSize: 12
                          ),),
                        onDeleted: () {
                          setState(() {
                            selectedAwayTeams.remove(awayTeams);
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
                  // Implement logic to delete selected away teams
                  await deleteSelectedAwayTeams(selectedAwayTeams);
                  // Clear selected away teams list after deletion
                  setState(() {
                    selectedAwayTeams.clear();
                  });
                },
                child: const Text(
                  'Delete Selected',
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
            ],
          ),
        ),
      )
          : null, // Show selected away teams at the bottom only in "Edit" mode
    );
  }

  // Implement your logic to delete selected away teams
  Future<void> deleteSelectedAwayTeams(List<MatchDayBannerForClubOpp> selectedAwayTeams) async {
    final firestore = FirebaseFirestore.instance;

    // Create a list to hold updated management after deletion
    final updatedList = List<MatchDayBannerForClubOpp>.from(matchDayBannerForClubOppNotifier.matchDayBannerForClubOppList);

    // Iterate through the selected management and delete them
    for (final awayTeams in selectedAwayTeams) {
      final awayTeamsName = awayTeams.clubName; // Get the name of the clubCaptains
      if (awayTeamsName != null) {
        // Delete management with matching names
        await firestore.collection('MatchDayBannerForClubOpp').where('club_name', isEqualTo: awayTeamsName).get().then((querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            doc.reference.delete();
          });
        });

        // Remove the clubCaptains from the updated list
        updatedList.remove(awayTeams);
      }
    }

    // Update the away teams list in the notifier
    matchDayBannerForClubOppNotifier.matchDayBannerForClubOppList = updatedList;
  }

  @override
  void initState() {
    MatchDayBannerForClubOppNotifier matchDayBannerForClubOppNotifier = Provider.of<MatchDayBannerForClubOppNotifier>(context, listen: false);
    getMatchDayBannerForClubOpp(matchDayBannerForClubOppNotifier);

    super.initState();
  }
}
