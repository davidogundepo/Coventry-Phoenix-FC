import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/b_youtube.dart';
import '../notifier/b_youtube_notifier.dart';

getYouTube(YouTubeNotifier youTubeNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('YouTube')
      .orderBy('id', descending: true)
      .limit(10)
      .get();

  List<YouTube> youTubeList = [];

  for (var document in snapshot.docs) {
    YouTube youTube =
    YouTube.fromMap(document.data() as Map<String, dynamic>);
    youTubeList.add(youTube);
  }

  youTubeList.sort((a, b) {
    // Handle null cases by placing nulls at the end
    if (a.id == null && b.id == null) {
      return 0;
    } else if (a.id == null) {
      return 1;
    } else if (b.id == null) {
      return -1;
    } else {
      // Use compareTo for non-null values
      return (int.tryParse(b.id!) ?? 0).compareTo(int.tryParse(a.id!) ?? 0);
    }
  });

  youTubeNotifier.youTubeList = youTubeList;
}
