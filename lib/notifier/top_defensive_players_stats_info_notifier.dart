
import 'dart:collection';
import 'package:flutter/cupertino.dart';
import '../model/players_stats_and_info.dart';


class TopDefensivePlayersStatsAndInfoNotifier with ChangeNotifier {
  List<PlayersStatsAndInfo> _topDefensivePlayersStatsAndInfoList = <PlayersStatsAndInfo>[];
  late PlayersStatsAndInfo _currentTopDefensivePlayersStatsAndInfo;

  UnmodifiableListView<PlayersStatsAndInfo> get topDefensivePlayersStatsAndInfoList => UnmodifiableListView(_topDefensivePlayersStatsAndInfoList);

  PlayersStatsAndInfo get currentTopDefensivePlayersStatsAndInfo => _currentTopDefensivePlayersStatsAndInfo;

  set topDefensivePlayersStatsAndInfoList(List<PlayersStatsAndInfo> topDefensivePlayersStatsAndInfoList) {
    _topDefensivePlayersStatsAndInfoList = topDefensivePlayersStatsAndInfoList;
    notifyListeners();
  }

  set currentTopDefensivePlayersStatsAndInfo(PlayersStatsAndInfo playersStatsAndInfo) {
    _currentTopDefensivePlayersStatsAndInfo = playersStatsAndInfo;
    notifyListeners();
  }

}