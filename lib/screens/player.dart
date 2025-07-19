import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import 'tap_game.dart';
import 'obstacle.dart';

class Player extends SpriteComponent with HasGameRef<TapGame>, CollisionCallbacks {
  double velocityY = 0;
  final double gravity = 700;
  final double jumpForce = -500;

  Player() : super(size: Vector2(60, 60), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('player.jpg');
    position = Vector2(gameRef.size.x / 2, gameRef.size.y - 100);
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    velocityY += gravity * dt;
    position.y += velocityY * dt;

    if (position.y >= gameRef.size.y - height / 2) {
      position.y = gameRef.size.y - height / 2;
      velocityY = 0;
    }
  }

  void jump() {
    if (position.y >= gameRef.size.y - height / 2) {
      velocityY = jumpForce;
    
    }
  }

  void resetPosition() {
    position = Vector2(gameRef.size.x / 2, gameRef.size.y - 100);
    velocityY = 0;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Obstacle) {
      gameRef.gameOver();
    }
  }
}
