part of '../shadow_escape_game.dart';

class PlayerOrb extends CircleComponent
    with CollisionCallbacks, HasGameReference<ShadowEscapeGame> {
  PlayerOrb({required Vector2 position})
      : super(
          radius: 18,
          position: position,
          anchor: Anchor.center,
          paint: Paint()
            ..color = const Color(0xFF61F3F6)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
        );

  Vector2? _target;
  final double _speed = 230;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(CircleHitbox()..collisionType = CollisionType.active);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_target == null) return;

    final toTarget = _target! - position;
    if (toTarget.length < _speed * dt) {
      position = _target!;
      _target = null;
    } else {
      position += toTarget.normalized() * _speed * dt;
    }
  }

  void setTarget(Vector2 target) {
    _target = target;
  }

  void reset({required Vector2 position}) {
    this.position = position;
    _target = null;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is ShadowOrb) {
      game.triggerGameOver();
    } else if (other is LightShard) {
      game.collectShard(other);
    }
  }
}
