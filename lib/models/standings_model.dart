class StandingsModel {
  final int position;
  final String teamName;
  final String teamShortName;
  final String teamCrest;
  final int playedGames;
  final int won;
  final int draw;
  final int lost;
  final int points;
  final int goalsFor;
  final int goalsAgainst;
  final int goalDifference;

  StandingsModel({
    required this.position,
    required this.teamName,
    required this.teamShortName,
    required this.teamCrest,
    required this.playedGames,
    required this.won,
    required this.draw,
    required this.lost,
    required this.points,
    required this.goalsFor,
    required this.goalsAgainst,
    required this.goalDifference,
  });

  factory StandingsModel.fromJson(Map<String, dynamic> json) {
    return StandingsModel(
      position: json['position'],
      teamName: json['team']['name'],
      teamShortName: json['team']['shortName'],
      teamCrest: json['team']['crest'],
      playedGames: json['playedGames'],
      won: json['won'],
      draw: json['draw'],
      lost: json['lost'],
      points: json['points'],
      goalsFor: json['goalsFor'],
      goalsAgainst: json['goalsAgainst'],
      goalDifference: json['goalDifference'],
    );
  }
}

class StandingsResponse {
  final List<StandingsModel> standings;

  StandingsResponse({required this.standings});

  factory StandingsResponse.fromJson(Map<String, dynamic> json) {
    return StandingsResponse(
      standings: (json['standings'][0]['table'] as List)
          .map((item) => StandingsModel.fromJson(item))
          .toList(),
    );
  }
}
