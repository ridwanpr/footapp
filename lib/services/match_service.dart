import 'dart:convert';
import 'package:footapp/models/match_model.dart';
import 'package:http/http.dart' as http;

class MatchService {
  final String url = 'https://footapi.nori.my/api/matches/PL';

  Future<List<MatchModel>> fetchMatches() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<MatchModel> matches =
            matchModelFromJson(json.encode(data['matches']))
                .where((match) => match.status == 'FINISHED')
                .toList();
        matches.sort(
            (a, b) => DateTime.parse(b.date).compareTo(DateTime.parse(a.date)));
        return matches.take(4).toList();
      } else {
        throw Exception('Failed to load matches');
      }
    } catch (e) {
      rethrow;
    }
  }
}
