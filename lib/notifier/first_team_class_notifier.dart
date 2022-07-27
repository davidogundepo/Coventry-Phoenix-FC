
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import '../model/first_team_class.dart';

class FirstTeamClassNotifier with ChangeNotifier {
  List<FirstTeamClass> _firstTeamClassList = [];
  late FirstTeamClass _currentFirstTeamClass;

  UnmodifiableListView<FirstTeamClass> get firstTeamClassList => UnmodifiableListView(_firstTeamClassList);

  FirstTeamClass get currentFirstTeamClass => _currentFirstTeamClass;

  set firstTeamClassList(List<FirstTeamClass> firstTeamClassList) {
    _firstTeamClassList = firstTeamClassList;
    notifyListeners();
  }

  set currentFirstTeamClass(FirstTeamClass firstTeamClass) {
    _currentFirstTeamClass = firstTeamClass;
    notifyListeners();
  }

}