import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footapp/providers/player_provider.dart';
import 'package:footapp/providers/theme_provider.dart';

class PlayerScreen extends ConsumerWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playersAsyncValue = ref.watch(playerProvider);
    final themeMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Players'),
        actions: [
          IconButton(
            icon: Icon(
              themeMode == ThemeMode.dark
                  ? Icons.nightlight_round
                  : Icons.wb_sunny,
            ),
            onPressed: () {
              toggleTheme(ref);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) =>
                  ref.read(playerProvider.notifier).searchPlayers(query),
              decoration: InputDecoration(
                hintText: 'Search players',
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
                  if (players.isEmpty) {
                    return const Center(child: Text('No players found.'));
                  }

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
                            player.name,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                player.position,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                'DOB: ${player.dateOfBirth}',
                                style: const TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                              Text(
                                'Nationality: ${player.nationality}',
                                style: const TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16.0,
                          ),
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
