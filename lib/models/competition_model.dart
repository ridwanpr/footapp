class CompetitionModel {
  final int id;
  final String name;
  final String code;
  final String type;
  final String? emblem;
  final String? startDate;
  final String? endDate;

  CompetitionModel({
    required this.id,
    required this.name,
    required this.code,
    required this.type,
    this.emblem,
    this.startDate,
    this.endDate,
  });

  factory CompetitionModel.fromJson(Map<String, dynamic> json) {
    return CompetitionModel(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      type: json['type'],
      emblem: json['emblem'],
      startDate: json['currentSeason']['startDate'],
      endDate: json['currentSeason']['endDate'],
    );
  }
}

class CompetitionsResponse {
  final List<CompetitionModel> competitions;

  CompetitionsResponse({required this.competitions});

  factory CompetitionsResponse.fromJson(Map<String, dynamic> json) {
    return CompetitionsResponse(
      competitions: (json['competitions'] as List)
          .map((competition) => CompetitionModel.fromJson(competition))
          .toList(),
    );
  }
}
