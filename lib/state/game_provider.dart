import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../game/shadow_escape_game.dart';

final shadowGameProvider = Provider<ShadowEscapeGame>((ref) {
  final game = ShadowEscapeGame(ref);
  ref.onDispose(game.disposeGame);
  return game;
});
