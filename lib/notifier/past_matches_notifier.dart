import 'dart:collection';
import 'package:flutter/cupertino.dart';
import '../model/past_matches.dart';

class PastMatchesNotifier with ChangeNotifier {
  List<PastMatches> _pastMatchesList = [];
  late PastMatches _currentPastMatches;

  UnmodifiableListView<PastMatches> get pastMatchesList =>
      UnmodifiableListView(_pastMatchesList);

  PastMatches get currentPastMatches => _currentPastMatches;

  set pastMatchesList(List<PastMatches> pastMatchesList) {
    _pastMatchesList = pastMatchesList;
    notifyListeners();
  }

  set currentPastMatches(PastMatches pastMatches) {
    _currentPastMatches = pastMatches;
    notifyListeners();
  }
}
