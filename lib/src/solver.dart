import 'package:untitled4/src/cube.dart';
import 'package:untitled4/src/solution.dart';

/// Represents a [Cube] solver algorithm.
abstract class Solver {
  ///
  const Solver();

  /// Default maximum mumber of [Solution]'s moves.
  static const defaultMaxDepth = 25;

  /// Default timeout for solve the [Cube].
  static const defaultTimeout = Duration(seconds: 30);

  /// Returns the [Solution] for the [cube] with a maximum of
  /// [maxDepth] moves
  /// or `null` if the [timeout] is exceeded or there is no [Solution].
  ///
  /// Returns [Solution.empty] if the [cube] is already solved.
  Solution? solve(
    Cube cube, {
    int maxDepth = defaultMaxDepth,
    Duration timeout = defaultTimeout,
  });

  /// Gets the [Solution]s as much as possible until the
  /// minimum number of moves is reached or the [timeout] is exceeded.
  Stream<Solution> solveDeeply(
    Cube cube, {
    Duration timeout = defaultTimeout,
  }) async* {
    var maxDepth = Solver.defaultMaxDepth;
    final solutions = <Solution>{};
    final sw = Stopwatch()..start();

    while (sw.elapsed < timeout) {
      final s = solve(
        cube,
        maxDepth: maxDepth,
        timeout: timeout - sw.elapsed,
      );

      if (maxDepth > 0 && s != null && s.isNotEmpty) {
        if (!solutions.contains(s)) {
          solutions.add(s);
          yield Solution(algorithm: s.algorithm, elapsedTime: sw.elapsed);
          maxDepth = s.length - 1;
        } else {
          maxDepth--;
        }
      } else {
        break;
      }
    }
  }
}
