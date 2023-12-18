import 'dart:collection';
import 'dart:async';
import '../model/c_match_day_banner_for_club.dart';
import '../model/c_match_day_banner_for_club_opp.dart';
import 'package:flutter/material.dart';

class AllFCTeamsNotifier with ChangeNotifier {
  List<MatchDayBannerForClub> _matchDayBannerForClubList = [];
  List<MatchDayBannerForClubOpp> _matchDayBannerForClubOppList = [];

  UnmodifiableListView<MatchDayBannerForClub> get matchDayBannerForClubList => UnmodifiableListView(_matchDayBannerForClubList);

  UnmodifiableListView<MatchDayBannerForClubOpp> get matchDayBannerForClubOppList => UnmodifiableListView(_matchDayBannerForClubOppList);

  // StreamController and Stream for allFCTeams
  final _allFCTeamsController = StreamController<List<dynamic>>.broadcast();
  Stream<List<dynamic>> get allFCTeamsStream => _allFCTeamsController.stream;

  // Method to set data for first team allFCTeams
  void setMatchDayBannerForClubAllFCTeams(List<MatchDayBannerForClub> allFCTeams) {
    _matchDayBannerForClubList = allFCTeams;
    notifyListeners();
    _updateAllFCTeams();
  }

  // Method to set data for second team allFCTeams
  void setMatchDayBannerForClubOppAllFCTeams(List<MatchDayBannerForClubOpp> allFCTeams) {
    _matchDayBannerForClubOppList = allFCTeams;
    notifyListeners();
    _updateAllFCTeams();
  }

  // Add a private method to update the allFCTeams stream
  void _updateAllFCTeams() {
    final allFCTeamsList = [..._matchDayBannerForClubList, ..._matchDayBannerForClubOppList];
    _allFCTeamsController.add(allFCTeamsList);
  }

  // Getter for all allFCTeams
  List<dynamic> get allFCTeamsList => [..._matchDayBannerForClubList, ..._matchDayBannerForClubOppList];
}
