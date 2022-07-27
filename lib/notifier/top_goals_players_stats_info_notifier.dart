
import 'dart:collection';
import 'package:flutter/cupertino.dart';
import '../model/players_stats_and_info.dart';


class TopGoalsPlayersStatsAndInfoNotifier with ChangeNotifier {
  List<PlayersStatsAndInfo> _topGoalsPlayersStatsAndInfoList = <PlayersStatsAndInfo>[];
  late PlayersStatsAndInfo _currentTopGoalsPlayersStatsAndInfo;

  UnmodifiableListView<PlayersStatsAndInfo> get topGoalsPlayersStatsAndInfoList => UnmodifiableListView(_topGoalsPlayersStatsAndInfoList);

  PlayersStatsAndInfo get currentTopGoalsPlayersStatsAndInfo => _currentTopGoalsPlayersStatsAndInfo;

  set topGoalsPlayersStatsAndInfoList(List<PlayersStatsAndInfo> topGoalsPlayersStatsAndInfoList) {
    _topGoalsPlayersStatsAndInfoList = topGoalsPlayersStatsAndInfoList;
    notifyListeners();
  }

  set currentTopGoalsPlayersStatsAndInfo(PlayersStatsAndInfo playersStatsAndInfo) {
    _currentTopGoalsPlayersStatsAndInfo = playersStatsAndInfo;
    notifyListeners();
  }

}