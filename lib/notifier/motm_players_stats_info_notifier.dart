
import 'dart:collection';
import 'package:flutter/cupertino.dart';
import '../model/players_stats_and_info.dart';


class MOTMPlayersStatsAndInfoNotifier with ChangeNotifier {
  List<PlayersStatsAndInfo> _mOTMPlayersStatsAndInfoList = <PlayersStatsAndInfo>[];
  late PlayersStatsAndInfo _currentMOTMPlayersStatsAndInfo;

  UnmodifiableListView<PlayersStatsAndInfo> get mOTMPlayersStatsAndInfoList => UnmodifiableListView(_mOTMPlayersStatsAndInfoList);

  PlayersStatsAndInfo get currentMOTMPlayersStatsAndInfo => _currentMOTMPlayersStatsAndInfo;

  set mOTMPlayersStatsAndInfoList(List<PlayersStatsAndInfo> mOTMPlayersStatsAndInfoList) {
    _mOTMPlayersStatsAndInfoList = mOTMPlayersStatsAndInfoList;
    notifyListeners();
  }

  set currentMOTMPlayersStatsAndInfo(PlayersStatsAndInfo playersStatsAndInfo) {
    _currentMOTMPlayersStatsAndInfo = playersStatsAndInfo;
    notifyListeners();
  }

}