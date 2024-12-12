import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footapp/models/match_model.dart';
import 'package:footapp/services/match_service.dart';

final matchProvider = FutureProvider<List<MatchModel>>((ref) async {
  final matchService = MatchService();
  return matchService.fetchMatches();
});
