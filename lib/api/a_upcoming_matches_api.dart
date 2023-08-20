import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/a_upcoming_matches.dart';
import '../notifier/a_upcoming_matches_notifier.dart';

getUpcomingMatches(UpcomingMatchesNotifier upcomingMatchesNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('UpcomingMatches')
      .orderBy('id', descending: true)
      .get();

  List<UpcomingMatches> upcomingMatchesList = [];

  for (var document in snapshot.docs) {
    UpcomingMatches upcomingMatches =
        UpcomingMatches.fromMap(document.data() as Map<String, dynamic>);
    upcomingMatchesList.add(upcomingMatches);
  }

  upcomingMatchesNotifier.upcomingMatchesList = upcomingMatchesList;
}
