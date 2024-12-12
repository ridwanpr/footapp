import 'dart:convert';
import 'package:footapp/models/teams_model.dart';
import 'package:http/http.dart' as http;

class TeamsService {
  static const String _baseUrl = 'https://footapi.nori.my';

  Future<TeamsResponse> fetchTeamsByCompetitionCode(
      String competitionCode) async {
    final response = await http
        .get(Uri.parse('$_baseUrl/api/competitions/$competitionCode/teams'));

    return TeamsResponse.fromJson(json.decode(response.body));
  }
}
