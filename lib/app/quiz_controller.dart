import 'package:flutter/material.dart';

import '../data/quiz_data.dart';
import '../models/quiz_topic.dart';

class QuizController extends ChangeNotifier {
  final ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.light);

  String playerName = '';
  String selectedTopicId = quizTopics.first.id;
  int currentQuestionIndex = 0;
  int? selectedAnswerIndex;
  int correctAnswers = 0;
  bool isComplete = false;
  bool isInProgress = false;

  QuizTopic get selectedTopic =>
      quizTopics.firstWhere((topic) => topic.id == selectedTopicId);

  int get questionCount => selectedTopic.questions.length;

  bool get hasAnswered => selectedAnswerIndex != null;

  bool get isLastQuestion => currentQuestionIndex == questionCount - 1;

  void toggleTheme() {
    themeMode.value = themeMode.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  void updatePlayerName(String value) {
    playerName = value;
  }

  void selectTopic(String topicId) {
    if (!isInProgress && quizTopics.any((topic) => topic.id == topicId)) {
      selectedTopicId = topicId;
      notifyListeners();
    }
  }

  void startQuiz({required String name, required String topicId}) {
    playerName = name.trim();
    selectedTopicId = topicId;
    currentQuestionIndex = 0;
    selectedAnswerIndex = null;
    correctAnswers = 0;
    isComplete = false;
    isInProgress = true;
    notifyListeners();
  }

  void selectAnswer(int answerIndex) {
    if (hasAnswered || isComplete) return;
    selectedAnswerIndex = answerIndex;
    if (answerIndex ==
        selectedTopic.questions[currentQuestionIndex].answerIndex) {
      correctAnswers++;
    }
    notifyListeners();
  }

  void advanceQuestion() {
    if (!hasAnswered || isComplete) return;
    if (isLastQuestion) {
      isComplete = true;
      isInProgress = false;
    } else {
      currentQuestionIndex++;
      selectedAnswerIndex = null;
    }
    notifyListeners();
  }

  void resetQuiz() {
    currentQuestionIndex = 0;
    selectedAnswerIndex = null;
    correctAnswers = 0;
    isComplete = false;
    isInProgress = false;
    notifyListeners();
  }

  @override
  void dispose() {
    themeMode.dispose();
    super.dispose();
  }
}
