import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footapp/providers/team_detail_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamDetails extends ConsumerWidget {
  final String teamId;

  const TeamDetails({super.key, required this.teamId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamDetail = ref.watch(teamDetailProvider(teamId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Details'),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: teamDetail.when(
        data: (team) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(team.crest),
                    radius: 50.0,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    team.name,
                    style: const TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Founded: ${team.founded}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Venue: ${team.venue}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Club Colors: ${team.clubColors}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Area: ${team.area}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (team.website.isNotEmpty) {
                        _launchURL(team.website);
                      }
                    },
                    child: const Text('Visit Official Website'),
                  ),
                  const SizedBox(height: 16.0),
                  const Divider(),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Squad:',
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: team.squad.length,
                    itemBuilder: (context, index) {
                      final player = team.squad[index];
                      return ListTile(
                        title: Text(player.name),
                        subtitle: Text(player.position),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }

  void _launchURL(String url) {
    launchUrl(Uri.parse(url));
  }
}
