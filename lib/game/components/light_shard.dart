part of '../shadow_escape_game.dart';

class LightShard extends CircleComponent
    with CollisionCallbacks, HasGameReference<ShadowEscapeGame> {
  LightShard({required Vector2 position})
      : super(
          radius: 10,
          position: position,
          anchor: Anchor.center,
          paint: Paint()
            ..shader = const RadialGradient(
              colors: [
                Color(0xFF64F9F5),
                Color(0xFF2FD3E5),
                Color(0x802FD3E5),
              ],
            ).createShader(Rect.fromCircle(center: Offset.zero, radius: 20)),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(CircleHitbox()..collisionType = CollisionType.passive);
    add(
      ScaleEffect.by(
        Vector2.all(1.08),
        EffectController(
          duration: 0.6,
          reverseDuration: 0.6,
          infinite: true,
          curve: Curves.easeInOut,
        ),
      ),
    );
  }
}
