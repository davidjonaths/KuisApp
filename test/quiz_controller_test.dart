import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kuis_app/app/quiz_controller.dart';
import 'package:kuis_app/data/quiz_data.dart';

void main() {
  late QuizController controller;

  setUp(() {
    controller = QuizController();
  });

  tearDown(() {
    controller.dispose();
  });

  test('keeps answer and score until the player advances', () {
    controller.startQuiz(name: '  Naya  ', topicId: 'general');

    expect(controller.playerName, 'Naya');
    expect(controller.isInProgress, isTrue);
    expect(controller.hasAnswered, isFalse);

    controller.selectAnswer(0);
    expect(controller.correctAnswers, 0);
    expect(controller.hasAnswered, isTrue);

    controller.selectAnswer(1);
    expect(controller.correctAnswers, 0);
    expect(controller.selectedAnswerIndex, 0);

    controller.advanceQuestion();
    expect(controller.currentQuestionIndex, 1);
    expect(controller.selectedAnswerIndex, isNull);
  });

  test('finishes the quiz with its total correct answers', () {
    controller.startQuiz(name: 'Naya', topicId: 'technology');
    final questions = controller.selectedTopic.questions;

    for (var i = 0; i < questions.length; i++) {
      controller.selectAnswer(questions[i].answerIndex);
      expect(controller.correctAnswers, i + 1);
      controller.advanceQuestion();
    }

    expect(controller.currentQuestionIndex, questions.length - 1);
    expect(controller.isComplete, isTrue);
    expect(controller.isInProgress, isFalse);
    expect(controller.correctAnswers, questions.length);
  });

  test('locks topic changes during a quiz and toggles the app theme', () {
    controller.selectTopic('science');
    expect(controller.selectedTopicId, 'science');
    controller.startQuiz(name: 'Naya', topicId: 'science');

    controller.selectTopic('technology');
    expect(controller.selectedTopicId, 'science');

    expect(controller.themeMode.value, ThemeMode.light);
    controller.toggleTheme();
    expect(controller.themeMode.value, ThemeMode.dark);
    controller.toggleTheme();
    expect(controller.themeMode.value, ThemeMode.light);

    expect(quizTopics.length, 3);
  });
}
