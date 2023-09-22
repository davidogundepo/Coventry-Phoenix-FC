import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coventry_phoenix_fc/bloc_navigation_bloc/navigation_bloc.dart';
import '../../api/first_team_class_api.dart';
import '../../api/second_team_class_api.dart';
import '../../notifier/players_notifier.dart'; // Replace with your notifier
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../notifier/first_team_class_notifier.dart';
import '../../notifier/second_team_class_notifier.dart';

class MyModifyAddClubCaptainsPage extends StatefulWidget with NavigationStates {
  MyModifyAddClubCaptainsPage({Key? key}) : super(key: key);

  @override
  State<MyModifyAddClubCaptainsPage> createState() =>
      MyModifyAddClubCaptainsPageState();
}

class MyModifyAddClubCaptainsPageState
    extends State<MyModifyAddClubCaptainsPage> {
  bool isTeamSelected = false;
  bool isEditing = false; // Flag to determine if the user is in "Edit" mode
  List<String> selectedPlayerNames = []; // List to store selected player names
  Map<String, String> playerTeams = {}; // Map to store player-team mapping
  String selectedTeam = ''; // Variable to store the selected team

  @override
  Widget build(BuildContext context) {
    // Use the PlayersNotifier to access the combined list of players
    PlayersNotifier playersNotifier =
    Provider.of<PlayersNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('All Players'),
        actions: [
          // Add a button to toggle "Edit" mode
          IconButton(
            icon: Icon(isEditing ? Icons.done : Icons.edit),
            onPressed: () {
              // Toggle "Edit" mode and clear selected players list
              setState(() {
                isEditing = !isEditing;
                selectedPlayerNames.clear();
              });
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Refresh the data when the user pulls down the list
          await refreshData();
        },
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Captains').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            // Create a map to store player-team mappings based on Firestore data
            Map<String, String> playerCaptains = {};

            for (var doc in snapshot.data!.docs) {
              final playerName = doc['name'] as String?;
              final teamCaptaining = doc['team_captaining'] as String?;
              if (playerName != null && teamCaptaining != null) {
                playerCaptains[playerName] = teamCaptaining;
              }
            }

            // Update the playerTeams map with the Firestore data
            playerTeams = playerCaptains;

            return ListView.builder(
              itemCount: playersNotifier.playersList.length,
              itemBuilder: (context, index) {
                final player = playersNotifier.playersList[index];
                final playerName = player.name ?? 'No Name';
                final playerImage = player.image ?? 'No Image';
                final isCaptain = playerTeams.containsKey(playerName);
                final isSelected = selectedPlayerNames.contains(playerName);
                final teamForPlayer = playerTeams[playerName];

                return ListTile(
                  title: Text(
                    '$playerName ${teamForPlayer != null ? '($teamForPlayer)' : ''}',
                  ),
                  trailing: isEditing
                      ? Checkbox(
                    value: isSelected, // Check by player name
                    onChanged: (value) {
                      setState(() {
                        if (value != null) {
                          if (value && !isSelected) {
                            // Player is selected, and not already in the list
                            selectedPlayerNames.add(playerName);
                          } else if (!value && isSelected) {
                            // Player is unselected, and in the list
                            selectedPlayerNames.remove(playerName);
                          }
                        }
                      });
                    },
                  )
                      : null,
                );
              },
            );
          },
        ),
      ),
      bottomSheet: isEditing
          ? Container(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Text('Selected Players:'),
            SizedBox(width: 8.0),
            Expanded(
              child: Wrap(
                children: selectedPlayerNames.map((playerName) {
                  return Chip(
                    label: Text(playerName),
                    onDeleted: () {
                      setState(() {
                        selectedPlayerNames.remove(playerName);
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            ElevatedButton(
              onPressed: isTeamSelected
                  ? () async {
                await addPlayersAsCaptains(selectedPlayerNames);
                // Clear selected players list after addition
                setState(() {
                  selectedPlayerNames.clear();
                });
              }
                  : () {
                // Show a toast if no team is selected
                Fluttertoast.showToast(
                  msg: 'Select Team first',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                );
              },
              child: Text('Add as Captains'),
            ),

          ],
        ),
      )
          : null, // Show selected players at the bottom only in "Edit" mode
      floatingActionButton: isEditing
          ? FloatingActionButton(
        onPressed: () {
          _showTeamSelectionDialog();
        },
        child: Icon(Icons.sports_soccer),
      )
          : null,
    );
  }

  Future<void> _showTeamSelectionDialog() async {
    final teamSelected = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select a Team'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('First Team'),
                onTap: () {
                  Navigator.of(context).pop('First Team');
                  setState(() {
                    isTeamSelected = true;
                  });
                  Fluttertoast.showToast(
                    msg: 'First Team selected',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                },
              ),
              ListTile(
                title: Text('Reserve Team'),
                onTap: () {
                  Navigator.of(context).pop('Reserve Team');
                  setState(() {
                    isTeamSelected = true;
                  });
                  Fluttertoast.showToast(
                    msg: 'Reserve Team selected',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                },
              ),
              ListTile(
                title: Text('Third Team'),
                onTap: () {
                  Navigator.of(context).pop('Third Team');
                  setState(() {
                    isTeamSelected = true;
                  });
                  Fluttertoast.showToast(
                    msg: 'Third Team selected',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                },
              ),
            ],
          ),
        );
      },
    );

    if (teamSelected != null) {
      // Update the selected team and rebuild the widget
      setState(() {
        selectedTeam = teamSelected;
      });
    } else {
      // Show a toast if no team is selected
      Fluttertoast.showToast(
        msg: 'Select a Team first',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  @override
  void initState() {
    super.initState();

    // Fetch data for the first and second teams using their notifiers
    FirstTeamClassNotifier firstTeamNotifier =
    Provider.of<FirstTeamClassNotifier>(context, listen: false);
    getFirstTeamClass(firstTeamNotifier);

    SecondTeamClassNotifier secondTeamNotifier =
    Provider.of<SecondTeamClassNotifier>(context, listen: false);
    getSecondTeamClass(secondTeamNotifier);

    // Populate the PlayersNotifier with data from both teams
    PlayersNotifier playersNotifier =
    Provider.of<PlayersNotifier>(context, listen: false);

    playersNotifier.setFirstTeamPlayers(firstTeamNotifier.firstTeamClassList);
    playersNotifier.setSecondTeamPlayers(secondTeamNotifier.secondTeamClassList);
  }

  Future<void> addPlayersAsCaptains(List<String> selectedPlayerNames) async {
    final firestore = FirebaseFirestore.instance;

    // Get the current players in the 'Captains' collection
    final captainsCollection = await firestore.collection('Captains').get();
    final existingCaptains = captainsCollection.docs
        .map((doc) => doc['name'] as String)
        .toSet();

    // Access the PlayersNotifier to retrieve player data
    PlayersNotifier playersNotifier =
    Provider.of<PlayersNotifier>(context, listen: false);

    // Iterate through the selected players and add them as captains if they don't already exist
    for (final playerName in selectedPlayerNames) {
      if (!existingCaptains.contains(playerName)) {
        final player = playersNotifier.playersList
            .firstWhere((player) => player.name == playerName,
            orElse: () => null);

        if (player != null) {
          final imageUrl = player.image ?? ''; // Get the image URL
          final imageTwoUrl = player.imageTwo ?? ''; // Get the imageTwo URL

          // Add player as captain to the 'Captains' collection with the image URLs
          await firestore.collection('Captains').add({
            'name': playerName,
            'team_captaining':
            selectedTeam.isNotEmpty ? selectedTeam : 'YourTeamHere',
            'image': imageUrl, // Use the retrieved image URL
            'image_two': imageTwoUrl, // Use the retrieved imageTwo URL
            'id': '10',
          });

          // Update the playerTeams map with the new captain
          playerTeams[playerName] =
          selectedTeam.isNotEmpty ? selectedTeam : 'YourTeamHere';
        }
      }
    }

    // Show a Snackbar message indicating the players that have been added as captains
    showSnackbar(selectedPlayerNames);
  }

  Future<void> refreshData() async {
    // Add logic here to refresh the data in the PlayersNotifier
    // You can re-fetch the data or update it as needed
    // After refreshing, call setState to trigger a UI update
    setState(() {});
  }

  void showSnackbar(List<String> playerNames) {
    final snackBar = SnackBar(
      content: Text(
          '${playerNames.length} players have been added as captains: ${playerNames.join(", ")}'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
