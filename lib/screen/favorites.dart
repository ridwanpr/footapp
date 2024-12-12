import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> favoriteItems = ['Team A', 'Team B', 'Team C'];

    return Scaffold(
      body: favoriteItems.isEmpty
          ? const Center(
              child: Text('No favorites added yet!'),
            )
          : ListView.builder(
              itemCount: favoriteItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(favoriteItems[index]),
                  leading: const Icon(Icons.sports_soccer),
                );
              },
            ),
    );
  }
}
