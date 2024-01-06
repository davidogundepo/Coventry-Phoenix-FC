import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../bloc_navigation_bloc/navigation_bloc.dart';
import '../../../notifier/players_table_notifier.dart';
import 'package:coventry_phoenix_fc/model/players_table.dart';

Color backgroundColor = const Color.fromRGBO(48, 50, 74, 1.0);

PlayersTableNotifier? playersTableNotifier;

class MyDisplayedMOTMHistoryPage extends StatefulWidget with NavigationStates {
  MyDisplayedMOTMHistoryPage({Key? key}) : super(key: key);

  @override
  State<MyDisplayedMOTMHistoryPage> createState() => MyDisplayedMOTMHistoryPageState();
}

class MyDisplayedMOTMHistoryPageState extends State<MyDisplayedMOTMHistoryPage> {
  @override
  Widget build(BuildContext context) {
    playersTableNotifier = Provider.of<PlayersTableNotifier>(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            // You can add logic here to show/hide the scrollbar based on scroll position
            return true;
          },
          child: Scrollbar(
            child: ListView.builder(
              itemCount: playersTableNotifier!.playersTableList.where((player) => player.manOfTheMatchCum! > 0).length,
              itemBuilder: (context, index) {
                final List<PlayersTable> filteredPlayers =
                    playersTableNotifier!.playersTableList.where((player) => player.manOfTheMatchCum! > 0).toList();

                // Sort the list based on playerOfTheMonthCum in descending order
                filteredPlayers.sort((a, b) => b.manOfTheMatchCum!.compareTo(a.manOfTheMatchCum!));

                final player = filteredPlayers[index];

                return InkWell(
                  splashColor: Colors.black54,
                  onTap: () async {
                    // Handle onTap logic if needed
                  },
                  child: ListTile(
                    title: Text(
                      '${player.playerName ?? 'No Name'} (${player.manOfTheMatchCum}X MOTM)',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
