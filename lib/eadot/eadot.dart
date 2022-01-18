import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class EadotGame extends FlameGame with MouseMovementDetector {
  static const String description = '''
    In this example we show how you can use `MouseMovementDetector`.\n\n
    Move around the mouse on the canvas and the white square will follow it and
    turn into blue if it reaches the mouse, or the edge of the canvas.
  ''';
  final TextPaint scoreText = TextPaint(
    style: const TextStyle(color: Colors.white, fontSize: 20),
  );
  double dotSpeed = 20.0;

  late Timer dotSpawner;
  late PlayerDot player;
  int highScore = 0;

  @override
  Future<void> onLoad() async {
    this.player = PlayerDot(5);
    //debugMode = true;
    this.dotSpawner = Timer(
      0.5,
      onTick: () =>
          {add(Dot(this.size, dependentSize: this.player.playerSize))},
      repeat: true,
    );
    add(this.player);
  }

  @override
  void onMouseMove(PointerHoverInfo info) {
    player.position = info.eventPosition.game;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    scoreText.render(canvas, "Score: ${player.playerSize}", Vector2(30, 30));
    scoreText.render(canvas, "Highscore: ${this.highScore}", Vector2(30, 60));
  }

  bool shouldReset = false;

  @override
  void update(double dt) {
    super.update(dt);
    if (shouldReset) {
      if (player.playerSize != 5) {
        this.highScore = player.playerSize;
      }
      removeAll(this.children);
      this.player = PlayerDot(5);
      add(this.player);
      shouldReset = false;
    }

    this.dotSpawner.update(dt);
    for (var child in this.children) {
      if (child is Dot) {
        var combinedRadii = player.playerSize * player.playerSize +
            child.dotSize * child.dotSize;
        if (child.position.distanceToSquared(player.position) < combinedRadii) {
          if (child.dotSize > player.playerSize) {
            shouldReset = true;
          } else {
            player.scorePoint();
            child.removeFromParent();
          }
        }
      }
    }
  }
}

class PlayerDot extends PositionComponent /* with HasHitboxes, Collidable */ {
  static final Paint _white = BasicPalette.white.paint();

  HitboxCircle hitbox;
  int playerSize;

  PlayerDot(this.playerSize)
      : hitbox = HitboxCircle(normalizedRadius: playerSize as double),
        super() {
    //addHitbox(hitbox);
  }

  void scorePoint() {
    this.playerSize++;
    //hitbox.normalizedRadius = playerSize as double;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawCircle(Offset.zero, playerSize as double, _white);
  }
}

class Dot extends PositionComponent {
  static final Paint _white = BasicPalette.white.paint();
  static final List<double> _sizes = [30, 10, -2];
  Vector2 velocity = Vector2.zero();
  double dotSize = 5.0;
  Vector2 bounds;

  Dot(this.bounds, {dependentSize: double}) : super() {
    // allow angles to vary

    var rng = Random();
    dotSize = dependentSize += _sizes[rng.nextInt(3)];
    //addHitbox(HitboxCircle(normalizedRadius: dotSize));

    var num = rng.nextInt(4);
    var launchAngle = num * pi / 2.0;
    launchAngle += (rng.nextDouble() * 2.0 - 1.0) * (pi / 3.0);
    this.velocity = Vector2(cos(launchAngle), sin(launchAngle)) * 50;
    switch (num) {
      case 0:
        this.position =
            Vector2(-dotSize, rng.nextDouble() * bounds.y); // Going Right
        break;
      case 1:
        this.position =
            Vector2(rng.nextDouble() * bounds.x, -dotSize); // Going up
        break;
      case 2:
        this.position = Vector2(
            bounds.x + dotSize, rng.nextDouble() * bounds.y); // Going Left
        break;
      case 3:
        this.position = Vector2(
            rng.nextDouble() * bounds.x, bounds.y + dotSize); // Going Down
        break;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;

    if (this.position.x > bounds.x + dotSize || this.position.x < -dotSize) {
      this.removeFromParent();
    }
    if (this.position.y > bounds.y + dotSize || this.position.y < -dotSize) {
      this.removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawCircle(Offset.zero, dotSize, _white);
  }
}
