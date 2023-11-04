import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/c_match_day_banner_for_league.dart';
import '../notifier/c_match_day_banner_for_league_notifier.dart';

getMatchDayBannerForLeague(MatchDayBannerForLeagueNotifier matchDayBannerForLeagueNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('MatchDayBannerForLeague')
      .orderBy('league', descending: false)
      .get();

  List<MatchDayBannerForLeague> matchDayBannerForLeagueList = [];

  for (var document in snapshot.docs) {
    MatchDayBannerForLeague matchDayBannerForLeague =
        MatchDayBannerForLeague.fromMap(document.data() as Map<String, dynamic>);
    matchDayBannerForLeagueList.add(matchDayBannerForLeague);
  }

  matchDayBannerForLeagueNotifier.matchDayBannerForLeagueList = matchDayBannerForLeagueList;
}
