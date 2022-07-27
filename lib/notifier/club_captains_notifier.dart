
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import '../model/captains.dart';

class CaptainsNotifier with ChangeNotifier {
  List<Captains> _captainsList = [];
  late Captains _currentCaptains;

  UnmodifiableListView<Captains> get captainsList => UnmodifiableListView(_captainsList);

  Captains get currentCaptains => _currentCaptains;

  set captainsList(List<Captains> captainsList) {
    _captainsList = captainsList;
    notifyListeners();
  }

  set currentCaptains(Captains captains) {
    _currentCaptains = captains;
    notifyListeners();
  }

}