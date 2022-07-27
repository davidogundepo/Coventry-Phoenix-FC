
import 'dart:collection';
import 'package:flutter/cupertino.dart';
import '../model/coaches_reviews_comment.dart';


class CoachesReviewsCommentNotifier with ChangeNotifier {
  List<CoachesReviewsComment> _coachesReviewsCommentList = <CoachesReviewsComment>[];
  late CoachesReviewsComment _currentCoachesReviewsComment;

  UnmodifiableListView<CoachesReviewsComment> get coachesReviewsCommentList => UnmodifiableListView(_coachesReviewsCommentList);

  CoachesReviewsComment get currentCoachesReviewsComment => _currentCoachesReviewsComment;

  set coachesReviewsCommentList(List<CoachesReviewsComment> coachesReviewsCommentList) {
    _coachesReviewsCommentList = coachesReviewsCommentList;
    notifyListeners();
  }

  set currentCoachesReviewsComment(CoachesReviewsComment coachesReviewsComment) {
    _currentCoachesReviewsComment = coachesReviewsComment;
    notifyListeners();
  }

}