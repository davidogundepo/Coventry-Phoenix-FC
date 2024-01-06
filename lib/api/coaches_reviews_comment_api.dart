import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../model/coaches_reviews_comment.dart';
import '../notifier/coaches_reviews_comment_notifier.dart';

getCoachesReviewsComment(
    CoachesReviewsCommentNotifier coachesReviewsCommentNotifier) async {
  DateTime currentDateTime = DateTime.now();
  String currentMonth = DateFormat('MM').format(currentDateTime);
  String currentYear = DateFormat('yyyy').format(currentDateTime);

  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('CoachesMonthlyComments')
      .where('month', isEqualTo: currentMonth)
      .where('year', isEqualTo: currentYear)
      // .where('comment', whereNotIn: [""])
      .get();

  List<CoachesReviewsComment> coachesReviewsCommentList = [];

  for (var document in snapshot.docs) {
    CoachesReviewsComment coachesReviewsComment =
    CoachesReviewsComment.fromMap(document.data() as Map<String, dynamic>);
    coachesReviewsCommentList.add(coachesReviewsComment);
  }

  coachesReviewsCommentNotifier.coachesReviewsCommentList =
      coachesReviewsCommentList;
}

//// For Previous Month Comparison

// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../model/coaches_reviews_comment.dart';
// import '../notifier/coaches_reviews_comment_notifier.dart';
//
// getCoachesReviewsComment(
//     CoachesReviewsCommentNotifier coachesReviewsCommentNotifier) async {
//   DateTime currentDateTime = DateTime.now();
//   DateTime lastMonthDateTime =
//   DateTime(currentDateTime.year, currentDateTime.month - 1);
//
//   String currentMonth = DateFormat('MM').format(currentDateTime);
//   String currentYear = DateFormat('yyyy').format(currentDateTime);
//   String lastMonth = DateFormat('MM').format(lastMonthDateTime);
//   String lastYear = DateFormat('yyyy').format(lastMonthDateTime);
//
//   QuerySnapshot snapshot = await FirebaseFirestore.instance
//       .collection('CoachesMonthlyComments')
//       .where('(year = $currentYear AND month = $currentMonth) OR (year = $lastYear AND month = $lastMonth)')
//       .where('comment', whereNotIn: [""])
//       .get();
//
//   List<CoachesReviewsComment> coachesReviewsCommentList = [];
//
//   for (var document in snapshot.docs) {
//     CoachesReviewsComment coachesReviewsComment =
//     CoachesReviewsComment.fromMap(document.data() as Map<String, dynamic>);
//     coachesReviewsCommentList.add(coachesReviewsComment);
//   }
//
//   coachesReviewsCommentNotifier.coachesReviewsCommentList =
//       coachesReviewsCommentList;
// }
