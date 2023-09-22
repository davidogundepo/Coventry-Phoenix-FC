import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coventry_phoenix_fc/bloc_navigation_bloc/navigation_bloc.dart';
import '../../api/first_team_class_api.dart';
import '../../api/second_team_class_api.dart';
import '../../notifier/players_notifier.dart';
import '../../notifier/first_team_class_notifier.dart';
import '../../notifier/second_team_class_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyModifyClubPlayersPage extends StatefulWidget with NavigationStates {
  MyModifyClubPlayersPage({Key? key}) : super(key: key);

  @override
  State<MyModifyClubPlayersPage> createState() =>
      MyModifyClubPlayersPageState();
}

class MyModifyClubPlayersPageState extends State<MyModifyClubPlayersPage> {
  bool isEditing = false; // Flag to determine if the user is in "Edit" mode
  List<dynamic> selectedPlayers = []; // List to store selected players

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
                selectedPlayers.clear();
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
        child: ListView.builder(
          itemCount: playersNotifier.playersList.length,
          itemBuilder: (context, index) {
            final player = playersNotifier.playersList[index];
            return ListTile(
              title: Text(player.name ?? 'No Name'),
              trailing: isEditing
                  ? Checkbox(
                value: selectedPlayers.contains(player),
                onChanged: (value) {
                  setState(() {
                    if (value != null && value) {
                      selectedPlayers.add(player);
                    } else {
                      selectedPlayers.remove(player);
                    }
                  });
                },
              )
                  : null, // Show checkbox only in "Edit" mode
              // Add other player information you want to display
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
                children: selectedPlayers.map((player) {
                  return Chip(
                    label: Text(player.name ?? ''),
                    onDeleted: () {
                      setState(() {
                        selectedPlayers.remove(player);
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await deleteSelectedPlayers(selectedPlayers);
                // Clear selected players list after deletion
                setState(() {
                  selectedPlayers.clear();
                });
              },
              child: Text('Delete Selected'),
            ),
          ],
        ),
      )
          : null, // Show selected players at the bottom only in "Edit" mode
    );
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

    playersNotifier
        .setFirstTeamPlayers(firstTeamNotifier.firstTeamClassList);
    playersNotifier
        .setSecondTeamPlayers(secondTeamNotifier.secondTeamClassList);
  }

  Future<void> deleteSelectedPlayers(List<dynamic> selectedPlayers) async {
    final firestore = FirebaseFirestore.instance;

    // Iterate through the selected players and delete them
    for (final player in selectedPlayers) {
      // Assuming 'name' is a unique identifier
      final name = player.name;

      // Delete from both collections
      await deletePlayerByName(firestore, 'FirstTeamClassPlayers', name);
      await deletePlayerByName(firestore, 'SecondTeamClassPlayers', name);
    }

    // Show a Snackbar message indicating the players that have been removed
    showSnackbar(selectedPlayers);
  }

  Future<void> deletePlayerByName(
      FirebaseFirestore firestore, String collection, String name) async {
    final querySnapshot = await firestore
        .collection(collection)
        .where('name', isEqualTo: name)
        .get();

    for (final document in querySnapshot.docs) {
      await document.reference.delete();
    }
  }

  Future<void> refreshData() async {
    // Add logic here to refresh the data in the PlayersNotifier
    // You can re-fetch the data or update it as needed
    // After refreshing, call setState to trigger a UI update
    setState(() {});
  }

  void showSnackbar(List<dynamic> players) {
    final snackBar = SnackBar(
      content: Text('${players.length} players have been removed: ${players.map((player) => player.name).join(", ")}'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
