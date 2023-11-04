import 'dart:collection';

import 'package:flutter/cupertino.dart';

import '../model/c_match_day_banner_for_club_opp.dart';

class MatchDayBannerForClubOppNotifier with ChangeNotifier {
  List<MatchDayBannerForClubOpp> _matchDayBannerForClubOppList = [];
  late MatchDayBannerForClubOpp _currentMatchDayBannerForClubOpp;

  UnmodifiableListView<MatchDayBannerForClubOpp> get matchDayBannerForClubOppList =>
      UnmodifiableListView(_matchDayBannerForClubOppList);

  MatchDayBannerForClubOpp get currentMatchDayBannerForClubOpp => _currentMatchDayBannerForClubOpp;

  set matchDayBannerForClubOppList(List<MatchDayBannerForClubOpp> matchDayBannerForClubOppList) {
    _matchDayBannerForClubOppList = matchDayBannerForClubOppList;
    notifyListeners();
  }

  set currentMatchDayBannerForClubOpp(MatchDayBannerForClubOpp matchDayBannerForClubOpp) {
    _currentMatchDayBannerForClubOpp = matchDayBannerForClubOpp;
    notifyListeners();
  }
}
