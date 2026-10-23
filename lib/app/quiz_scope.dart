import 'package:flutter/widgets.dart';

import 'quiz_controller.dart';

class QuizScope extends InheritedNotifier<QuizController> {
  const QuizScope({
    super.key,
    required QuizController controller,
    required super.child,
  }) : super(notifier: controller);

  static QuizController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<QuizScope>();
    assert(scope != null, 'QuizScope is missing above this context.');
    return scope!.notifier!;
  }
}
