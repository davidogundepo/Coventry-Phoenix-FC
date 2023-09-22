import 'dart:collection';
import 'package:flutter/cupertino.dart';
import '../model/b_youtube.dart';

class YoutubeNotifier with ChangeNotifier {
  List<Youtube> _youtubeList = [];
  late Youtube _currentYoutube;

  UnmodifiableListView<Youtube> get youtubeList =>
      UnmodifiableListView(_youtubeList);

  Youtube get currentYoutube => _currentYoutube;

  set youtubeList(List<Youtube> youtubeList) {
    _youtubeList = youtubeList;
    notifyListeners();
  }

  set currentYoutube(Youtube youtube) {
    _currentYoutube = youtube;
    notifyListeners();
  }
}
