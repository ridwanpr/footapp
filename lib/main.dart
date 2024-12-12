import 'package:flutter/material.dart';
import 'package:footapp/screen/tabs.dart';
import 'package:footapp/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const Tabs(),
    );
  }
}
