import 'package:untitled4/src/algorithm.dart';
import 'package:untitled4/src/cube.dart';
import 'package:untitled4/src/move.dart';
import 'package:equatable/equatable.dart';

/// Represents a list of [Move]s to solve the [Cube].
class Solution extends Equatable {
  /// The moves of the [Solution].
  final Algorithm algorithm;

  /// Elapsed time to find the [Solution].
  final Duration elapsedTime;

  /// Creates a [Solution] instance.
  const Solution({
    this.algorithm = Algorithm.empty,
    this.elapsedTime = const Duration(),
  });

  /// Empty solution.
  static const empty = Solution();

  /// The number of moves of the [Solution].
  int get length => algorithm.length;

  /// Returns true if there are no moves in the [Solution].
  bool get isEmpty => length == 0;

  /// Returns true if there is at least one move in the [Solution].
  bool get isNotEmpty => !isEmpty;

  @override
  String toString() => algorithm.toString();

  @override
  List<Object> get props => [algorithm];
}
