import 'package:flutter/material.dart';

import '../app/quiz_controller.dart';
import '../app/quiz_scope.dart';
import '../models/quiz_question.dart';
import '../widgets/primary_button.dart';
import '../widgets/question_option.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = QuizScope.of(context);
    final topic = controller.selectedTopic;
    final question = controller.questions[controller.currentQuestionIndex];
    final colors = Theme.of(context).colorScheme;
    final isWide = MediaQuery.sizeOf(context).width >= 760;
    final horizontalPadding = (MediaQuery.sizeOf(context).width * 0.06).clamp(
      20.0,
      64.0,
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Kembali',
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: Text(
          topic.title,
          style: Theme.of(context).textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(child: _ScorePill(score: controller.correctAnswers)),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                12,
                horizontalPadding,
                28,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 760),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ProgressHeader(
                        index: controller.currentQuestionIndex,
                        count: controller.questionCount,
                        name: controller.playerName,
                      ),
                      SizedBox(height: isWide ? 28 : 22),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(isWide ? 30 : 22),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  color: topic.color.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  'PERTANYAAN ${controller.currentQuestionIndex + 1}',
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(
                                        color: topic.color,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 1,
                                      ),
                                ),
                              ),
                              const SizedBox(height: 18),
                              Text(
                                question.prompt,
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w900,
                                      height: 1.3,
                                    ),
                              ),
                              SizedBox(height: isWide ? 28 : 20),
                              for (var i = 0; i < question.options.length; i++)
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: i == question.options.length - 1
                                        ? 0
                                        : 10,
                                  ),
                                  child: QuestionOption(
                                    label: String.fromCharCode(65 + i),
                                    text: question.options[i],
                                    isSelected:
                                        controller.selectedAnswerIndex == i,
                                    isCorrect: question.answerIndex == i,
                                    isAnswered: controller.hasAnswered,
                                    onTap: () => controller.selectAnswer(i),
                                  ),
                                ),
                              if (controller.hasAnswered) ...[
                                const SizedBox(height: 18),
                                _AnswerFeedback(
                                  question: question,
                                  isCorrect:
                                      controller.selectedAnswerIndex ==
                                      question.answerIndex,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      PrimaryButton(
                        label: controller.isLastQuestion
                            ? 'Lihat hasil'
                            : controller.hasAnswered
                            ? 'Pertanyaan berikutnya'
                            : 'Pilih jawaban dulu',
                        icon: controller.isLastQuestion
                            ? Icons.emoji_events_outlined
                            : Icons.arrow_forward_rounded,
                        enabled: controller.hasAnswered,
                        onPressed: () => _advance(context, controller),
                      ),
                      const SizedBox(height: 12),
                      Center(
                        child: Text(
                          'Jawaban benar bernilai 1 poin',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: colors.onSurfaceVariant),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _advance(BuildContext context, QuizController controller) {
    final finished = controller.isLastQuestion;
    controller.advanceQuestion();
    if (finished) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (_) => const ResultScreen()),
      );
    }
  }
}

class _ProgressHeader extends StatelessWidget {
  const _ProgressHeader({
    required this.index,
    required this.count,
    required this.name,
  });

  final int index;
  final int count;
  final String name;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final progress = (index + 1) / count;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Semangat, $name!',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
            Text(
              '${index + 1} dari $count',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: colors.onSurfaceVariant,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 9,
            backgroundColor: colors.onSurface.withValues(alpha: 0.08),
            color: colors.primary,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(
              Icons.shuffle_rounded,
              size: 15,
              color: colors.onSurfaceVariant,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                'Urutan soal diacak untuk sesi ini',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelSmall
                    ?.copyWith(color: colors.onSurfaceVariant),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ScorePill extends StatelessWidget {
  const _ScorePill({required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Icon(Icons.star_rounded, color: colors.primary, size: 18),
          const SizedBox(width: 5),
          Text(
            '$score',
            style: TextStyle(
              color: colors.primary,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _AnswerFeedback extends StatelessWidget {
  const _AnswerFeedback({required this.question, required this.isCorrect});

  final QuizQuestion question;
  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    final color = isCorrect
        ? const Color(0xFF16875F)
        : Theme.of(context).colorScheme.error;
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isCorrect ? Icons.check_circle_rounded : Icons.lightbulb_rounded,
            color: color,
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isCorrect ? 'Tepat sekali!' : 'Belum tepat, tetap semangat!',
                  style: TextStyle(color: color, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 5),
                Text(
                  question.explanation,
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: colors.onSurfaceVariant, height: 1.45),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
