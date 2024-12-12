class TeamDetailModel {
  final String id;
  final String name;
  final String shortName;
  final String crest;
  final String address;
  final String website;
  final int founded;
  final String clubColors;
  final String venue;
  final String area;
  final List<Competition> runningCompetitions;
  final Coach coach;
  final List<Player> squad;

  TeamDetailModel({
    required this.id,
    required this.name,
    required this.shortName,
    required this.crest,
    required this.address,
    required this.website,
    required this.founded,
    required this.clubColors,
    required this.venue,
    required this.area,
    required this.runningCompetitions,
    required this.coach,
    required this.squad,
  });

  factory TeamDetailModel.fromJson(Map<String, dynamic> json) {
    return TeamDetailModel(
      id: json['team']['id']?.toString() ??
          '', // Default empty string if null
      name: json['team']['name'] ?? '',
      shortName: json['team']['shortName'] ?? '',
      crest: json['team']['crest'] ?? '',
      address: json['team']['address'] ?? '',
      website: json['team']['website'] ?? '',
      founded: json['team']['founded'] ?? 0,
      clubColors: json['team']['clubColors'] ?? '',
      venue: json['team']['venue'] ?? '',
      area: json['team']['area']?['name'] ?? '',
      runningCompetitions: (json['team']['runningCompetitions'] as List?)
              ?.map((e) => Competition.fromJson(e))
              .toList() ??
          [], // Empty list if null
      coach: Coach.fromJson(json['team']['coach'] ?? {}),
      squad: (json['team']['squad'] as List?)
              ?.map((e) => Player.fromJson(e))
              .toList() ??
          [], // Empty list if null
    );
  }
}

class Competition {
  final String name;
  final String code;
  final String emblem;

  Competition({
    required this.name,
    required this.code,
    required this.emblem,
  });

  factory Competition.fromJson(Map<String, dynamic> json) {
    return Competition(
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      emblem: json['emblem'] ?? '',
    );
  }
}

class Coach {
  final String name;
  final String nationality;

  Coach({
    required this.name,
    required this.nationality,
  });

  factory Coach.fromJson(Map<String, dynamic> json) {
    return Coach(
      name: json['name'] ?? '',
      nationality: json['nationality'] ?? '',
    );
  }
}

class Player {
  final String name;
  final String position;

  Player({
    required this.name,
    required this.position,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      name: json['name'] ?? '',
      position: json['position'] ?? '',
    );
  }
}
