
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/achievements.dart';
import '../notifier/achievement_images_notifier.dart';

getAchievements(AchievementsNotifier achievementsNotifier) async{
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('AchievementImages').get();

  List<Achievements> achievementsList = [];

  for (var document in snapshot.docs) {
    Achievements achievements = Achievements.fromMap(document.data() as Map<String, dynamic>);
    achievementsList.add(achievements);
  }

  achievementsNotifier.achievementsList = achievementsList;
}