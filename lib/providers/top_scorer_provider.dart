import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footapp/services/top_scorer_service.dart';
import 'package:footapp/models/top_scorer.dart';

final topScorerProvider = FutureProvider.family<List<TopScorer>, String>((ref, competitionCode) async {
  final topScorerService = TopScorerService();
  // final season = DateTime.now().year;
  const season = 2024;
  return await topScorerService.fetchTopScorers(competitionCode, season);
});
