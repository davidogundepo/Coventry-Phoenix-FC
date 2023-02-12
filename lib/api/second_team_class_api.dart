import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/second_team_class.dart';
import '../notifier/second_team_class_notifier.dart';

// Future<void> getSecondTeamClass(SecondTeamClassNotifier secondTeamClassNotifier) async {
//   Future<QuerySnapshot> snapshot = FirebaseFirestore.instance
//       .collection('SecondTeamClassPlayers')
//       .orderBy('name')
//       .get();
//
//   List<Future> future = [snapshot];
//
//   List<QuerySnapshot> snapshots = await Future.wait(future as Iterable<Future<QuerySnapshot<Object?>>>);
//
//   List<SecondTeamClass> secondTeamClassList = [];
//
//   for (var document in snapshots[0].docs) {
//     SecondTeamClass secondTeamClass = SecondTeamClass.fromMap(document.data() as Map<String, dynamic>);
//     secondTeamClassList.add(secondTeamClass);
//   }
//
//   secondTeamClassNotifier.secondTeamClassList = secondTeamClassList;
// }

getSecondTeamClass(SecondTeamClassNotifier secondTeamClassNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('SecondTeamClassPlayers')
      .orderBy('name')
      .get();

  List<SecondTeamClass> secondTeamClassList = [];

  for (var document in snapshot.docs) {
    SecondTeamClass secondTeamClass = SecondTeamClass.fromMap(document.data() as Map<String, dynamic>);
    secondTeamClassList.add(secondTeamClass);
  }

  secondTeamClassNotifier.secondTeamClassList = secondTeamClassList;
}