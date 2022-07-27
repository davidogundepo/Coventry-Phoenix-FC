
import 'dart:collection';
import 'package:flutter/cupertino.dart';
import '../model/trainings_and_games_reels.dart';


class TrainingsAndGamesReelsNotifier with ChangeNotifier {
  List<TrainingsAndGamesReels> _trainingsAndGamesReelsList = <TrainingsAndGamesReels>[];
  late TrainingsAndGamesReels _currentTrainingsAndGamesReels;

  UnmodifiableListView<TrainingsAndGamesReels> get trainingsAndGamesReelsList => UnmodifiableListView(_trainingsAndGamesReelsList);

  TrainingsAndGamesReels get currentTrainingsAndGamesReels => _currentTrainingsAndGamesReels;

  set trainingsAndGamesReelsList(List<TrainingsAndGamesReels> trainingsAndGamesReelsList) {
    _trainingsAndGamesReelsList = trainingsAndGamesReelsList;
    notifyListeners();
  }

  set currentTrainingsAndGamesReels(TrainingsAndGamesReels trainingsAndGamesReels) {
    _currentTrainingsAndGamesReels = trainingsAndGamesReels;
    notifyListeners();
  }

}