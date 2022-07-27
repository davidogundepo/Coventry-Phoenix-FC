import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/players_stats_and_info.dart';
import '../notifier/most_fouled_yc_players_stats_info_notifier.dart';


getMostFouledYCPlayersStatsAndInfo(MostFouledYCPlayersStatsAndInfoNotifier mostFouledYCPlayersStatsAndInfoNotifier) async {

  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('PlayersTable')
      .where('yellow_card', isGreaterThan: 0)
      .orderBy('yellow_card', descending: true)
      .limit(8)
      .get();

  List<PlayersStatsAndInfo> mostFouledYCPlayersStatsAndInfoList = [];



  for (var document in snapshot.docs) {
    PlayersStatsAndInfo playersStatsAndInfo = PlayersStatsAndInfo.fromMap(document.data() as Map<String, dynamic>);
    mostFouledYCPlayersStatsAndInfoList.add(playersStatsAndInfo);
  }

  mostFouledYCPlayersStatsAndInfoNotifier.mostFouledYCPlayersStatsAndInfoList = mostFouledYCPlayersStatsAndInfoList;

}
