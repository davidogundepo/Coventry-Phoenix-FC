import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/players_stats_and_info.dart';
import '../notifier/player_of_the_month_stats_info_notifier.dart';


getPlayerOfTheMonthStatsAndInfo(PlayerOfTheMonthStatsAndInfoNotifier playerOfTheMonthStatsAndInfoNotifier) async {

  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('PlayersTable')
      .where('player_of_the_month', whereIn: ['yes','Yes','YES', 'yES', 'yeS', 'YEs', 'yEs', 'YeS'])
      .limit(1)
      .get();

  List<PlayersStatsAndInfo> playerOfTheMonthStatsAndInfoList = [];

  for (var document in snapshot.docs) {
    PlayersStatsAndInfo playersStatsAndInfo = PlayersStatsAndInfo.fromMap(document.data() as Map<String, dynamic>);
    playerOfTheMonthStatsAndInfoList.add(playersStatsAndInfo);
  }

  playerOfTheMonthStatsAndInfoNotifier.playerOfTheMonthStatsAndInfoList = playerOfTheMonthStatsAndInfoList;

}
