import 'dart:async';
import 'dart:convert';
import 'package:footapp/models/player_detail_model.dart';
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

  Future<PlayerDetailModel> getPlayerDetails(int playerId) async {
    final url = 'http://footapi.nori.my/api/persons/$playerId';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return PlayerDetailModel.fromJson(json['person']);
      } else {
        throw Exception(
          'Failed to load player details.\n'
          'Status code: ${response.statusCode}\n'
          'Response body: ${response.body}',
        );
      }
    } catch (e, stackTrace) {
      throw Exception('Failed to fetch player details: $e\n$stackTrace');
    }
  }
}
