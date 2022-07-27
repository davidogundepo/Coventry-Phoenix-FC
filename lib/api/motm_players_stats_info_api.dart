import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/players_stats_and_info.dart';
import '../notifier/motm_players_stats_info_notifier.dart';


getMOTMPlayersStatsAndInfo(MOTMPlayersStatsAndInfoNotifier mOTMPlayersStatsAndInfoNotifier) async {

  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('PlayersTable')
      .where('man_of_the_match', whereIn: ['yes','Yes','YES', 'yES', 'yeS', 'YEs', 'yEs', 'YeS'])
      .limit(10)
      .get();

  List<PlayersStatsAndInfo> mOTMPlayersStatsAndInfoList = [];

  for (var document in snapshot.docs) {
    PlayersStatsAndInfo playersStatsAndInfo = PlayersStatsAndInfo.fromMap(document.data() as Map<String, dynamic>);
    mOTMPlayersStatsAndInfoList.add(playersStatsAndInfo);
  }

  mOTMPlayersStatsAndInfoNotifier.mOTMPlayersStatsAndInfoList = mOTMPlayersStatsAndInfoList;

}
