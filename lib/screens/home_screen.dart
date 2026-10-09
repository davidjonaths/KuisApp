import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app/quiz_controller.dart';
import '../app/quiz_scope.dart';
import '../data/quiz_data.dart';
import '../widgets/primary_button.dart';
import '../widgets/topic_card.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final controller = QuizScope.of(context);
    if (_nameController.text.isEmpty && controller.playerName.isNotEmpty) {
      _nameController.text = controller.playerName;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _openQuiz(QuizController controller) {
    if (controller.isInProgress) {
      Navigator.of(context)
          .push(MaterialPageRoute<void>(builder: (_) => const QuizScreen()));
      return;
    }
    controller.startQuiz(
      name: _nameController.text,
      topicId: controller.selectedTopicId,
    );
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (_) => const QuizScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final controller = QuizScope.of(context);
    final colors = Theme.of(context).colorScheme;
    final isWide = MediaQuery.sizeOf(context).width >= 760;
    final horizontalPadding = (MediaQuery.sizeOf(context).width * 0.055).clamp(
      20.0,
      48.0,
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1120),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  12,
                  horizontalPadding,
                  36,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Header(
                      onThemePressed: controller.toggleTheme,
                      isDark: Theme.of(context).brightness == Brightness.dark,
                    ),
                    SizedBox(height: isWide ? 34 : 18),
                    if (isWide)
                      Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: _WelcomeCopy(controller: controller),
                          ),
                          Expanded(
                            flex: 5,
                            child: SvgPicture.asset(
                              'assets/images/quiz_hero.svg',
                              semanticsLabel:
                                  'Ilustrasi belajar sambil bermain kuis',
                              fit: BoxFit.contain,
                              height: MediaQuery.sizeOf(context).height * 0.30,
                            ),
                          ),
                        ],
                      )
                    else ...[
                      _WelcomeCopy(controller: controller),
                      const SizedBox(height: 12),
                      Center(
                        child: SvgPicture.asset(
                          'assets/images/quiz_hero.svg',
                          semanticsLabel: 'Ilustrasi kuis',
                          fit: BoxFit.contain,
                          height: (MediaQuery.sizeOf(context).height * 0.19)
                              .clamp(120.0, 190.0),
                        ),
                      ),
                    ],
                    SizedBox(height: isWide ? 28 : 12),
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(isWide ? 28 : 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.isInProgress
                                  ? 'Siap melanjutkan?'
                                  : 'Mulai dari sini',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Kenalan dulu, lalu pilih topik favoritmu.',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: colors.onSurfaceVariant),
                            ),
                            const SizedBox(height: 22),
                            Text(
                              'NAMA PEMAIN',
                              style: Theme.of(context).textTheme.labelMedium
                                  ?.copyWith(
                                    color: colors.onSurfaceVariant,
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _nameController,
                              textCapitalization: TextCapitalization.words,
                              textInputAction: TextInputAction.done,
                              onChanged: (value) {
                                controller.updatePlayerName(value);
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                hintText: 'Contoh: Naya',
                                prefixIcon: const Icon(
                                  Icons.person_outline_rounded,
                                ),
                                filled: true,
                                fillColor: colors.onSurface.withValues(
                                  alpha: 0.035,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            const SizedBox(height: 22),
                            Text(
                              'PILIH TOPIK',
                              style: Theme.of(context).textTheme.labelMedium
                                  ?.copyWith(
                                    color: colors.onSurfaceVariant,
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                            const SizedBox(height: 12),
                            LayoutBuilder(
                              builder: (context, constraints) {
                                final columns = constraints.maxWidth >= 700
                                    ? 3
                                    : constraints.maxWidth >= 420
                                    ? 2
                                    : 1;
                                final cardWidth =
                                    (constraints.maxWidth -
                                        12 * (columns - 1)) /
                                    columns;
                                return Wrap(
                                  spacing: 12,
                                  runSpacing: 12,
                                  children: [
                                    for (final topic in quizTopics)
                                      SizedBox(
                                        width: cardWidth,
                                        child: TopicCard(
                                          topic: topic,
                                          selected:
                                              topic.id ==
                                              controller.selectedTopicId,
                                          onTap: () =>
                                              controller.selectTopic(topic.id),
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 22),
                            PrimaryButton(
                              label: controller.isInProgress
                                  ? 'Lanjutkan kuis'
                                  : 'Mulai kuis',
                              icon: Icons.arrow_forward_rounded,
                              enabled: _nameController.text.trim().isNotEmpty,
                              onPressed: () => _openQuiz(controller),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        'Belajar hal baru, satu pertanyaan setiap kali.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(color: colors.onSurfaceVariant),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _WelcomeCopy extends StatelessWidget {
  const _WelcomeCopy({required this.controller});

  final QuizController controller;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final selectedTopic = quizTopics.firstWhere(
      (topic) => topic.id == controller.selectedTopicId,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
          decoration: BoxDecoration(
            color: colors.primary.withValues(alpha: 0.09),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.auto_awesome_rounded, size: 16, color: colors.primary),
              const SizedBox(width: 7),
              Text(
                'MAIN • BELAJAR • ULANGI',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text.rich(
          TextSpan(
            text: 'Hai, ',
            children: [
              TextSpan(
                text: controller.playerName.isEmpty
                    ? 'si pintar'
                    : controller.playerName,
                style: TextStyle(color: colors.primary),
              ),
              const TextSpan(text: '!\n'),
              const TextSpan(text: 'Siap uji\npengetahuanmu?'),
            ],
          ),
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.w900,
            height: 1.14,
            letterSpacing: -1.3,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          '${selectedTopic.questions.length} pertanyaan pilihan ganda menantimu di ${selectedTopic.title}.',
          style: Theme.of(context).textTheme.bodyLarge
              ?.copyWith(color: colors.onSurfaceVariant, height: 1.55),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onThemePressed, required this.isDark});

  final VoidCallback onThemePressed;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: colors.primary,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Icon(Icons.bolt_rounded, color: Colors.white, size: 27),
        ),
        const SizedBox(width: 11),
        Text(
          'ruangkuis',
          style: Theme.of(context).textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.w900, letterSpacing: -0.6),
        ),
        const Spacer(),
        IconButton.filledTonal(
          tooltip: isDark ? 'Aktifkan mode terang' : 'Aktifkan mode gelap',
          onPressed: onThemePressed,
          icon: Icon(
            isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
          ),
        ),
      ],
    );
  }
}
