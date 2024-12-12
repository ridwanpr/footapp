import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footapp/models/team_detail_model.dart';
import 'package:footapp/services/team_detail_service.dart';

final teamDetailProvider =
    FutureProvider.family<TeamDetailModel, String>((ref, teamId) async {
  final teamDetailService = TeamDetailService();
  return await teamDetailService.getTeamDetail(teamId);
});
