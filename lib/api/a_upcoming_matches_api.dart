import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/a_upcoming_matches.dart';
import '../notifier/a_upcoming_matches_notifier.dart';

getUpcomingMatches(UpcomingMatchesNotifier upcomingMatchesNotifier) async {

 DateTime currentDate = DateTime.now();
  double currentFractionalDays = currentDate.millisecondsSinceEpoch / (1000 * 60 * 60 * 24);

  // print('Current Fractional Days: $currentFractionalDays');
  // print('Current Fractional Days: $currentDate');

  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('UpcomingMatches')
      .orderBy('id', descending: false)
      .limit(10)
      .get();

  List<UpcomingMatches> upcomingMatchesList = [];

  for (var document in snapshot.docs) {
    // double matchDateTwo = (document['match_date_two'] as num).toDouble();
    // if (matchDateTwo >= currentFractionalDays) {
      UpcomingMatches upcomingMatches = UpcomingMatches.fromMap(document.data() as Map<String, dynamic>);
      upcomingMatchesList.add(upcomingMatches);
    // }
  }

  upcomingMatchesNotifier.upcomingMatchesList = upcomingMatchesList;
}

