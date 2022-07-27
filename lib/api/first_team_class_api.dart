import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/first_team_class.dart';
import '../notifier/first_team_class_notifier.dart';

getFirstTeamClass(FirstTeamClassNotifier firstTeamClassNotifier) async {

  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('FirstTeamClassPlayers')
      .orderBy('name')
      .get();

  List<FirstTeamClass> firstTeamClassList = [];

  for (var document in snapshot.docs) {
    FirstTeamClass firstTeamClass = FirstTeamClass.fromMap(document.data() as Map<String, dynamic>);
    firstTeamClassList.add(firstTeamClass);
  }

  firstTeamClassNotifier.firstTeamClassList = firstTeamClassList;
}
