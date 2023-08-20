import 'dart:collection';
import 'package:flutter/cupertino.dart';
import '../model/a_upcoming_matches.dart';

class UpcomingMatchesNotifier with ChangeNotifier {
  List<UpcomingMatches> _upcomingMatchesList = [];
  late UpcomingMatches _currentUpcomingMatches;

  UnmodifiableListView<UpcomingMatches> get upcomingMatchesList =>
      UnmodifiableListView(_upcomingMatchesList);

  UpcomingMatches get currentUpcomingMatches => _currentUpcomingMatches;

  set upcomingMatchesList(List<UpcomingMatches> upcomingMatchesList) {
    _upcomingMatchesList = upcomingMatchesList;
    notifyListeners();
  }

  set currentUpcomingMatches(UpcomingMatches upcomingMatches) {
    _currentUpcomingMatches = upcomingMatches;
    notifyListeners();
  }
}
