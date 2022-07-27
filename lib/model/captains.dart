class Captains {
  String? teamCaptaining;
  String? image;
  String? imageTwo;
  String? name;
  String? id;

  Captains.fromMap(Map<String?, dynamic> data) {
    id = data['id'];
    image = data['image'];
    imageTwo = data['image_two'];
    teamCaptaining = data['team_captaining'];
    name = data['name'];
  }

}