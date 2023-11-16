import 'dart:collection';
import 'package:flutter/cupertino.dart';
import '../model/b_youtube.dart';

class YouTubeNotifier with ChangeNotifier {
  List<YouTube> _youTubeList = [];
  late YouTube _currentYouTube;

  UnmodifiableListView<YouTube> get youTubeList =>
      UnmodifiableListView(_youTubeList);

  YouTube get currentYouTube => _currentYouTube;

  set youTubeList(List<YouTube> youTubeList) {
    _youTubeList = youTubeList;
    notifyListeners();
  }

  set currentYouTube(YouTube youTube) {
    _currentYouTube = youTube;
    notifyListeners();
  }
}
