import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footapp/providers/teams_provider.dart';

class Teams extends ConsumerWidget {
  final String competitionCode;

  const Teams({super.key, required this.competitionCode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamsResponse = ref.watch(teamsProvider(competitionCode));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Team List'),
      ),
      body: teamsResponse.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.teams.length,
            itemBuilder: (context, index) {
              final team = data.teams[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                      team.crest.isNotEmpty ? NetworkImage(team.crest) : null,
                  child: team.crest.isEmpty
                      ? const Icon(Icons.sports_soccer)
                      : null,
                ),
                title: Text(team.name),
                subtitle: Text(
                  'Founded: ${team.founded?.toString() ?? ""}',
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
