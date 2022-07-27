
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import '../model/coaches.dart';

class CoachesNotifier with ChangeNotifier {
  List<Coaches> _coachesList = [];
  late Coaches _currentCoaches;

  UnmodifiableListView<Coaches> get coachesList => UnmodifiableListView(_coachesList);

  Coaches get currentCoaches => _currentCoaches;

  set coachesList(List<Coaches> coachesList) {
    _coachesList = coachesList;
    notifyListeners();
  }

  set currentCoaches(Coaches coaches) {
    _currentCoaches = coaches;
    notifyListeners();
  }

}