import 'dart:convert';
import 'package:footapp/models/standings_model.dart';
import 'package:http/http.dart' as http;

class StandingsService {
  static const String _baseUrl = 'http://footapi.nori.my';

  Future<StandingsResponse> fetchStandingsByCompetitionCode(
      String competitionCode) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/api/standings/$competitionCode'));

    if (response.statusCode == 200) {
      return StandingsResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load standings');
    }
  }
}
