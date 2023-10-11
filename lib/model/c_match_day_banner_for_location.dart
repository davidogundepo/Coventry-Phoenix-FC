class MatchDayBannerForLocation {
  String? location;
  String? postCode;
  dynamic id;

  MatchDayBannerForLocation.fromMap(Map<String?, dynamic> data) {
    id = data['id'];
    location = data['location'];
    postCode = data['post_code'];
  }
}
