import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/c_match_day_banner_for_club_opp.dart';
import '../notifier/c_match_day_banner_for_club_opp.dart';

getMatchDayBannerForClubOpp(MatchDayBannerForClubOppNotifier matchDayBannerForClubOppNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('MatchDayBannerForClubOpp')
      .orderBy('id', descending: false)
      .get();

  List<MatchDayBannerForClubOpp> matchDayBannerForClubOppList = [];

  for (var document in snapshot.docs) {
    MatchDayBannerForClubOpp matchDayBannerForClubOpp =
        MatchDayBannerForClubOpp.fromMap(document.data() as Map<String, dynamic>);
    matchDayBannerForClubOppList.add(matchDayBannerForClubOpp);
  }

  matchDayBannerForClubOppNotifier.matchDayBannerForClubOppList = matchDayBannerForClubOppList;
}
