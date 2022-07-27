
import 'dart:collection';
import 'package:flutter/cupertino.dart';
import '../model/founders_reviews_comment.dart';


class FoundersReviewsCommentNotifier with ChangeNotifier {
  List<FoundersReviewsComment> _foundersReviewsCommentList = <FoundersReviewsComment>[];
  late FoundersReviewsComment _currentFoundersReviewsComment;

  UnmodifiableListView<FoundersReviewsComment> get foundersReviewsCommentList => UnmodifiableListView(_foundersReviewsCommentList);

  FoundersReviewsComment get currentFoundersReviewsComment => _currentFoundersReviewsComment;

  set foundersReviewsCommentList(List<FoundersReviewsComment> foundersReviewsCommentList) {
    _foundersReviewsCommentList = foundersReviewsCommentList;
    notifyListeners();
  }

  set currentFoundersReviewsComment(FoundersReviewsComment foundersReviewsComment) {
    _currentFoundersReviewsComment = foundersReviewsComment;
    notifyListeners();
  }

}