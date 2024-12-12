import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footapp/providers/teams_provider.dart';
import 'package:footapp/screen/standings.dart';
import 'package:footapp/screen/team_detail.dart';

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
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Standings(competitionCode: competitionCode),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.bar_chart_sharp,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Go to League Standings',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey[900],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: data.teams.length,
                  itemBuilder: (context, index) {
                    final team = data.teams[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: team.crest.isNotEmpty
                            ? NetworkImage(team.crest)
                            : null,
                        child: team.crest.isEmpty
                            ? const Icon(Icons.sports_soccer)
                            : null,
                      ),
                      title: Text(team.name),
                      subtitle:
                          Text('Founded: ${team.founded?.toString() ?? ""}'),
                      onTap: () {
                        // Navigate to Team Detail Screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TeamDetails(teamId: team.id),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
