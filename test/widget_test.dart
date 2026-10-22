import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kuis_app/data/quiz_data.dart';
import 'package:kuis_app/main.dart';

void main() {
  testWidgets('player can start a quiz and resume its saved answer', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(900, 1400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const QuizApp());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'Naya');
    await tester.pump();
    await tester.tap(find.text('Mulai kuis'));
    await tester.pumpAndSettle();

    expect(find.text('Apa ibu kota negara Jepang?'), findsOneWidget);
    await tester.tap(find.text('Tokyo'));
    await tester.pumpAndSettle();
    expect(find.text('Tepat sekali!'), findsOneWidget);

    await tester.tap(find.byTooltip('Kembali'));
    await tester.pumpAndSettle();
    expect(find.text('Lanjutkan kuis'), findsOneWidget);

    await tester.tap(find.text('Lanjutkan kuis'));
    await tester.pumpAndSettle();
    expect(find.text('Tepat sekali!'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('finishing all questions shows the final score', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const QuizApp());
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Naya');
    await tester.pump();
    await tester.ensureVisible(find.text('Mulai kuis'));
    await tester.tap(find.text('Mulai kuis'));
    await tester.pumpAndSettle();

    for (var index = 0; index < quizTopics.first.questions.length; index++) {
      final question = quizTopics.first.questions[index];
      await tester.ensureVisible(
        find.text(question.options[question.answerIndex]),
      );
      await tester.tap(find.text(question.options[question.answerIndex]));
      await tester.pumpAndSettle();

      final buttonLabel = index == quizTopics.first.questions.length - 1
          ? 'Lihat hasil'
          : 'Pertanyaan berikutnya';
      await tester.ensureVisible(find.text(buttonLabel));
      await tester.tap(find.text(buttonLabel));
      await tester.pumpAndSettle();
    }

    expect(find.text('Sempurna!'), findsOneWidget);
    expect(find.text('100%'), findsOneWidget);
    expect(find.text('5'), findsWidgets);

    await tester.tap(find.text('Tinjau jawaban'));
    await tester.pumpAndSettle();
    expect(find.text('Tinjau jawaban'), findsOneWidget);
    expect(find.text('Apa ibu kota negara Jepang?'), findsOneWidget);
    expect(
      find.text('Tokyo adalah ibu kota sekaligus kota terpadat di Jepang.'),
      findsOneWidget,
    );
  });
}
