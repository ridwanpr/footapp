import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footapp/widgets/competition_card.dart';
import 'package:footapp/screen/competitions.dart';
import 'package:footapp/widgets/top_scorer_card.dart';
import 'package:footapp/providers/top_scorer_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plScorers = ref.watch(topScorerProvider('PL'));
    final bl1Scorers = ref.watch(topScorerProvider('BL1'));
    final pdScorers = ref.watch(topScorerProvider('PD'));

    return Scaffold(
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
              const Text(
                'Latest Matches',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Card(
                child: ListTile(
                  leading: Icon(Icons.sports_soccer),
                  title: Text('Manchester United vs Chelsea'),
                  subtitle: Text('13 Dec, 2024 | 5:00 PM'),
                ),
              ),
              const Card(
                child: ListTile(
                  leading: Icon(Icons.sports_soccer),
                  title: Text('Liverpool vs Arsenal'),
                  subtitle: Text('14 Dec, 2024 | 6:00 PM'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
