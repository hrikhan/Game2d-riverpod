import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../game/shadow_escape_game.dart';
import '../../state/game_session.dart';
import '../widgets/glass_chip.dart';

class HudOverlay extends ConsumerWidget {
  const HudOverlay({super.key, required this.game});

  final ShadowEscapeGame game;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(gameSessionProvider);

    return IgnorePointer(
      ignoring: true,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GlassChip(
              icon: Icons.auto_awesome,
              label: 'Score',
              value: session.score.toString(),
            ),
            GlassChip(
              icon: Icons.local_fire_department,
              label: 'Best',
              value: session.best.toString(),
            ),
            GlassChip(
              icon: Icons.speed,
              label: 'Flow',
              value: game.difficultyLabel,
            ),
          ],
        ),
      ),
    );
  }
}
