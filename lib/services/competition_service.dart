import 'dart:convert';
import 'package:footapp/models/competition_model.dart';
import 'package:http/http.dart' as http;

class CompetitionService {
  static const String _baseUrl = 'https://footapi.nori.my/';

  Future<CompetitionsResponse> fetchCompetitions() async {
    final response = await http.get(Uri.parse('${_baseUrl}api/competitions'));
    if (response.statusCode == 200) {
      return CompetitionsResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Failed to load competitions: ${response.statusCode}, ${response.body}');
    }
  }
}
