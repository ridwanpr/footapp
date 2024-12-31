import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footapp/models/player_model.dart';
import 'package:footapp/services/player_service.dart';

final playerProvider =
    StateNotifierProvider<PlayerNotifier, AsyncValue<List<PlayerModel>>>((ref) {
  return PlayerNotifier(PlayerService());
});

class PlayerNotifier extends StateNotifier<AsyncValue<List<PlayerModel>>> {
  final PlayerService playerService;

  PlayerNotifier(this.playerService) : super(const AsyncValue.data([]));

  Future<void> searchPlayers(String query) async {
    if (query.isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }
    try {
      state = const AsyncValue.loading();
      final players = await playerService.getPlayers(query);
      state = AsyncValue.data(players);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
