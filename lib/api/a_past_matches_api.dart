import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting

import '../model/a_past_matches.dart';
import '../notifier/a_past_matches_notifier.dart';

getPastMatches(PastMatchesNotifier pastMatchesNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('PastMatches').get();

  List<PastMatches> pastMatchesList = [];

  // Function to parse date strings and compare them
  int compareDate(String dateString1, String dateString2) {
    DateTime date1 = DateFormat('dd-MM-yyyy HH:mm').parse(dateString1);
    DateTime date2 = DateFormat('dd-MM-yyyy HH:mm').parse(dateString2);
    return date2.compareTo(date1); // Compare in descending order
  }

  // Sort documents based on the custom comparison function
  snapshot.docs.sort((a, b) => compareDate(a['match_date'], b['match_date']));

  for (var document in snapshot.docs) {
    PastMatches pastMatches = PastMatches.fromMap(document.data() as Map<String, dynamic>);
    pastMatchesList.add(pastMatches);
  }

  pastMatchesNotifier.pastMatchesList = pastMatchesList;
}
