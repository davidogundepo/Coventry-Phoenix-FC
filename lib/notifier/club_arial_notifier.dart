
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import '../model/club_arial.dart';

class ClubArialNotifier with ChangeNotifier {
  List<ClubArial> _clubArialList = [];
  late ClubArial _currentClubArial;

  UnmodifiableListView<ClubArial> get clubArialList => UnmodifiableListView(_clubArialList);

  ClubArial get currentClubArial => _currentClubArial;

  set clubArialList(List<ClubArial> clubArialList) {
    _clubArialList = clubArialList;
    notifyListeners();
  }

  set currentClubArial(ClubArial clubArial) {
    _currentClubArial = clubArial;
    notifyListeners();
  }

}