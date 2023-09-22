import 'dart:collection';
import 'dart:async';
import 'package:flutter/material.dart';
import '../model/first_team_class.dart';
import '../model/second_team_class.dart';

class PlayersNotifier with ChangeNotifier {
  List<FirstTeamClass> _firstTeamClassList = [];
  List<SecondTeamClass> _secondTeamClassList = [];

  UnmodifiableListView<FirstTeamClass> get firstTeamClassList =>
      UnmodifiableListView(_firstTeamClassList);

  UnmodifiableListView<SecondTeamClass> get secondTeamClassList =>
      UnmodifiableListView(_secondTeamClassList);

  // StreamController and Stream for players
  final _playersController = StreamController<List<dynamic>>.broadcast();
  Stream<List<dynamic>> get playersStream => _playersController.stream;

  // Method to set data for first team players
  void setFirstTeamPlayers(List<FirstTeamClass> players) {
    _firstTeamClassList = players;
    notifyListeners();
    _updatePlayers();
  }

  // Method to set data for second team players
  void setSecondTeamPlayers(List<SecondTeamClass> players) {
    _secondTeamClassList = players;
    notifyListeners();
    _updatePlayers();
  }

  // Add a private method to update the players stream
  void _updatePlayers() {
    final playersList = [..._firstTeamClassList, ..._secondTeamClassList];
    _playersController.add(playersList);
  }

  // Getter for  players
  List<dynamic> get playersList =>
      [..._firstTeamClassList, ..._secondTeamClassList];
}
