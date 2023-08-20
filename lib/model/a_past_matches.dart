class PastMatches {
  String? assistsBy;
  String? goalsScorers;
  String? homeTeam;
  String? awayTeam;
  String? awayTeamScore;
  String? homeTeamScore;
  String? matchDate;
  String? homeTeamIcon;
  String? awayTeamIcon;
  dynamic id;

  PastMatches.fromMap(Map<String?, dynamic> data) {
    id = data['id'];
    assistsBy = data['assists_by'];
    goalsScorers = data['goalscorers'];
    homeTeam = data['home_team'];
    awayTeam = data['away_team'];
    awayTeamScore = data['at_score'];
    homeTeamScore = data['ht_score'];
    matchDate = data['match_date'];
    homeTeamIcon = data['home_team_icon'];
    awayTeamIcon = data['away_team_icon'];
  }
}
