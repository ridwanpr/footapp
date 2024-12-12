class TopScorer {
  final String name;
  final String team;
  final int goals;
  final String imageUrl;
  final String competition;

  TopScorer({
    required this.name,
    required this.team,
    required this.goals,
    required this.imageUrl,
    required this.competition,
  });

  factory TopScorer.fromJson(Map<String, dynamic> json) {
    return TopScorer(
      name: json['player']['name'] ?? '',
      team: json['team']['name'] ?? '',
      goals: json['goals'] ?? 0,
      imageUrl: json['team']['crest'] ?? '',
      competition: json['team']['name'] ?? '',
    );
  }
}
