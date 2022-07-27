import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/players_stats_and_info.dart';
import '../notifier/cum_motm_players_stats_info_notifier.dart';


getCumMOTMPlayersStatsAndInfo(CumMOTMPlayersStatsAndInfoNotifier cumMOTMPlayersStatsAndInfoNotifier) async {

  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('PlayersTable')
      .orderBy('man_of_the_match_cum', descending: true)
      .where('man_of_the_match_cum', isGreaterThan: 0)
      .limit(10)
      .get();

  List<PlayersStatsAndInfo> cumMOTMPlayersStatsAndInfoList = [];

  for (var document in snapshot.docs) {
    PlayersStatsAndInfo playersStatsAndInfo = PlayersStatsAndInfo.fromMap(document.data() as Map<String, dynamic>);
    cumMOTMPlayersStatsAndInfoList.add(playersStatsAndInfo);
  }

  cumMOTMPlayersStatsAndInfoNotifier.cumMOTMPlayersStatsAndInfoList = cumMOTMPlayersStatsAndInfoList;

}
