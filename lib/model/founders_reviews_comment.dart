

class FoundersReviewsComment {

  String? id;
  String? name;
  String? image;
  String? date;
  String? comment;

  FoundersReviewsComment.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    image = data['image'];
    date = data['date'];
    comment = data['comment'];
  }

}