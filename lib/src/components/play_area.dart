import 'dart:async';
import 'dart:developer';

import 'package:brick_breaker/src/config.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class PlayArea extends RectangleComponent with HasGameReference {
  PlayArea()
      : super(
          paint: Paint()..color = const Color(0xfff2e8cf),
          children: [RectangleHitbox()],
        );

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    log("Play Area - Loading...");
    size = Vector2(gameWidth, gameHeight);
  }
}
