class PlayersTable {
  String? manOfTheMatch;
  int? manOfTheMatchCum;
  String? playerOfTheMonth;
  int? playerOfTheMonthCum;
  int? yellowCard;
  int? redCard;
  String? playerName;

  PlayersTable.fromMap(Map<String?, dynamic> data) {
    manOfTheMatch = data['man_of_the_match'];
    manOfTheMatchCum = data['man_of_the_match_cum'];
    playerOfTheMonth = data['player_of_the_month'];
    playerOfTheMonthCum = data['potm_cum'];
    yellowCard = data['yellow_card'];
    redCard = data['red_card'];
    playerName = data['player_name'];
  }
}
