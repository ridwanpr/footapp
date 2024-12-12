import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footapp/screen/homepage.dart';
import 'package:footapp/screen/favorites.dart';
import 'package:footapp/providers/theme_provider.dart';

class Tabs extends ConsumerStatefulWidget {
  const Tabs({super.key});

  @override
  TabsState createState() => TabsState();
}

class TabsState extends ConsumerState<Tabs> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const HomePage();
    var activePageTitle = 'Home';

    if (_selectedPageIndex == 1) {
      activePage = const Favorites();
      activePageTitle = 'Favorites';
    }

    final themeMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
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
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
