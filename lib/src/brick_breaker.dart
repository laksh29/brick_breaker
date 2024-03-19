import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:brick_breaker/src/components/components.dart';
import 'package:brick_breaker/src/config.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class BrickBreak extends FlameGame with HasCollisionDetection {
  BrickBreak()
      : super(
          camera: CameraComponent.withFixedResolution(
            height: gameHeight,
            width: gameWidth,
          ),
        );

  double get height => size.x;
  double get width => size.y;

  final rand = math.Random();

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    log("Brick Break - Loading...");

    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(PlayArea());

    world.add(
      Ball(
        difficultyModifier: 0,
        velocity: Vector2((rand.nextDouble() - 0.5) * width, -height * 0.2)
            .normalized()
          ..scale(height / 2),
        position: size / 2,
        radius: ballRadius,
      ),
    );

    world.add(
      Bat(
        cornerRadius: const Radius.circular(ballRadius / 2),
        size: Vector2(batWidth, batHeight),
        position: Vector2(width / 2, height * 0.95),
      ),
    );

    await world.addAll([
      for (var i = 0; i < brickColors.length; i++)
        for (var j = 1; j <= 5; j++)
          Brick(
            position: Vector2(
              (i + 0.5) * brickWidth + (i + 1) * brickGutter,
              (j + 2.0) * brickHeight + j * brickGutter,
            ),
            color: brickColors[i],
          ),
    ]);

    debugMode = true;
  }

  // @override
  // KeyEventResult onKeyEvent(
  //     KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
  //   // super.onKeyEvent(event, keysPressed);

  //   switch (event.logicalKey) {
  //     case LogicalKeyboardKey.arrowLeft:
  //       world.children.query<Bat>().first.moveBy(-batStep);
  //     case LogicalKeyboardKey.arrowRight:
  //       world.children.query<Bat>().first.moveBy(batStep);
  //   }
  //   return KeyEventResult.handled;
  // }
}
