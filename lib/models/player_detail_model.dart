class PlayerDetailModel {
  final int id;
  final String name;
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String nationality;
  final String section;
  final String position;
  final int? shirtNumber; // Make nullable
  final String teamName;
  final String teamLogo;
  final String teamWebsite;
  final String teamVenue;
  final int? teamFounded; // Make nullable and keep as int

  PlayerDetailModel({
    required this.id,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.nationality,
    required this.section,
    required this.position,
    this.shirtNumber,
    required this.teamName,
    required this.teamLogo,
    required this.teamWebsite,
    required this.teamVenue,
    this.teamFounded,
  });

  factory PlayerDetailModel.fromJson(Map<String, dynamic> json) {
    final currentTeam = json['currentTeam'] as Map<String, dynamic>?;

    return PlayerDetailModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      nationality: json['nationality'] ?? '',
      section: json['section'] ?? '',
      position: json['position'] ?? '',
      shirtNumber: json['shirtNumber'],
      teamName: currentTeam?['name'] ?? '',
      teamLogo: currentTeam?['crest'] ?? '',
      teamWebsite: currentTeam?['website'] ?? '',
      teamVenue: currentTeam?['venue'] ?? '',
      teamFounded: currentTeam?['founded'],
    );
  }
}
