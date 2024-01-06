import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/players_table.dart';
import '../notifier/players_table_notifier.dart';

getPlayersTable(PlayersTableNotifier playersTableNotifier) async {
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('PllayersTable').orderBy('player_name').get();

  List<PlayersTable> playersTableList = [];

  for (var document in snapshot.docs) {
    PlayersTable playersTable =
        PlayersTable.fromMap(document.data() as Map<String, dynamic>);
    playersTableList.add(playersTable);
  }

  playersTableNotifier.playersTableList = playersTableList;
}
