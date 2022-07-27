import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/players_stats_and_info.dart';
import '../notifier/most_fouled_rc_players_stats_info_notifier.dart';


getMostFouledRCPlayersStatsAndInfo(MostFouledRCPlayersStatsAndInfoNotifier mostFouledRCPlayersStatsAndInfoNotifier) async {

  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('PlayersTable')
      .where('red_card', isGreaterThan: 0)
      .orderBy('red_card', descending: true)
      .limit(8)
      .get();

  List<PlayersStatsAndInfo> mostFouledRCPlayersStatsAndInfoList = [];

  for (var document in snapshot.docs) {
    PlayersStatsAndInfo playersStatsAndInfo = PlayersStatsAndInfo.fromMap(document.data() as Map<String, dynamic>);
    mostFouledRCPlayersStatsAndInfoList.add(playersStatsAndInfo);
  }

  mostFouledRCPlayersStatsAndInfoNotifier.mostFouledRCPlayersStatsAndInfoList = mostFouledRCPlayersStatsAndInfoList;

}
