class PlayersTable {
  String? manOfTheMatch;
  int? manOfTheMatchCum;
  String? playerOfTheMonth;
  int? playerOfTheMonthCum;
  String? playerName;

  PlayersTable.fromMap(Map<String?, dynamic> data) {
    manOfTheMatch = data['man_of_the_match'];
    manOfTheMatchCum = data['man_of_the_match_cum'];
    playerOfTheMonth = data['player_of_the_month'];
    playerOfTheMonthCum = data['potm_cum'];
    playerName = data['player_name'];
  }
}
