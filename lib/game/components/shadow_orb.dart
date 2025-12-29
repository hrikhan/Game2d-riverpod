part of '../shadow_escape_game.dart';

class ShadowOrb extends CircleComponent
    with CollisionCallbacks, HasGameReference<ShadowEscapeGame> {
  ShadowOrb({required Vector2 position, required this.velocity})
      : super(
          radius: 14,
          position: position,
          anchor: Anchor.center,
          paint: Paint()
            ..shader = RadialGradient(
              colors: [
                const Color(0xFF121826),
                const Color(0xFF070B12).withOpacity(0.8),
              ],
            ).createShader(Rect.fromCircle(center: Offset.zero, radius: 16)),
        );

  final Vector2 velocity;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(CircleHitbox()..collisionType = CollisionType.active);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;

    const buffer = 60;
    if (position.x < -buffer ||
        position.x > game.size.x + buffer ||
        position.y < -buffer ||
        position.y > game.size.y + buffer) {
      removeFromParent();
    }
  }
}
