import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/third_team_class.dart';
import '../notifier/third_team_class_notifier.dart';

getThirdTeamClass(ThirdTeamClassNotifier thirdTeamClassNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('ThirdTeamClassPlayers')
      .orderBy('name')
      .get();

  List<ThirdTeamClass> thirdTeamClassList = [];

  for (var document in snapshot.docs) {
    ThirdTeamClass thirdTeamClass = ThirdTeamClass.fromMap(document.data() as Map<String, dynamic>);
    thirdTeamClassList.add(thirdTeamClass);
  }

  thirdTeamClassNotifier.thirdTeamClassList = thirdTeamClassList;
}
