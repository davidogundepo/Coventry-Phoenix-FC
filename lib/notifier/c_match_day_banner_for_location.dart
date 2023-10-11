import 'dart:collection';

import 'package:flutter/cupertino.dart';

import '../model/c_match_day_banner_for_location.dart';

class MatchDayBannerForLocationNotifier with ChangeNotifier {
  List<MatchDayBannerForLocation> _matchDayBannerForLocationList = [];
  late MatchDayBannerForLocation _currentMatchDayBannerForLocation;

  UnmodifiableListView<MatchDayBannerForLocation> get matchDayBannerForLocationList =>
      UnmodifiableListView(_matchDayBannerForLocationList);

  MatchDayBannerForLocation get currentMatchDayBannerForLocation => _currentMatchDayBannerForLocation;

  set matchDayBannerForLocationList(List<MatchDayBannerForLocation> matchDayBannerForLocationList) {
    _matchDayBannerForLocationList = matchDayBannerForLocationList;
    notifyListeners();
  }

  set currentMatchDayBannerForLocation(MatchDayBannerForLocation matchDayBannerForLocation) {
    _currentMatchDayBannerForLocation = matchDayBannerForLocation;
    notifyListeners();
  }
}
