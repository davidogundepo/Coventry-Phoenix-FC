class MatchDayBannerForClubOpp {
  String? clubIcon;
  String? clubName;
  dynamic id;

  MatchDayBannerForClubOpp.fromMap(Map<String?, dynamic> data) {
    id = data['id'];
    clubName = data['club_name'];
    clubIcon = data['club_icon'];
  }
}
