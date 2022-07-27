import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/founders_reviews_comment.dart';
import '../notifier/founders_reviews_comment_notifier.dart';


getFoundersReviewsComment(FoundersReviewsCommentNotifier foundersReviewsCommentNotifier) async {

  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('FoundersMonthlyComments')
      .where('comment', whereNotIn: [""])
      .get();

  List<FoundersReviewsComment> foundersReviewsCommentList = [];

  for (var document in snapshot.docs) {
    FoundersReviewsComment foundersReviewsComment = FoundersReviewsComment.fromMap(document.data() as Map<String, dynamic>);
    foundersReviewsCommentList.add(foundersReviewsComment);
  }

  foundersReviewsCommentNotifier.foundersReviewsCommentList = foundersReviewsCommentList;

}
