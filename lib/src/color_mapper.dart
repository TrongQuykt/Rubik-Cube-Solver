import 'package:flutter/material.dart';
import 'package:untitled4/src/color.dart' as cube_color;

cube_color.Color? _mapFlutterColorToCubeColor(cube_color.Color flutterColor) {
  if (flutterColor == Colors.yellow) return cube_color.Color.up;
  if (flutterColor == Colors.orange) return cube_color.Color.right;
  if (flutterColor == Colors.green) return cube_color.Color.front;
  if (flutterColor == Colors.white) return cube_color.Color.down;
  if (flutterColor == Colors.red) return cube_color.Color.left;
  if (flutterColor == Colors.blue) return cube_color.Color.bottom;
  return null;
}

Color _mapCubeColorToFlutterColor(cube_color.Color cubeColor) {
  switch (cubeColor) {
    case cube_color.Color.up:
      return Colors.yellow;
    case cube_color.Color.right:
      return Colors.orange;
    case cube_color.Color.front:
      return Colors.green;
    case cube_color.Color.down:
      return Colors.white;
    case cube_color.Color.left:
      return Colors.red;
    case cube_color.Color.bottom:
      return Colors.blue;
    default:
      return Colors.grey;
  }
}
