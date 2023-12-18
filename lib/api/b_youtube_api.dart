import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/b_youtube.dart';
import '../notifier/b_youtube_notifier.dart';

getYouTube(YouTubeNotifier youTubeNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('YouTube')
      .orderBy('id', descending: true)  // Change to ascending order
      .limit(10)
      .get();

  List<YouTube> youTubeList = [];

  for (var document in snapshot.docs) {
    YouTube youTube =
    YouTube.fromMap(document.data() as Map<String, dynamic>);
    youTubeList.add(youTube);
  }

  youTubeNotifier.youTubeList = youTubeList;
}
