
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import '../model/second_team_class.dart';

class SecondTeamClassNotifier with ChangeNotifier {
  List<SecondTeamClass> _secondTeamClassList = [];
  late SecondTeamClass _currentSecondTeamClass;

  UnmodifiableListView<SecondTeamClass> get secondTeamClassList => UnmodifiableListView(_secondTeamClassList);

  SecondTeamClass get currentSecondTeamClass => _currentSecondTeamClass;

  set secondTeamClassList(List<SecondTeamClass> secondTeamClassList) {
    _secondTeamClassList = secondTeamClassList;
    notifyListeners();
  }

  set currentSecondTeamClass(SecondTeamClass secondTeamClass) {
    _currentSecondTeamClass = secondTeamClass;
    notifyListeners();
  }

}