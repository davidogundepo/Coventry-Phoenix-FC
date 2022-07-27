
import 'dart:collection';
import 'package:flutter/cupertino.dart';
import '../model/players_stats_and_info.dart';


class MostFouledYCPlayersStatsAndInfoNotifier with ChangeNotifier {
  List<PlayersStatsAndInfo> _mostFouledYCPlayersStatsAndInfoList = <PlayersStatsAndInfo>[];
  late PlayersStatsAndInfo _currentMostFouledYCPlayersStatsAndInfo;

  UnmodifiableListView<PlayersStatsAndInfo> get mostFouledYCPlayersStatsAndInfoList => UnmodifiableListView(_mostFouledYCPlayersStatsAndInfoList);

  PlayersStatsAndInfo get currentMostFouledYCPlayersStatsAndInfo => _currentMostFouledYCPlayersStatsAndInfo;

  set mostFouledYCPlayersStatsAndInfoList(List<PlayersStatsAndInfo> mostFouledYCPlayersStatsAndInfoList) {
    _mostFouledYCPlayersStatsAndInfoList = mostFouledYCPlayersStatsAndInfoList;
    notifyListeners();
  }

  set currentMostFouledYCPlayersStatsAndInfo(PlayersStatsAndInfo playersStatsAndInfo) {
    _currentMostFouledYCPlayersStatsAndInfo = playersStatsAndInfo;
    notifyListeners();
  }

}