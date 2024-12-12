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
                    backgroundImage: NetworkImage(team.crest.isNotEmpty
                        ? team.crest
                        : 'https://dummyimage.com/qvga'),
                    radius: 50.0,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    team.name.isNotEmpty
                        ? team.name
                        : 'Team name not available',
                    style: const TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    team.founded != 0
                        ? 'Founded: ${team.founded}'
                        : 'Founded date not available',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    team.venue.isNotEmpty
                        ? 'Venue: ${team.venue}'
                        : 'Venue not available',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    team.clubColors.isNotEmpty
                        ? 'Club Colors: ${team.clubColors}'
                        : 'Club Colors not available',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    team.area.isNotEmpty
                        ? 'Area: ${team.area}'
                        : 'Area not available',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: team.website.isNotEmpty
                        ? () {
                            _launchURL(team.website);
                          }
                        : null, // Disable button if no website
                    child: const Text('Visit Official Website'),
                  ),
                  const SizedBox(height: 16.0),
                  const Divider(),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Squadlist',
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                  ),
                  team.squad.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: team.squad.length,
                          itemBuilder: (context, index) {
                            final player = team.squad[index];
                            return ListTile(
                              title: Text(player.name.isNotEmpty
                                  ? player.name
                                  : 'Player name not available'),
                              subtitle: Text(player.position.isNotEmpty
                                  ? player.position
                                  : 'Position not available'),
                            );
                          },
                        )
                      : const Text('No players available'),
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
