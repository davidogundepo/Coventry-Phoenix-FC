class CoachesReviewsComment {

  String? id;
  String? name;
  String? image;
  String? date;
  String? comment;

  CoachesReviewsComment.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    image = data['image'];
    date = data['date'];
    comment = data['comment'];
  }

}