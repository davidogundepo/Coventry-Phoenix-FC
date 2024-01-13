import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/captains.dart';
import '../notifier/club_captains_notifier.dart';


//Dependency in version [global use API]

getCaptains(CaptainsNotifier captainsNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('Captains')
      .orderBy('name')
      .get();

  List<Captains> captainsList = [];

  for (var document in snapshot.docs) {
    Captains captains =
        Captains.fromMap(document.data() as Map<String, dynamic>);
    captainsList.add(captains);
  }

  captainsNotifier.captainsList = captainsList;
}


// Fuelling station to .. and its payment by the app [current focus on EV vehicles]
// Complexity ==
// App is a white label
// [Riverpods check it out]
// Check out Clean Arc