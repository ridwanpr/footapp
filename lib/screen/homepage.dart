import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footapp/models/match_model.dart';
import 'package:footapp/providers/match_provider.dart';
import 'package:footapp/providers/theme_provider.dart';
import 'package:footapp/screen/search_result.dart';
import 'package:footapp/widgets/competition_card.dart';
import 'package:footapp/screen/competitions.dart';
import 'package:footapp/widgets/top_scorer_card.dart';
import 'package:footapp/providers/top_scorer_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  String _formatDate(String dateString) {
    final DateTime parsedDate = DateTime.parse(dateString);
    return '${parsedDate.day} ${_getMonthName(parsedDate.month)}, ${parsedDate.year}';
  }

  String _formatScore(MatchModel match) {
    if (match.homeScore > 0 || match.awayScore > 0) {
      return '${match.homeScore} - ${match.awayScore}';
    }
    return _formatTime(DateTime.parse(match.date));
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} PM';
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plScorers = ref.watch(topScorerProvider('PL'));
    final bl1Scorers = ref.watch(topScorerProvider('BL1'));
    final pdScorers = ref.watch(topScorerProvider('PD'));

    final themeMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search teams',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                ),
                onSubmitted: (query) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchResultsScreen(query: query),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),
              // Competitions Section
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Competitions(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Competitions',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.grey.shade600,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 110,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    CompetitionCard(
                      title: 'EPL',
                      imagePath: 'assets/epl.png',
                      color: Colors.red.shade700,
                      competitionCode: 'PL',
                    ),
                    const SizedBox(width: 10),
                    CompetitionCard(
                      title: 'La Liga',
                      imagePath: 'assets/laliga.png',
                      color: Colors.blue.shade700,
                      competitionCode: 'PD',
                    ),
                    const SizedBox(width: 10),
                    CompetitionCard(
                      title: 'Serie A',
                      imagePath: 'assets/seriea.png',
                      color: Colors.green.shade700,
                      competitionCode: 'SA',
                    ),
                    const SizedBox(width: 10),
                    CompetitionCard(
                      title: 'Bundesliga',
                      imagePath: 'assets/bundesliga.png',
                      color: Colors.purple.shade700,
                      competitionCode: 'BL1',
                    ),
                  ],
                ),
              ),
              // Top Scorers Section
              const SizedBox(height: 20),
              Text(
                'Top Scorers',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    // PL (Premier League)
                    plScorers.when(
                      data: (scorers) {
                        final topScorer =
                            scorers.isNotEmpty ? scorers.first : null;
                        return topScorer != null
                            ? TopScorerCard(
                                name: topScorer.name,
                                team: topScorer.team,
                                goals: topScorer.goals,
                                backgroundColor: Colors.red.shade700,
                                competition: 'Premier League',
                              )
                            : const SizedBox.shrink();
                      },
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      error: (error, stack) => throw error,
                    ),
                    const SizedBox(width: 10),

                    // BL1 (Bundesliga)
                    bl1Scorers.when(
                      data: (scorers) {
                        final topScorer =
                            scorers.isNotEmpty ? scorers.first : null;
                        return topScorer != null
                            ? TopScorerCard(
                                name: topScorer.name,
                                team: topScorer.team,
                                goals: topScorer.goals,
                                backgroundColor: Colors.blue.shade700,
                                competition: 'Bundesliga',
                              )
                            : const SizedBox.shrink();
                      },
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      error: (error, stack) => throw error,
                    ),
                    const SizedBox(width: 10),
                    // PD (La Liga)
                    pdScorers.when(
                      data: (scorers) {
                        final topScorer =
                            scorers.isNotEmpty ? scorers.first : null;
                        return topScorer != null
                            ? TopScorerCard(
                                name: topScorer.name,
                                team: topScorer.team,
                                goals: topScorer.goals,
                                backgroundColor: Colors.green.shade700,
                                competition: 'La Liga',
                              )
                            : const SizedBox.shrink();
                      },
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      error: (error, stack) => throw error,
                    ),
                  ],
                ),
              ),
              // Latest Matches Section
              const SizedBox(height: 20),
              Text(
                'Latest Matches',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 10),
              Consumer(
                builder: (context, ref, child) {
                  final matchesAsync = ref.watch(matchProvider);

                  return matchesAsync.when(
                    data: (matches) {
                      return Column(
                        children: matches.map((match) {
                          return Card(
                            child: ListTile(
                              leading: const Icon(Icons.sports_soccer),
                              title: Text(
                                  '${match.homeTeam} vs ${match.awayTeam}'),
                              subtitle: Text(
                                '${_formatDate(match.date)} | ${_formatScore(match)}',
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (error, stack) => Center(
                      child: Text('Error loading matches: $error'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
