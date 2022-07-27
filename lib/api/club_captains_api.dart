import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/captains.dart';
import '../notifier/club_captains_notifier.dart';

getCaptains(CaptainsNotifier captainsNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('Captains')
      .orderBy('id')
      .get();

  List<Captains> captainsList = [];

  for (var document in snapshot.docs) {
    Captains captains = Captains.fromMap(document.data() as Map<String, dynamic>);
    captainsList.add(captains);
  }

  captainsNotifier.captainsList = captainsList;
}
