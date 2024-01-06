import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../../../api/c_match_day_banner_for_league_api.dart';
import '../../../bloc_navigation_bloc/navigation_bloc.dart';
import '../../../model/c_match_day_banner_for_league.dart';
import '../../../notifier/c_match_day_banner_for_league_notifier.dart';

late MatchDayBannerForLeagueNotifier matchDayBannerForLeagueNotifier;

class MyRemoveNewLeaguePage extends StatefulWidget with NavigationStates {
  MyRemoveNewLeaguePage({super.key});

  @override
  State<MyRemoveNewLeaguePage> createState() => MyRemoveNewLeaguePageState();
}

class MyRemoveNewLeaguePageState extends State<MyRemoveNewLeaguePage> {
  bool isEditing = false; // Flag to determine if the user is in "Edit" mode
  List<MatchDayBannerForLeague> selectedLeagues = []; // List to store selected leagues

  @override
  Widget build(BuildContext context) {
    matchDayBannerForLeagueNotifier = Provider.of<MatchDayBannerForLeagueNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.accessibility, color: Colors.black38),
          onPressed: () {},
        ),
        title: const Text('Remove Leagues'),
        actions: [
          // Add a button to toggle "Edit" mode
          IconButton(
            icon: Icon(
              isEditing ? Icons.done : Icons.edit,
              color: Colors.black,
            ),
            onPressed: () {
              // Toggle "Edit" mode and clear selected leagues list
              setState(() {
                isEditing = !isEditing;
                selectedLeagues.clear();
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
                itemCount: matchDayBannerForLeagueNotifier.matchDayBannerForLeagueList.length, // Replace with your actual list of leagues
                itemBuilder: (context, index) {
                  final leagueName = matchDayBannerForLeagueNotifier.matchDayBannerForLeagueList[index]; // Replace with your actual data structure
                  return ListTile(
                    title: Text(leagueName.league!),
                    trailing: isEditing
                        ? Checkbox(
                      activeColor:const Color.fromRGBO(147, 165, 193, 1.0),
                      checkColor: Colors.white,
                      value: selectedLeagues.contains(leagueName),
                      onChanged: (value) {
                        setState(() {
                          if (value != null && value) {
                            selectedLeagues.add(leagueName);
                          } else {
                            selectedLeagues.remove(leagueName);
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
              //   'Selected\nHome Teams:',
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
                    children: selectedLeagues.map((leagues) {
                      return Chip(
                        label: Text(leagues.league ?? '',
                          style: const TextStyle(
                              fontSize: 12
                          ),),
                        onDeleted: () {
                          setState(() {
                            selectedLeagues.remove(leagues);
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
                  // Implement logic to delete selected leagues
                  await deleteSelectedLeagues(selectedLeagues);
                  // Clear selected leagues list after deletion
                  setState(() {
                    selectedLeagues.clear();
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
          : null, // Show selected leagues at the bottom only in "Edit" mode
    );
  }

  // Implement your logic to delete selected leagues
  Future<void> deleteSelectedLeagues(List<MatchDayBannerForLeague> selectedLeagues) async {
    final firestore = FirebaseFirestore.instance;

    // Create a list to hold updated leagues after deletion
    final updatedList = List<MatchDayBannerForLeague>.from(matchDayBannerForLeagueNotifier.matchDayBannerForLeagueList);

    // Iterate through the selected leagues and delete them
    for (final leagues in selectedLeagues) {
      final leaguesName = leagues.league; // Get the name of the league
      if (leaguesName != null) {
        // Delete leagues with matching names
        await firestore.collection('MatchDayBannerForLeague').where('league', isEqualTo: leaguesName).get().then((querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            doc.reference.delete();
          });
        });

        // Remove the league from the updated list
        updatedList.remove(leagues);
      }
    }

    // Update the leagues list in the notifier
    matchDayBannerForLeagueNotifier.matchDayBannerForLeagueList = updatedList;
  }

  @override
  void initState() {
    MatchDayBannerForLeagueNotifier matchDayBannerForLeagueNotifier = Provider.of<MatchDayBannerForLeagueNotifier>(context, listen: false);
    getMatchDayBannerForLeague(matchDayBannerForLeagueNotifier);

    super.initState();
  }
}
