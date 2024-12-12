import 'dart:convert';
import 'package:footapp/models/team_detail_model.dart';
import 'package:http/http.dart' as http;

class TeamDetailService {
  final String baseUrl = 'https://footapi.nori.my/api/teams/';

  Future<TeamDetailModel> getTeamDetail(String teamId) async {
    final response = await http.get(Uri.parse('$baseUrl$teamId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return TeamDetailModel.fromJson(json);
    } else {
      throw Exception('Failed to load team details');
    }
  }
}
