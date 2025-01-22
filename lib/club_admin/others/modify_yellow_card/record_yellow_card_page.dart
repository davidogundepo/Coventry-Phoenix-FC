import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coventry_phoenix_fc/api/players_table_api.dart';
import 'package:coventry_phoenix_fc/model/players_table.dart';
import 'package:coventry_phoenix_fc/notifier/players_table_notifier.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '/bloc_navigation_bloc/navigation_bloc.dart';

Color backgroundColor = const Color.fromRGBO(129, 140, 148, 1.0);

class MyRecordYellowCardPage extends StatefulWidget with NavigationStates {
  MyRecordYellowCardPage({Key? key}) : super(key: key);

  @override
  State<MyRecordYellowCardPage> createState() => MyRecordYellowCardPageState();
}

class MyRecordYellowCardPageState extends State<MyRecordYellowCardPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    PlayersTableNotifier playersTableNotifier = Provider.of<PlayersTableNotifier>(context);

    List<PlayersTable> filteredPlayers = playersTableNotifier.playersTableList
        .where((player) => player.playerName!.toLowerCase().contains(searchController.text.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: false, // Set this property to false
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  // Trigger a rebuild with the updated search query
                });
              },
              style: const TextStyle(color: Colors.black), // Change text color here
              cursorColor: Colors.black, // Change cursor color here
              decoration: const InputDecoration(
                labelText: 'Search',
                labelStyle: TextStyle(color: Colors.black), // Change label color here
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.15),
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            // You can add logic here to show/hide the scrollbar based on scroll position
            return true;
          },
          child: Scrollbar(
            child: ListView.builder(
                itemCount: filteredPlayers.length,
                itemBuilder: (context, index) {
                  final player = filteredPlayers[index];
                  final playerName = player.playerName;
                  return InkWell(
                    splashColor: Colors.black54,
                    onTap: () async {
                      await showDialog<bool>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'Confirm MVP',
                              style: GoogleFonts.teko(fontWeight: FontWeight.w400),
                            ),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: const TextStyle(fontSize: 16.0, color: Colors.black),
                                      children: <TextSpan>[
                                        TextSpan(text: playerName, style: const TextStyle(fontWeight: FontWeight.w700)),
                                        const TextSpan(text: ' will be added to the list of yellow card holders!'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text(
                                  'No',
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                  // Set the flag to false when "No" is pressed
                                  // showSnackbarFlag = false;
                                  return;
                                },
                              ),
                              TextButton(
                                child: const Text(
                                  'Confirm',
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                                onPressed: () async {
                                  Navigator.of(context).pop(true);

                                  // Find the document with the specific player name and update potm_cum by 1
                                  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                                      .collection('PllayersTable')
                                      .where('player_name', isEqualTo: player.playerName)
                                      .get();

                                  if (querySnapshot.docs.isNotEmpty) {
                                    // Update the first document found (assuming player names are unique)
                                    DocumentReference documentReference = querySnapshot.docs[0].reference;

                                    // Increment potm_cum by 1
                                    documentReference.update({
                                      'yellow_card': FieldValue.increment(1),
                                    });

                                    // Show a toast notification
                                    Fluttertoast.showToast(
                                      msg: '${player.playerName} is holding  🟨',
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  }
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: ListTile(
                      title: Text(player.playerName ?? 'No Name'),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    PlayersTableNotifier playersTableNotifier = Provider.of<PlayersTableNotifier>(context, listen: false);
    getPlayersTable(playersTableNotifier);
  }
}
