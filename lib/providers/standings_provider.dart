import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footapp/services/standings_service.dart';
import 'package:footapp/models/standings_model.dart';

final standingsProvider =
    FutureProvider.family<StandingsResponse, String>((ref, competitionCode) {
  return StandingsService().fetchStandingsByCompetitionCode(competitionCode);
});
