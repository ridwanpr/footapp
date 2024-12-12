class TeamsModel {
  final String id;
  final String name;
  final String shortname;
  final String crest;
  final String address;
  final int? founded;

  TeamsModel({
    required this.id,
    required this.name,
    required this.shortname,
    required this.crest,
    required this.address,
    this.founded,
  });

  factory TeamsModel.fromJson(Map<String, dynamic> json) {
    return TeamsModel(
      id: json['id'].toString(),
      name: json['name'],
      shortname: json['shortName'],
      crest: json['crest'],
      address: json['address'],
      founded: json['founded'],
    );
  }
}

class TeamsResponse {
  final List<TeamsModel> teams;

  TeamsResponse({required this.teams});

  factory TeamsResponse.fromJson(Map<String, dynamic> json) {
    return TeamsResponse(
      teams: (json['teams'] as List)
          .map((team) => TeamsModel.fromJson(team))
          .toList(),
    );
  }
}
