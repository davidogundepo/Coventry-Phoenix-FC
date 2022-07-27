
import 'dart:collection';
import 'package:flutter/cupertino.dart';
import '../model/players_stats_and_info.dart';


class TopGKPlayersStatsAndInfoNotifier with ChangeNotifier {
  List<PlayersStatsAndInfo> _topGKPlayersStatsAndInfoList = <PlayersStatsAndInfo>[];
  late PlayersStatsAndInfo _currentTopGKPlayersStatsAndInfo;

  UnmodifiableListView<PlayersStatsAndInfo> get topGKPlayersStatsAndInfoList => UnmodifiableListView(_topGKPlayersStatsAndInfoList);

  PlayersStatsAndInfo get currentTopGKPlayersStatsAndInfo => _currentTopGKPlayersStatsAndInfo;

  set topGKPlayersStatsAndInfoList(List<PlayersStatsAndInfo> topGKPlayersStatsAndInfoList) {
    _topGKPlayersStatsAndInfoList = topGKPlayersStatsAndInfoList;
    notifyListeners();
  }

  set currentTopGKPlayersStatsAndInfo(PlayersStatsAndInfo playersStatsAndInfo) {
    _currentTopGKPlayersStatsAndInfo = playersStatsAndInfo;
    notifyListeners();
  }

}