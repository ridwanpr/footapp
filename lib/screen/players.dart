import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footapp/providers/player_provider.dart';
import 'package:footapp/screen/player_detail.dart';

class PlayerScreen extends ConsumerWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playersAsyncValue = ref.watch(playerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Players'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              onChanged: (query) =>
                  ref.read(playerProvider.notifier).searchPlayers(query),
              decoration: InputDecoration(
                hintText: 'Search for players...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
              ),
            ),
            const SizedBox(height: 16.0),

            // Player List View
            Expanded(
              child: playersAsyncValue.when(
                data: (players) {
                  return ListView.builder(
                    itemCount: players.length,
                    itemBuilder: (context, index) {
                      final player = players[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12.0),
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16.0),
                          title: Text(
                            player.name!,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Position: ${player.position}',
                                style: const TextStyle(fontSize: 14.0),
                              ),
                              Text(
                                'DOB: ${player.dateOfBirth}',
                                style: const TextStyle(fontSize: 14.0),
                              ),
                              Text(
                                'Nationality: ${player.nationality}',
                                style: const TextStyle(fontSize: 14.0),
                              ),
                            ],
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16.0,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PlayerDetailScreen(playerId: player.id!),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error: $error')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
