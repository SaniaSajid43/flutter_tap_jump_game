import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:tap_jump/screens/tap_game.dart';
void main() {
  final game = TapGame();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            GameWidget(
              game: game,
              overlayBuilderMap: {
                'GameOver': (context, _) => Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Game Over', style: TextStyle(fontSize: 32, color: Colors.red)),
                          ElevatedButton(
                            onPressed: () {
                              game.onTap(); // restart
                            },
                            child: const Text('Restart'),
                          ),
                        ],
                      ),
                    ),
              },
            ),
          ],
        ),
      ),
    ),
  );
}

