import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

final themeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.system;
});

void toggleTheme(WidgetRef ref) {
  final currentTheme = ref.read(themeProvider.notifier).state;
  final newTheme = currentTheme == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  ref.read(themeProvider.notifier).state = newTheme;
}
