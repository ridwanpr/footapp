import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footapp/providers/standings_provider.dart';
import 'package:footapp/providers/theme_provider.dart';

class Standings extends ConsumerWidget {
  final String competitionCode;

  const Standings({super.key, required this.competitionCode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final standingsResponse = ref.watch(standingsProvider(competitionCode));
    final themeMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('League Standings'),
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
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            standingsResponse.when(
              data: (data) {
                return Container(
                  margin: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 8.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'League Standings',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        const Divider(color: Colors.white30),
                        const SizedBox(height: 8.0),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: data.standings.length,
                          itemBuilder: (context, index) {
                            final standing = data.standings[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${standing.position}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(standing.teamCrest),
                                        radius: 20,
                                      ),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        standing.teamName.length > 20
                                            ? '${standing.teamName.substring(0, 20)}...'
                                            : standing.teamName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      '${standing.points} pts',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) =>
                  Center(child: Text('Error: $error')),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
