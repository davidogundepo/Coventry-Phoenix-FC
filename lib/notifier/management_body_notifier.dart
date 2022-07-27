
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import '../model/management_body.dart';

class ManagementBodyNotifier with ChangeNotifier {
  List<ManagementBody> _managementBodyList = [];
  late ManagementBody _currentManagementBody;

  UnmodifiableListView<ManagementBody> get managementBodyList => UnmodifiableListView(_managementBodyList);

  ManagementBody get currentManagementBody => _currentManagementBody;

  set managementBodyList(List<ManagementBody> managementBodyList) {
    _managementBodyList = managementBodyList;
    notifyListeners();
  }

  set currentManagementBody(ManagementBody managementBody) {
    _currentManagementBody = managementBody;
    notifyListeners();
  }

}