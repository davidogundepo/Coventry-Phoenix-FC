
class PlayersStatsAndInfo {

  String? id;
  String? playerName;
  dynamic goalsScored;
  dynamic assists;
  dynamic yellowCard;
  dynamic redCard;
  String? preferredFoot;
  String? playerPosition;
  dynamic matchesPlayed;
  dynamic playerValue;
  dynamic cleanSheetGk;
  dynamic goalsConcededGkDef;
  dynamic cumMOTMCount;
  String? menOfTheMatchesMOTM;
  String? playerOfTheMonth;
  dynamic age;
  String? nationality;
  String? image;

  PlayersStatsAndInfo.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    playerName = data['player_name'];
    goalsScored = data['goals_scored'];
    assists = data['assists'];
    yellowCard = data['yellow_card'];
    redCard = data['red_card'];
    preferredFoot = data['preferred_foot'];
    playerPosition = data['player_position'];
    matchesPlayed = data['matches_played'];
    playerValue = data['player_value'];
    cleanSheetGk = data['clean_sheets_gk'];
    goalsConcededGkDef = data['goals_conceded_gk_def'];
    cumMOTMCount = data['man_of_the_match_cum'];
    menOfTheMatchesMOTM = data['man_of_the_match'];
    playerOfTheMonth = data['player_of_the_month'];
    age = data['age'];
    nationality = data['nationality'];
    image = data['image'];
  }

}