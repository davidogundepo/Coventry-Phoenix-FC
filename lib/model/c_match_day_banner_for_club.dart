class MatchDayBannerForClub {
  String? clubIcon;
  String? clubName;
  dynamic id;

  MatchDayBannerForClub.fromMap(Map<String?, dynamic> data) {
    id = data['id'];
    clubName = data['club_name'];
    clubIcon = data['club_icon'];
  }
}
