import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'player.dart';
import 'obstacle.dart';

class TapGame extends FlameGame with TapDetector, HasCollisionDetection {
  late Player player;
  late SpriteComponent background;
  int score = 0;
  TextComponent scoreText = TextComponent();

  bool isGameOver = false;

  @override
  Future<void> onLoad() async {
    background = SpriteComponent()
      ..sprite = await loadSprite('bg.jpg')
      ..size = size;

    add(background);

    player = Player();
    add(player);

    add(scoreText
      ..text = 'Score: 0'
      ..position = Vector2(10, 10)
      ..anchor = Anchor.topLeft
      ..priority = 10);

    spawnObstacleLoop();
  }

  @override
  void onTap() {
    if (isGameOver) {
      restart();
    } else {
      player.jump();
    }
  }

  void increaseScore() {
    score++;
    scoreText.text = 'Score: $score';
  }

  void spawnObstacleLoop() async {
    while (!isGameOver) {
      await Future.delayed(const Duration(seconds: 2));
      add(Obstacle());
    }
  }

  void gameOver() {
    isGameOver = true;
    pauseEngine();
    overlays.add('GameOver');
  }

  void restart() {
    score = 0;
    scoreText.text = 'Score: 0';
    isGameOver = false;
    children.whereType<Obstacle>().forEach((obs) => obs.removeFromParent());
    player.resetPosition();
    resumeEngine();
    overlays.remove('GameOver');
  }
}
