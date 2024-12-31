import 'dart:convert';
import 'package:footapp/models/player_model.dart';
import 'package:http/http.dart' as http;

class PlayerService {
  final String baseUrl = 'https://footapi.nori.my/api';

  Future<List<PlayerModel>> getPlayers([String query = '']) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/player?playerName=$query'));

      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);
        final playersResponse = PlayersResponse.fromJson(decodedResponse);
        return playersResponse.players;
      } else {
        throw Exception(
            'Failed to load players. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching players: $e');
    }
  }
}
