import 'package:flutter/material.dart';

import '../app/quiz_scope.dart';
import '../models/quiz_question.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = QuizScope.of(context);
    final topic = controller.selectedTopic;
    final colors = Theme.of(context).colorScheme;
    final horizontalPadding = (MediaQuery.sizeOf(context).width * 0.05).clamp(
      16.0,
      48.0,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Tinjau jawaban'), centerTitle: true),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: ListView(
            padding: EdgeInsets.fromLTRB(
              horizontalPadding,
              8,
              horizontalPadding,
              32,
            ),
            children: [
              Text(
                topic.title,
                style: Theme.of(context).textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 6),
              Text(
                'Pelajari kembali jawabanmu dan pahami penjelasannya.',
                style: Theme.of(context).textTheme.bodyMedium
                    ?.copyWith(color: colors.onSurfaceVariant),
              ),
              const SizedBox(height: 20),
              for (var index = 0; index < topic.questions.length; index++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: _ReviewCard(
                    number: index + 1,
                    question: topic.questions[index],
                    selectedAnswer: controller.selectedAnswers[index],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({
    required this.number,
    required this.question,
    required this.selectedAnswer,
  });

  final int number;
  final QuizQuestion question;
  final int? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final wasCorrect = selectedAnswer == question.answerIndex;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: colors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    'SOAL $number',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.7,
                    ),
                  ),
                ),
                const Spacer(),
                Icon(
                  wasCorrect
                      ? Icons.check_circle_rounded
                      : Icons.cancel_rounded,
                  color: wasCorrect ? const Color(0xFF16875F) : colors.error,
                  size: 20,
                ),
                const SizedBox(width: 6),
                Text(
                  wasCorrect ? 'Benar' : 'Belum tepat',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: wasCorrect ? const Color(0xFF16875F) : colors.error,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              question.prompt,
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w800, height: 1.4),
            ),
            const SizedBox(height: 12),
            for (var index = 0; index < question.options.length; index++)
              _ReviewOption(
                label: String.fromCharCode(65 + index),
                text: question.options[index],
                isCorrect: index == question.answerIndex,
                isSelected: index == selectedAnswer,
              ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.lightbulb_outline_rounded,
                    color: colors.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      question.explanation,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        height: 1.5,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewOption extends StatelessWidget {
  const _ReviewOption({
    required this.label,
    required this.text,
    required this.isCorrect,
    required this.isSelected,
  });

  final String label;
  final String text;
  final bool isCorrect;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final Color? foreground;
    final Color? background;
    if (isCorrect) {
      foreground = const Color(0xFF16875F);
      background = foreground.withValues(alpha: 0.08);
    } else if (isSelected) {
      foreground = colors.error;
      background = foreground.withValues(alpha: 0.07);
    } else {
      foreground = colors.onSurfaceVariant;
      background = null;
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 7),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(color: foreground, fontWeight: FontWeight.w900),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: foreground, fontWeight: FontWeight.w600),
            ),
          ),
          if (isCorrect)
            const Icon(
              Icons.check_circle_rounded,
              color: Color(0xFF16875F),
              size: 18,
            )
          else if (isSelected)
            Icon(
              Icons.radio_button_checked_rounded,
              color: colors.error,
              size: 18,
            ),
        ],
      ),
    );
  }
}
