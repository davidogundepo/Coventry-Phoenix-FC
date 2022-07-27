import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/coaches_reviews_comment.dart';
import '../notifier/coaches_reviews_comment_notifier.dart';


getCoachesReviewsComment(CoachesReviewsCommentNotifier coachesReviewsCommentNotifier) async {

  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('CoachesMonthlyComments')
      .where('comment', whereNotIn: [""])
      .get();

  List<CoachesReviewsComment> coachesReviewsCommentList = [];

  for (var document in snapshot.docs) {
    CoachesReviewsComment coachesReviewsComment = CoachesReviewsComment.fromMap(document.data() as Map<String, dynamic>);
    coachesReviewsCommentList.add(coachesReviewsComment);
  }

  coachesReviewsCommentNotifier.coachesReviewsCommentList = coachesReviewsCommentList;

}
