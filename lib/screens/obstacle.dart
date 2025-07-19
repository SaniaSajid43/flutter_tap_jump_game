import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'tap_game.dart';

class Obstacle extends PositionComponent with HasGameRef<TapGame>, CollisionCallbacks {
  bool hasScored = false;

  Obstacle() : super(size: Vector2(40, 40));

  @override
  Future<void> onLoad() async {
    position = Vector2(gameRef.size.x, gameRef.size.y - size.y - 10);
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= 150 * dt;

    // ✅ Score only if passed player
    if (!hasScored && position.x + width < gameRef.player.x) {
      hasScored = true;
      gameRef.increaseScore();
    }

    if (position.x < -width) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = const Color(0xFFB71C1C); // red
    canvas.drawRect(size.toRect(), paint);
  }
}
