import 'package:flutter/material.dart';

import 'app/quiz_controller.dart';
import 'app/quiz_scope.dart';
import 'app/theme.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  late final QuizController _controller;

  @override
  void initState() {
    super.initState();
    _controller = QuizController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _controller.themeMode,
      builder: (context, themeMode, _) {
        return QuizScope(
          controller: _controller,
          child: MaterialApp(
            title: 'Ruang Kuis',
            debugShowCheckedModeBanner: false,
            theme: QuizTheme.light,
            darkTheme: QuizTheme.dark,
            themeMode: themeMode,
            home: const HomeScreen(),
          ),
        );
      },
    );
  }
}
