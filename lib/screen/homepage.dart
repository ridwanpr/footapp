import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footapp/widgets/competition_card.dart';
import 'package:footapp/screen/competitions.dart';
import 'package:footapp/widgets/top_scorer_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  hintText: 'Search...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                ),
              ),
              const SizedBox(height: 20),
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
                    ),
                    const SizedBox(width: 10),
                    CompetitionCard(
                      title: 'La Liga',
                      imagePath: 'assets/laliga.png',
                      color: Colors.blue.shade700,
                    ),
                    const SizedBox(width: 10),
                    CompetitionCard(
                      title: 'Serie A',
                      imagePath: 'assets/seriea.png',
                      color: Colors.green.shade700,
                    ),
                    const SizedBox(width: 10),
                    CompetitionCard(
                      title: 'Bundesliga',
                      imagePath: 'assets/bundesliga.png',
                      color: Colors.purple.shade700,
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
                    TopScorerCard(
                      name: 'Lionel Messi',
                      team: 'Inter Miami',
                      goals: 15,
                      backgroundColor: Colors.blue.shade700,
                      competition: 'MLS',
                    ),
                    const SizedBox(width: 10),
                    TopScorerCard(
                      name: 'Cristiano Ronaldo',
                      team: 'Al Nassr',
                      goals: 14,
                      backgroundColor: Colors.red.shade700,
                      competition: 'Saudi Pro League',
                    ),
                    const SizedBox(width: 10),
                    TopScorerCard(
                      name: 'Kylian Mbappé',
                      team: 'Real Madrid',
                      goals: 13,
                      backgroundColor: Colors.purple.shade700,
                      competition: 'Ligue 1',
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
              const Card(
                child: ListTile(
                  leading: Icon(Icons.sports_soccer),
                  title: Text('Liverpool vs Arsenal'),
                  subtitle: Text('14 Dec, 2024 | 6:00 PM'),
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
