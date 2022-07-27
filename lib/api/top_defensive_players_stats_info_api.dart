import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/players_stats_and_info.dart';
import '../notifier/top_defensive_players_stats_info_notifier.dart';


getTopDefensivePlayersStatsAndInfo(TopDefensivePlayersStatsAndInfoNotifier topDefensivePlayersStatsAndInfoNotifier) async {

  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('PlayersTable')
      .orderBy('goals_conceded_gk_def')
      .limit(10)
      .get();

  List<PlayersStatsAndInfo> topDefensivePlayersStatsAndInfoList = [];

  for (var document in snapshot.docs) {
    PlayersStatsAndInfo playersStatsAndInfo = PlayersStatsAndInfo.fromMap(document.data() as Map<String, dynamic>);
    topDefensivePlayersStatsAndInfoList.add(playersStatsAndInfo);
  }

  topDefensivePlayersStatsAndInfoNotifier.topDefensivePlayersStatsAndInfoList = topDefensivePlayersStatsAndInfoList;

}
