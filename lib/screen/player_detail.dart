import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footapp/providers/player_provider.dart';

class PlayerDetailScreen extends ConsumerWidget {
  final int playerId;
  const PlayerDetailScreen({super.key, required this.playerId});

  Widget _buildTeamLogo(String url) {
    return Image.network(
      url,
      width: 100,
      height: 100,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(
          Icons.sports_soccer,
          size: 100,
        );
      },
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 24),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerDetailAsync = ref.watch(playerDetailProvider(playerId));

    return Scaffold(
      body: playerDetailAsync.when(
        data: (player) => CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(player.name),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(color: Colors.black45),
                    Center(child: _buildTeamLogo(player.teamLogo)),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow(Icons.sports_soccer, 'Position',
                                player.position),
                            const Divider(height: 24),
                            _buildInfoRow(Icons.cake, 'Date of Birth',
                                player.dateOfBirth),
                            const Divider(height: 24),
                            _buildInfoRow(
                                Icons.flag, 'Nationality', player.nationality),
                            const Divider(height: 24),
                            _buildInfoRow(Icons.numbers, 'Shirt Number',
                                player.shirtNumber?.toString() ?? 'N/A'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Team Information',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow(
                                Icons.people, 'Team', player.teamName),
                            const Divider(height: 24),
                            _buildInfoRow(Icons.calendar_today, 'Founded',
                                player.teamFounded?.toString() ?? 'N/A'),
                            const Divider(height: 24),
                            _buildInfoRow(
                                Icons.stadium, 'Venue', player.teamVenue),
                            const Divider(height: 24),
                            _buildInfoRow(
                                Icons.language, 'Website', player.teamWebsite),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 60),
                const SizedBox(height: 16),
                Text(
                  'Failed to load player details',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
