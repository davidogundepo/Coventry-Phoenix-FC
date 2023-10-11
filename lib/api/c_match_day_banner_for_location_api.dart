import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/c_match_day_banner_for_location.dart';
import '../notifier/c_match_day_banner_for_location.dart';

getMatchDayBannerForLocation(MatchDayBannerForLocationNotifier matchDayBannerForLocationNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('MatchDayBannerForLocation')
      .orderBy('id', descending: false)
      .get();

  List<MatchDayBannerForLocation> matchDayBannerForLocationList = [];

  for (var document in snapshot.docs) {
    MatchDayBannerForLocation matchDayBannerForLocation =
        MatchDayBannerForLocation.fromMap(document.data() as Map<String, dynamic>);
    matchDayBannerForLocationList.add(matchDayBannerForLocation);
  }

  matchDayBannerForLocationNotifier.matchDayBannerForLocationList = matchDayBannerForLocationList;
}
