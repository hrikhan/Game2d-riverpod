import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../game/shadow_escape_game.dart';
import '../../state/game_session.dart';

class StartOverlay extends ConsumerWidget {
  const StartOverlay({super.key, required this.game});

  final ShadowEscapeGame game;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.black.withOpacity(0.35),
      child: Center(
        child: Card(
          color: const Color(0xFF10182A).withOpacity(0.95),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.flash_on, color: Color(0xFF61F3F6), size: 48),
                const SizedBox(height: 12),
                Text(
                  'Shadow Escape',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tap to move. Keep away from the shadows and chase the light shards to climb your score.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white70),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: () {
                    ref.read(gameSessionProvider.notifier).start();
                    game.startRun();
                  },
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: const Text('Start Run'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
