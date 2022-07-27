import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/coaches.dart';
import '../notifier/coaching_staff_notifier.dart';

getCoaches(
    CoachesNotifier coachesNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('Coaches')
      .orderBy('id')
      .get();

  List<Coaches> coachesList = [];

  for (var document in snapshot.docs) {
    Coaches coaches =
        Coaches.fromMap(document.data() as Map<String, dynamic>);
    coachesList.add(coaches);
  }

  coachesNotifier.coachesList =
      coachesList;
}
