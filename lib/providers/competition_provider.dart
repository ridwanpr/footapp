import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footapp/models/competition_model.dart';
import 'package:footapp/services/competition_service.dart';

final competitionServiceProvider = Provider<CompetitionService>((ref) {
  return CompetitionService();
});

final competitionsProvider = FutureProvider<CompetitionsResponse>((ref) async {
  final service = ref.watch(competitionServiceProvider);
  return service.fetchCompetitions();
});
