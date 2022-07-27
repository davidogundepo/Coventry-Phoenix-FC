

class TrainingsAndGamesReels {

  String? id;
  String? image;

  TrainingsAndGamesReels.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    image = data['image'];
  }

}