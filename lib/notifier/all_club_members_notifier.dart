import 'dart:collection';
import 'dart:async';
import '../model/coaches.dart';
import '../model/management_body.dart';
import 'package:flutter/material.dart';
import '../model/first_team_class.dart';
import '../model/second_team_class.dart';

class AllClubMembersNotifier with ChangeNotifier {
  List<FirstTeamClass> _firstTeamClassList = [];
  List<SecondTeamClass> _secondTeamClassList = [];
  List<Coaches> _coachesClassList = [];
  List<ManagementBody> _mgmtBodyClassList = [];

  UnmodifiableListView<FirstTeamClass> get firstTeamClassList =>
      UnmodifiableListView(_firstTeamClassList);

  UnmodifiableListView<SecondTeamClass> get secondTeamClassList =>
      UnmodifiableListView(_secondTeamClassList);

  UnmodifiableListView<Coaches> get coachesClassList =>
      UnmodifiableListView(_coachesClassList);

  UnmodifiableListView<ManagementBody> get mgmtBodyClassList =>
      UnmodifiableListView(_mgmtBodyClassList);



  // StreamController and Stream for allClubMembers
  final _allClubMembersController = StreamController<List<dynamic>>.broadcast();
  Stream<List<dynamic>> get allClubMembersStream => _allClubMembersController.stream;

  // Method to set data for first team allClubMembers
  void setFirstTeamAllClubMembers(List<FirstTeamClass> allClubMembers) {
    _firstTeamClassList = allClubMembers;
    notifyListeners();
    _updateAllClubMembers();
  }

  // Method to set data for second team allClubMembers
  void setSecondTeamAllClubMembers(List<SecondTeamClass> allClubMembers) {
    _secondTeamClassList = allClubMembers;
    notifyListeners();
    _updateAllClubMembers();
  }

  // Method to set data for first team allClubMembers
  void setCoaches(List<Coaches> allClubMembers) {
    _coachesClassList = allClubMembers;
    notifyListeners();
    _updateAllClubMembers();
  }

  // Method to set data for second team allClubMembers
  void setMGMTBody(List<ManagementBody> allClubMembers) {
    _mgmtBodyClassList = allClubMembers;
    notifyListeners();
    _updateAllClubMembers();
  }



  // Add a private method to update the allClubMembers stream
  void _updateAllClubMembers() {
    final allClubMembersList = [
      ..._firstTeamClassList, ..._secondTeamClassList,
      ..._coachesClassList, ..._mgmtBodyClassList];
    _allClubMembersController.add(allClubMembersList);
  }

  // Getter for all allClubMembers
  List<dynamic> get allClubMembersList => [
        ..._firstTeamClassList, ..._secondTeamClassList,
        ..._coachesClassList, ..._mgmtBodyClassList];
}
