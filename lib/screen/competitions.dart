import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footapp/models/competition_model.dart';
import 'package:footapp/providers/competition_provider.dart';

class Competitions extends ConsumerWidget {
  const Competitions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<CompetitionsResponse> competitions =
        ref.watch(competitionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Competitions'),
      ),
      body: competitions.when(
        data: (data) {
          if (data.competitions.isEmpty) {
            return const Center(child: Text('No competitions found'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: data.competitions.length,
            itemBuilder: (context, index) {
              final competition = data.competitions[index];
              final emblem = competition.emblem;
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blueGrey.shade900.withOpacity(0.7),
                        Colors.blueGrey.shade700.withOpacity(0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: const RadialGradient(
                          colors: [
                            Colors.blueAccent,
                            Color.fromARGB(255, 9, 58, 99)
                          ],
                          center: Alignment.center,
                          radius: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: emblem != null && emblem.isNotEmpty
                            ? Image.network(
                                emblem,
                                width: 50,
                                height: 50,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.sports_soccer,
                                        color: Colors.white),
                              )
                            : const Icon(Icons.sports_soccer,
                                size: 50, color: Colors.white),
                      ),
                    ),
                    title: Text(
                      competition.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    subtitle: Text(
                      '${competition.startDate} - ${competition.endDate}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white70,
                          ),
                    ),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 60),
              const SizedBox(height: 16),
              Text(
                'Failed to load competitions',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
