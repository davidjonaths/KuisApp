class QuizQuestion {
  const QuizQuestion({
    required this.prompt,
    required this.options,
    required this.answerIndex,
    required this.explanation,
  });

  final String prompt;
  final List<String> options;
  final int answerIndex;
  final String explanation;
}
