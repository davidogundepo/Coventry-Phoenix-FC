import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/c_match_day_banner_for_club.dart';
import '../notifier/c_match_day_banner_for_club_notifier.dart';

getMatchDayBannerForClub(MatchDayBannerForClubNotifier matchDayBannerForClubNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('MatchDayBannerForClub')
      .orderBy('id', descending: false)
      .get();

  List<MatchDayBannerForClub> matchDayBannerForClubList = [];

  for (var document in snapshot.docs) {
    MatchDayBannerForClub matchDayBannerForClub =
        MatchDayBannerForClub.fromMap(document.data() as Map<String, dynamic>);
    matchDayBannerForClubList.add(matchDayBannerForClub);
  }

  matchDayBannerForClubNotifier.matchDayBannerForClubList = matchDayBannerForClubList;
}
