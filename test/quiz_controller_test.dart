import 'dart:math';

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
    expect(controller.selectedAnswers.first, 0);

    controller.selectAnswer(1);
    expect(controller.correctAnswers, 0);
    expect(controller.selectedAnswerIndex, 0);
    expect(controller.selectedAnswers.first, 0);

    controller.advanceQuestion();
    expect(controller.currentQuestionIndex, 1);
    expect(controller.selectedAnswerIndex, isNull);
    expect(controller.selectedAnswers.first, 0);
  });

  test('finishes the quiz with its total correct answers', () {
    controller.startQuiz(name: 'Naya', topicId: 'technology');
    final questions = controller.questions;

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

  test('shuffles questions and keeps answers aligned for review', () {
    controller.dispose();
    controller = QuizController(random: Random(7));
    controller.startQuiz(name: 'Naya', topicId: 'general');

    final shuffledQuestions = controller.questions;
    final originalQuestions = controller.selectedTopic.questions;
    expect(shuffledQuestions.toSet(), originalQuestions.toSet());
    expect(shuffledQuestions, isNot(equals(originalQuestions)));

    for (var index = 0; index < shuffledQuestions.length; index++) {
      final question = shuffledQuestions[index];
      final selectedAnswer = index.isEven
          ? question.answerIndex
          : (question.answerIndex + 1) % question.options.length;
      controller.selectAnswer(selectedAnswer);
      controller.advanceQuestion();
    }

    expect(controller.selectedAnswers, [
      for (var index = 0; index < shuffledQuestions.length; index++)
        index.isEven
            ? shuffledQuestions[index].answerIndex
            : (shuffledQuestions[index].answerIndex + 1) %
                  shuffledQuestions[index].options.length,
    ]);
    expect(controller.correctAnswers, (shuffledQuestions.length + 1) ~/ 2);
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
