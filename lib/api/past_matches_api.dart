import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/past_matches.dart';
import '../notifier/past_matches_notifier.dart';

getPastMatches(PastMatchesNotifier pastMatchesNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('PastMatches')
      .orderBy('id', descending: true)
      .get();

  List<PastMatches> pastMatchesList = [];

  for (var document in snapshot.docs) {
    PastMatches pastMatches =
        PastMatches.fromMap(document.data() as Map<String, dynamic>);
    pastMatchesList.add(pastMatches);
  }

  pastMatchesNotifier.pastMatchesList = pastMatchesList;
}
