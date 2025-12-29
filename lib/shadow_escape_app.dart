import 'package:flutter/material.dart';

import 'ui/shadow_escape_page.dart';

class ShadowEscapeApp extends StatelessWidget {
  const ShadowEscapeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF61F3F6),
      brightness: Brightness.dark,
    );

    return MaterialApp(
      title: 'Shadow Escape',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF0A0E17),
      ),
      home: const ShadowEscapePage(),
    );
  }
}
