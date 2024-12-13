import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:footapp/models/teams_model.dart';

class SearchService {
  static const String _baseUrl = 'https://footapi.nori.my/api/search';

  Future<List<TeamsModel>> searchTeams(String teamName) async {
    final response = await http.get(Uri.parse('$_baseUrl?teamName=$teamName'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> teams = data['team'];
      return teams.map((team) => TeamsModel.fromJson(team)).toList();
    } else {
      throw Exception('Failed to load search results');
    }
  }
}
