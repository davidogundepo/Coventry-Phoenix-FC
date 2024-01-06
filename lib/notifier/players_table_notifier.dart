import 'dart:collection';
import 'package:flutter/cupertino.dart';
import '../model/players_table.dart';

class PlayersTableNotifier with ChangeNotifier {
  List<PlayersTable> _playersTableList = [];
  late PlayersTable _currentPlayersTable;

  UnmodifiableListView<PlayersTable> get playersTableList =>
      UnmodifiableListView(_playersTableList);

  PlayersTable get currentPlayersTable => _currentPlayersTable;

  set playersTableList(List<PlayersTable> playersTableList) {
    _playersTableList = playersTableList;
    notifyListeners();
  }

  set currentPlayersTable(PlayersTable playersTable) {
    _currentPlayersTable = playersTable;
    notifyListeners();
  }
}
