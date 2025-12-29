import 'dart:math';

import 'package:flame/camera.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/game_session.dart';
import 'overlays.dart';

part 'components/player_orb.dart';
part 'components/shadow_orb.dart';
part 'components/light_shard.dart';

class ShadowEscapeGame extends FlameGame
    with HasCollisionDetection, TapCallbacks {
  ShadowEscapeGame(this.ref) : super();

  final Ref ref;
  late PlayerOrb _player;
  final Random _rng = Random();
  late Timer _shadowTimer;
  late Timer _shardTimer;
  double _scoreTicker = 0;
  int _difficultyLevel = 1;

  String get difficultyLabel => 'x$_difficultyLevel';

  @override
  Color backgroundColor() => const Color(0xFF0B0F18);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    camera.viewport =
        FixedResolutionViewport(resolution: Vector2(420, 780));
    _player = PlayerOrb(position: size / 2);
    add(_player);
    add(ScreenHitbox());

    _shadowTimer = Timer(1.8, onTick: spawnShadow, repeat: true);
    _shardTimer = Timer(3.2, onTick: spawnShard, repeat: true);
    pauseEngine();
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (ref.read(gameSessionProvider).phase != GamePhase.running) return;
    _player.setTarget(event.localPosition);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (ref.read(gameSessionProvider).phase != GamePhase.running) return;

    _shadowTimer.update(dt);
    _shardTimer.update(dt);

    _scoreTicker += dt;
    if (_scoreTicker >= 1) {
      ref.read(gameSessionProvider.notifier).addScore(1);
      _scoreTicker = 0;
    }
  }

  void startRun() {
    resetWorld();
    overlays.remove(GameOverlay.start);
    overlays.remove(GameOverlay.gameOver);
    overlays.add(GameOverlay.hud);
    resumeEngine();
  }

  void resetToIdle() {
    resetWorld();
    pauseEngine();
    overlays
      ..remove(GameOverlay.hud)
      ..remove(GameOverlay.gameOver);
    overlays.add(GameOverlay.start);
  }

  void resetWorld() {
    for (final orb in children.whereType<ShadowOrb>().toList()) {
      orb.removeFromParent();
    }
    for (final shard in children.whereType<LightShard>().toList()) {
      shard.removeFromParent();
    }
    _player.reset(position: size / 2);
    _scoreTicker = 0;
    _difficultyLevel = 1;
    _shadowTimer.stop();
    _shardTimer.stop();
    _shadowTimer.start();
    _shardTimer.start();
  }

  void spawnShadow() {
    final spawnEdge = _rng.nextInt(4);
    const padding = 40.0;
    Vector2 position;
    Vector2 velocity;
    final baseSpeed = 70 + _difficultyLevel * 12;

    switch (spawnEdge) {
      case 0:
        position = Vector2(-padding, _rng.nextDouble() * size.y);
        velocity = Vector2(baseSpeed.toDouble(), 0);
        break;
      case 1:
        position = Vector2(size.x + padding, _rng.nextDouble() * size.y);
        velocity = Vector2(-baseSpeed.toDouble(), 0);
        break;
      case 2:
        position = Vector2(_rng.nextDouble() * size.x, -padding);
        velocity = Vector2(0, baseSpeed.toDouble());
        break;
      default:
        position = Vector2(_rng.nextDouble() * size.x, size.y + padding);
        velocity = Vector2(0, -baseSpeed.toDouble());
    }

    final shadow = ShadowOrb(
      position: position,
      velocity: velocity.normalized() * (baseSpeed + _rng.nextDouble() * 40),
    );
    add(shadow);

    if (ref.read(gameSessionProvider).score % 15 == 0) {
      _difficultyLevel = min(6, _difficultyLevel + 1);
    }
  }

  void spawnShard() {
    final position = Vector2(
      _rng.nextDouble() * (size.x - 40) + 20,
      _rng.nextDouble() * (size.y - 40) + 20,
    );
    add(LightShard(position: position));
  }

  void collectShard(LightShard shard) {
    shard.removeFromParent();
    ref.read(gameSessionProvider.notifier).addScore(5);
  }

  void triggerGameOver() {
    ref.read(gameSessionProvider.notifier).gameOver();
    pauseEngine();
    overlays
      ..remove(GameOverlay.hud)
      ..add(GameOverlay.gameOver);
  }

  void disposeGame() {
    pauseEngine();
  }
}
