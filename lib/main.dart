import 'package:flutter/material.dart';
import 'package:workout_analyzer/pages/schede_page.dart';
import 'package:workout_analyzer/themes/dark_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout Analyzer',
      theme: darkTheme,
      home: const SchedePage(),
    );
  }
}

