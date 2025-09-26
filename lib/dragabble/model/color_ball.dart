import 'dart:ui';

import 'package:flutter/material.dart';

class ColorBall {
  final String id;
  final Color color;
  final String name;
  bool isMatched;

  ColorBall({
    required this.id,
    required this.color,
    required this.name,
    this.isMatched = false,
  });

  static List<ColorBall> balls = [
    ColorBall(id: '1', color: Colors.red, name: 'Red'),
    ColorBall(id: '2', color: Colors.blue, name: 'Blue'),
    ColorBall(id: '3', color: Colors.green, name: 'Green'),
    ColorBall(id: '4', color: Colors.orange, name: 'Orange'),
  ];
}
