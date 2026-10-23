import 'package:flutter/material.dart';

class QuestionOption extends StatelessWidget {
  const QuestionOption({
    super.key,
    required this.label,
    required this.text,
    required this.isSelected,
    required this.isCorrect,
    required this.isAnswered,
    required this.onTap,
  });

  final String label;
  final String text;
  final bool isSelected;
  final bool isCorrect;
  final bool isAnswered;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final Color accent;
    if (isAnswered && isCorrect) {
      accent = const Color(0xFF1C9B6C);
    } else if (isSelected && isAnswered) {
      accent = colors.error;
    } else {
      accent = colors.primary;
    }

    return Semantics(
      button: true,
      selected: isSelected,
      label: 'Pilihan $label: $text',
      child: Material(
        color: isSelected && isAnswered
            ? accent.withValues(alpha: 0.08)
            : colors.surface,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: isAnswered ? null : onTap,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            constraints: const BoxConstraints(minHeight: 64),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isAnswered && (isSelected || isCorrect)
                    ? accent
                    : colors.onSurface.withValues(alpha: 0.1),
                width: isAnswered && (isSelected || isCorrect) ? 1.6 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isAnswered && (isSelected || isCorrect)
                        ? accent
                        : colors.onSurface.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: isAnswered && (isSelected || isCorrect)
                          ? Colors.white
                          : colors.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                if (isAnswered && (isSelected || isCorrect))
                  Icon(
                    isCorrect
                        ? Icons.check_circle_rounded
                        : Icons.cancel_rounded,
                    color: accent,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
