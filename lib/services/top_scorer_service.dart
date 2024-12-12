import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:footapp/models/top_scorer.dart';

class TopScorerService {
  final String baseUrl = 'http://footapi.nori.my/api/topscorer/';

  Future<List<TopScorer>> fetchTopScorers(
      String competitionCode, int season) async {
    final response = await http.get(
      Uri.parse('$baseUrl$competitionCode?season=$season'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final scorers = data['matches']['scorers'] as List;

      return scorers.map((json) => TopScorer.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load top scorers');
    }
  }
}
