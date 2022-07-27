
import 'dart:collection';
import 'package:flutter/cupertino.dart';
import '../model/players_stats_and_info.dart';


class PlayerOfTheMonthStatsAndInfoNotifier with ChangeNotifier {
  List<PlayersStatsAndInfo> _playerOfTheMonthStatsAndInfoList = <PlayersStatsAndInfo>[];
  PlayersStatsAndInfo? _currentPlayerOfTheMonthStatsAndInfo;

  UnmodifiableListView<PlayersStatsAndInfo> get playerOfTheMonthStatsAndInfoList => UnmodifiableListView(_playerOfTheMonthStatsAndInfoList);

  PlayersStatsAndInfo? get currentPlayerOfTheMonthStatsAndInfo => _currentPlayerOfTheMonthStatsAndInfo;

  set playerOfTheMonthStatsAndInfoList(List<PlayersStatsAndInfo> playerOfTheMonthStatsAndInfoList) {
    _playerOfTheMonthStatsAndInfoList = playerOfTheMonthStatsAndInfoList;
    notifyListeners();
  }

  set currentPlayerOfTheMonthStatsAndInfo(PlayersStatsAndInfo? playersStatsAndInfo) {
    _currentPlayerOfTheMonthStatsAndInfo = playersStatsAndInfo;
    notifyListeners();
  }

}