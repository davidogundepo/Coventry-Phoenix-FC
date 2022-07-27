
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import '../model/third_team_class.dart';

class ThirdTeamClassNotifier with ChangeNotifier {
  List<ThirdTeamClass> _thirdTeamClassList = [];
  late ThirdTeamClass _currentThirdTeamClass;

  UnmodifiableListView<ThirdTeamClass> get thirdTeamClassList => UnmodifiableListView(_thirdTeamClassList);

  ThirdTeamClass get currentThirdTeamClass => _currentThirdTeamClass;

  set thirdTeamClassList(List<ThirdTeamClass> thirdTeamClassList) {
    _thirdTeamClassList = thirdTeamClassList;
    notifyListeners();
  }

  set currentThirdTeamClass(ThirdTeamClass thirdTeamClass) {
    _currentThirdTeamClass = thirdTeamClass;
    notifyListeners();
  }

}