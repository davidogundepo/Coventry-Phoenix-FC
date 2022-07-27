import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/trainings_and_games_reels.dart';
import '../notifier/trainings_games_reels_notifier.dart';


getTrainingsAndGamesReels(TrainingsAndGamesReelsNotifier trainingsAndGamesReelsNotifier) async {

  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('TrainingsAndGamesReels').get();

  List<TrainingsAndGamesReels> trainingsAndGamesReelsList = [];

  for (var document in snapshot.docs) {
    TrainingsAndGamesReels trainingsAndGamesReels = TrainingsAndGamesReels.fromMap(document.data() as Map<String, dynamic>);
    trainingsAndGamesReelsList.add(trainingsAndGamesReels);
  }

  trainingsAndGamesReelsNotifier.trainingsAndGamesReelsList = trainingsAndGamesReelsList;

}
