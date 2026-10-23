import 'package:flutter/material.dart';

abstract final class QuizTheme {
  static const _purple = Color(0xFF6258E8);
  static const _mint = Color(0xFFB5F2D6);

  static ThemeData get light => _buildTheme(
    brightness: Brightness.light,
    background: const Color(0xFFF6F7FB),
    surface: Colors.white,
    foreground: const Color(0xFF1E2033),
    muted: const Color(0xFF777A91),
  );

  static ThemeData get dark => _buildTheme(
    brightness: Brightness.dark,
    background: const Color(0xFF11121C),
    surface: const Color(0xFF1C1E2B),
    foreground: const Color(0xFFF4F3FC),
    muted: const Color(0xFFAAAABD),
  );

  static ThemeData _buildTheme({
    required Brightness brightness,
    required Color background,
    required Color surface,
    required Color foreground,
    required Color muted,
  }) {
    final scheme = ColorScheme.fromSeed(
      seedColor: _purple,
      brightness: brightness,
      surface: surface,
    );
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      fontFamily: 'Manrope',
      textTheme: ThemeData(brightness: brightness).textTheme.apply(
        bodyColor: foreground,
        displayColor: foreground,
        fontFamily: 'Manrope',
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: foreground,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(
            color: brightness == Brightness.light
                ? const Color(0xFFE9EAF2)
                : const Color(0xFF303241),
          ),
        ),
      ),
      dividerColor: muted.withValues(alpha: 0.18),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected) ? _purple : null,
        ),
      ),
    );
  }

  static const mint = _mint;
}
