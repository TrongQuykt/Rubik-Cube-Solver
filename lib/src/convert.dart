import 'package:untitled4/src/color.dart' as cube_color;
import 'package:cuber/src/color.dart' as cuber_color;

cube_color.Color convertCuberColorToCubeColor(cuber_color.Color cuberColor) {
  switch (cuberColor) {
    case cuber_color.Color.up:
      return cube_color.Color.up;
    case cuber_color.Color.right:
      return cube_color.Color.right;
    case cuber_color.Color.front:
      return cube_color.Color.front;
    case cuber_color.Color.down:
      return cube_color.Color.down;
    case cuber_color.Color.left:
      return cube_color.Color.left;
    case cuber_color.Color.bottom:
      return cube_color.Color.bottom;
    default:
      throw ArgumentError('Invalid cuber_color.Color value: $cuberColor');
  }
}

cuber_color.Color convertCubeColorToCuberColor(cube_color.Color cubeColor) {
  switch (cubeColor) {
    case cube_color.Color.up:
      return cuber_color.Color.up;
    case cube_color.Color.right:
      return cuber_color.Color.right;
    case cube_color.Color.front:
      return cuber_color.Color.front;
    case cube_color.Color.down:
      return cuber_color.Color.down;
    case cube_color.Color.left:
      return cuber_color.Color.left;
    case cube_color.Color.bottom:
      return cuber_color.Color.bottom;
    default:
      throw ArgumentError('Invalid cube_color.Color value: $cubeColor');
  }
}
