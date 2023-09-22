import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/b_youtube.dart';
import '../notifier/b_youtube_notifier.dart';

getYoutube(YoutubeNotifier youtubeNotifier) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('Youtube')
      .orderBy('id', descending: true)
      .get();

  List<Youtube> youtubeList = [];

  for (var document in snapshot.docs) {
    Youtube youtube =
    Youtube.fromMap(document.data() as Map<String, dynamic>);
    youtubeList.add(youtube);
  }

  youtubeNotifier.youtubeList = youtubeList;
}
