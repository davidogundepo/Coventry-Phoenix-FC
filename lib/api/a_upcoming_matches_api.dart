import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../model/a_upcoming_matches.dart';
import '../notifier/a_upcoming_matches_notifier.dart';

getUpcomingMatches(UpcomingMatchesNotifier upcomingMatchesNotifier) async {
  QuerySnapshot snapshot =
  await FirebaseFirestore.instance.collection('UpcomingMatches').get();

  List<UpcomingMatches> upcomingMatchesList = [];

  // Function to parse date strings and compare them
  int compareDate(String dateString1, String dateString2) {
    DateTime date1 = DateFormat('dd-MM-yyyy HH:mm').parse(dateString1);
    DateTime date2 = DateFormat('dd-MM-yyyy HH:mm').parse(dateString2);
    return date1.compareTo(date2); // Compare in ascending order
  }

  // Sort documents based on the custom comparison function
  snapshot.docs.sort((a, b) => compareDate(a['match_date'], b['match_date']));

  for (var document in snapshot.docs) {
    UpcomingMatches upcomingMatches =
    UpcomingMatches.fromMap(document.data() as Map<String, dynamic>);
    upcomingMatchesList.add(upcomingMatches);
  }

  upcomingMatchesNotifier.upcomingMatchesList = upcomingMatchesList;
}
