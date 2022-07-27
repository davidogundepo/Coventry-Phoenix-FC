
class ClubArial {
  String? image;
  String? toastName;

  ClubArial.fromMap(Map<String?, dynamic> data) {
    image = data['image'];
    toastName = data['toastname'];
  }
}