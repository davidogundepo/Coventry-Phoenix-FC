import 'dart:collection';
import 'package:flutter/cupertino.dart';
import '../model/club_sponsors.dart';

class ClubSponsorsNotifier with ChangeNotifier {
  List<ClubSponsors> _clubSponsorsList = [];
  late ClubSponsors _currentClubSponsors;

  UnmodifiableListView<ClubSponsors> get clubSponsorsList =>
      UnmodifiableListView(_clubSponsorsList);

  ClubSponsors get currentClubSponsors => _currentClubSponsors;

  set clubSponsorsList(List<ClubSponsors> clubSponsorsList) {
    _clubSponsorsList = clubSponsorsList;
    notifyListeners();
  }

  set currentClubSponsors(ClubSponsors clubSponsors) {
    _currentClubSponsors = clubSponsors;
    notifyListeners();
  }
}
