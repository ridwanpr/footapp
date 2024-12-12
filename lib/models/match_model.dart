import 'dart:convert';

class MatchModel {
  final String homeTeam;
  final String awayTeam;
  final String homeTeamCrest;
  final String awayTeamCrest;
  final int homeScore;
  final int awayScore;
  final String date;
  final String status;

  MatchModel({
    required this.homeTeam,
    required this.awayTeam,
    required this.homeTeamCrest,
    required this.awayTeamCrest,
    required this.homeScore,
    required this.awayScore,
    required this.date,
    required this.status,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      homeTeam: json['homeTeam']?['name'] ?? '',
      awayTeam: json['awayTeam']?['name'] ?? '',
      homeTeamCrest: json['homeTeam']?['crest'] ?? '',
      awayTeamCrest: json['awayTeam']?['crest'] ?? '',
      homeScore: json['score']?['fullTime']?['home'] ?? 0,
      awayScore: json['score']?['fullTime']?['away'] ?? 0,
      date: json['utcDate'] ?? DateTime.now().toIso8601String(),
      status: json['status'] ?? '',
    );
  }
}

List<MatchModel> matchModelFromJson(String str) {
  try {
    final List<dynamic> jsonList = json.decode(str);
    return jsonList.map((x) => MatchModel.fromJson(x)).toList();
  } catch (e) {
    return [];
  }
}
