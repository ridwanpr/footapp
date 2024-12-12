import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footapp/models/teams_model.dart';
import 'package:footapp/services/teams_service.dart';

final teamsServiceProvider = Provider<TeamsService>((ref) {
  return TeamsService();
});

final teamsProvider =
    FutureProvider.family<TeamsResponse, String>((ref, competitionCode) async {
  final service = ref.watch(teamsServiceProvider);
  return service.fetchTeamsByCompetitionCode(competitionCode);
});
