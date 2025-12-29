import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../game/shadow_escape_game.dart';
import '../../state/game_session.dart';
import '../widgets/stat_pill.dart';

class GameOverOverlay extends ConsumerWidget {
  const GameOverOverlay({super.key, required this.game});

  final ShadowEscapeGame game;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(gameSessionProvider);

    return Container(
      color: Colors.black.withOpacity(0.45),
      child: Center(
        child: Card(
          color: const Color(0xFF111A2C).withOpacity(0.95),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.nights_stay, color: Colors.white, size: 48),
                const SizedBox(height: 12),
                Text(
                  'You got caught',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StatPill(label: 'Score', value: '${session.score}'),
                    StatPill(label: 'Best', value: '${session.best}'),
                  ],
                ),
                const SizedBox(height: 18),
                FilledButton.icon(
                  onPressed: () {
                    ref.read(gameSessionProvider.notifier).start();
                    game.startRun();
                  },
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Retry'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    ref.read(gameSessionProvider.notifier).backToIdle();
                    game.resetToIdle();
                  },
                  child: const Text('Back to title'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
