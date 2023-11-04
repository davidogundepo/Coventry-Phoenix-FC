import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/club_sponsors.dart';
import '../notifier/club_sponsors_notifier.dart';

getClubSponsors(ClubSponsorsNotifier clubSponsorsNotifier) async {
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('ClubSponsors')
          .orderBy('name', descending: false)
          .get();

  List<ClubSponsors> clubSponsorsList = [];

  for (var document in snapshot.docs) {
    ClubSponsors clubSponsors =
        ClubSponsors.fromMap(document.data() as Map<String, dynamic>);
    clubSponsorsList.add(clubSponsors);
  }

  clubSponsorsNotifier.clubSponsorsList = clubSponsorsList;
}
