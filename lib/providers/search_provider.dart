import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footapp/models/teams_model.dart';
import 'package:footapp/services/search_service.dart';

final searchProvider =
    StateNotifierProvider<SearchNotifier, AsyncValue<List<TeamsModel>>>((ref) {
  return SearchNotifier(SearchService());
});

class SearchNotifier extends StateNotifier<AsyncValue<List<TeamsModel>>> {
  final SearchService _searchService;

  SearchNotifier(this._searchService) : super(const AsyncValue.loading());

  Future<void> searchTeams(String teamName) async {
    state = const AsyncValue.loading();
    try {
      final results = await _searchService.searchTeams(teamName);
      state = AsyncValue.data(results);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
