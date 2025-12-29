import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

enum GamePhase { idle, running, gameOver }

class GameSession {
  const GameSession({
    required this.phase,
    required this.score,
    required this.best,
  });

  final GamePhase phase;
  final int score;
  final int best;

  GameSession copyWith({
    GamePhase? phase,
    int? score,
    int? best,
  }) {
    return GameSession(
      phase: phase ?? this.phase,
      score: score ?? this.score,
      best: best ?? this.best,
    );
  }

  static GameSession initial() =>
      const GameSession(phase: GamePhase.idle, score: 0, best: 0);
}

class GameController extends StateNotifier<GameSession> {
  GameController() : super(GameSession.initial());

  void start() {
    state = GameSession(
      phase: GamePhase.running,
      score: 0,
      best: state.best,
    );
  }

  void addScore(int delta) {
    if (state.phase != GamePhase.running) return;
    final updatedScore = state.score + delta;
    state = state.copyWith(
      score: updatedScore,
      best: max(state.best, updatedScore),
    );
  }

  void gameOver() {
    state = state.copyWith(
      phase: GamePhase.gameOver,
      best: max(state.best, state.score),
    );
  }

  void backToIdle() {
    state = state.copyWith(phase: GamePhase.idle, score: 0);
  }
}

final gameSessionProvider =
    StateNotifierProvider<GameController, GameSession>((ref) {
  return GameController();
});
