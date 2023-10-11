class MatchDayBannerForLeague {
  String? league;
  dynamic id;

  MatchDayBannerForLeague.fromMap(Map<String?, dynamic> data) {
    id = data['id'];
    league = data['league'];
  }
}
