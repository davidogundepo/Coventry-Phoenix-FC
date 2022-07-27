
import 'dart:collection';
import 'package:flutter/cupertino.dart';
import '../model/players_stats_and_info.dart';


class CumMOTMPlayersStatsAndInfoNotifier with ChangeNotifier {
  List<PlayersStatsAndInfo> _cumMOTMPlayersStatsAndInfoList = <PlayersStatsAndInfo>[];
  late PlayersStatsAndInfo _currentCumMOTMPlayersStatsAndInfo;

  UnmodifiableListView<PlayersStatsAndInfo> get cumMOTMPlayersStatsAndInfoList => UnmodifiableListView(_cumMOTMPlayersStatsAndInfoList);

  PlayersStatsAndInfo get currentCumMOTMPlayersStatsAndInfo => _currentCumMOTMPlayersStatsAndInfo;

  set cumMOTMPlayersStatsAndInfoList(List<PlayersStatsAndInfo> cumMOTMPlayersStatsAndInfoList) {
    _cumMOTMPlayersStatsAndInfoList = cumMOTMPlayersStatsAndInfoList;
    notifyListeners();
  }

  set currentCumMOTMPlayersStatsAndInfo(PlayersStatsAndInfo playersStatsAndInfo) {
    _currentCumMOTMPlayersStatsAndInfo = playersStatsAndInfo;
    notifyListeners();
  }

}