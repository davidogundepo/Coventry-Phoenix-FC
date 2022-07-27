
class Achievements {
  String? image;
  String? toastName;

  Achievements.fromMap(Map<String?, dynamic> data) {
    image = data['image'];
    toastName = data['toastname'];
  }
}