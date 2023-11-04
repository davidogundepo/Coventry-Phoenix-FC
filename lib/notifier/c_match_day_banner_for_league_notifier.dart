import 'dart:collection';

import 'package:flutter/cupertino.dart';

import '../model/c_match_day_banner_for_league.dart';

class MatchDayBannerForLeagueNotifier with ChangeNotifier {
  List<MatchDayBannerForLeague> _matchDayBannerForLeagueList = [];
  late MatchDayBannerForLeague _currentMatchDayBannerForLeague;

  UnmodifiableListView<MatchDayBannerForLeague> get matchDayBannerForLeagueList =>
      UnmodifiableListView(_matchDayBannerForLeagueList);

  MatchDayBannerForLeague get currentMatchDayBannerForLeague => _currentMatchDayBannerForLeague;

  set matchDayBannerForLeagueList(List<MatchDayBannerForLeague> matchDayBannerForLeagueList) {
    _matchDayBannerForLeagueList = matchDayBannerForLeagueList;
    notifyListeners();
  }

  set currentMatchDayBannerForLeague(MatchDayBannerForLeague matchDayBannerForLeague) {
    _currentMatchDayBannerForLeague = matchDayBannerForLeague;
    notifyListeners();
  }
}
