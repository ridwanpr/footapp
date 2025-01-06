class PlayerModel {
  final int? id;
  final int? teamId;
  final String? name;
  final String? position;
  final String? dateOfBirth;
  final String? nationality;

  PlayerModel({
    this.id,
    this.teamId,
    this.name,
    this.position,
    this.dateOfBirth,
    this.nationality,
  });

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      id: json['id'] as int?,
      teamId: json['team_id'] as int?,
      name: json['name'] as String?,
      position: json['position'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      nationality: json['nationality'] as String?,
    );
  }
}

class PlayersResponse {
  final List<PlayerModel> players;

  PlayersResponse({required this.players});

  factory PlayersResponse.fromJson(Map<String, dynamic> json) {
    if (json['player'] == null) {
      throw Exception("The key 'player' is null or missing in the response.");
    }

    return PlayersResponse(
      players: (json['player'] as List? ?? <dynamic>[])
          .map((player) => PlayerModel.fromJson(player as Map<String, dynamic>))
          .toList(),
    );
  }
}

