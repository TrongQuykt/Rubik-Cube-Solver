import 'package:flutter/material.dart';
import 'package:untitled4/src/cube.dart';
import 'package:untitled4/src/kociemba_solver.dart';
import 'package:untitled4/src/color.dart' as cube_color;
import 'package:cuber/src/color.dart' as cuber_color;



void main() {
  runApp(const RubikSolverApp());
}

class RubikSolverApp extends StatelessWidget {
  const RubikSolverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rubik Solver',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RubikSolverScreen(),
    );
  }

}


class RubikSolverScreen extends StatefulWidget {
  const RubikSolverScreen({super.key});

  @override
  State<RubikSolverScreen> createState() => _RubikSolverScreenState();
}

class _RubikSolverScreenState extends State<RubikSolverScreen> {
  Cube cube = Cube.solved; // Khởi tạo Rubik đã giải
  Color selectedColor = Colors.red; // Màu được chọn
  List<String> solutionSteps = []; // Các bước giải

  void scrambleCube() {
    setState(() {
      cube = Cube.scrambled(n: 20); // Xáo trộn Rubik
      solutionSteps.clear();
    });
  }

  void solveCube() {
    setState(() {
      solutionSteps.clear();
      final solver = KociembaSolver(); // Sử dụng KociembaSolver
      final solution = solver.solve(cube);

      if (solution != null && solution.isNotEmpty) {
        solutionSteps = solution.algorithm.toString().split(' ');
      } else {
        solutionSteps.add('No solution found.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rubik Solver'),
      ),
      body: Column(
        children: [
          // Hiển thị Rubik
          Expanded(
            flex: 2,
            child: Center(
              child: _buildRubikGrid(),
            ),
          ),
          // Thanh chọn màu
          _buildColorPicker(),
          // Các nút chức năng
          _buildActionButtons(),
          // Hiển thị các bước giải
          _buildSolutionSteps(),
        ],
      ),
    );
  }

  Widget _buildRubikGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Chỉ 3 ô mỗi hàng
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      itemCount: 54, // Tổng số ô (6 mặt x 9 ô)
      itemBuilder: (context, index) {
        final cubeFaceColor = cube.colors[index];

        // Kiểm tra cubeFaceColor có phải là cube_color.Color hay không
        return GestureDetector(
          onTap: () {
            setState(() {
              final mappedColor = _mapFlutterColorToCubeColor(selectedColor);
              if (mappedColor != null) {
                cube.updateColor(index, mappedColor);
              }
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: _mapCubeColorToFlutterColor(
                cubeFaceColor is cube_color.Color ? cubeFaceColor : cube_color.Color.up,
              ),
              border: Border.all(color: Colors.black, width: 1),
            ),
          ),
        );
      },

    );
  }



// Trả về chỉ số của mặt Rubik tương ứng tại vị trí (row, col) trong lưới 4x3
  int _getFaceIndex(int row, int col) {
    if (row == 1 && col == 1) return 0; // Mặt trên
    if (row == 0 && col == 1) return 1; // Mặt trái
    if (row == 1 && col == 0) return 2; // Mặt trước
    if (row == 1 && col == 2) return 3; // Mặt phải
    if (row == 2 && col == 1) return 4; // Mặt dưới
    if (row == 3 && col == 1) return 5; // Mặt sau
    return -1; // Không thuộc mặt nào
  }

  Widget _buildFaceGrid(int faceIndex) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Mỗi hàng có 3 ô
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      physics: const NeverScrollableScrollPhysics(), // Tắt cuộn
      itemCount: 9, // Mỗi mặt có 9 ô
      itemBuilder: (context, index) {
        // Tính chỉ số ô màu trong danh sách colors
        final globalIndex = faceIndex * 9 + index;
        final cubeFaceColor = cube.colors[globalIndex];

        return GestureDetector(
          onTap: () {
            setState(() {
              final mappedColor = _mapFlutterColorToCubeColor(selectedColor);
              if (mappedColor != null) {
                cube.updateColor(globalIndex, mappedColor);
              }
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: _mapCubeColorToFlutterColor(cubeFaceColor as cube_color.Color),
              border: Border.all(color: Colors.black, width: 1), // Thêm viền
            ),
          ),
        );
      },
    );
  }


// Xây dựng từng mặt Rubik
  Widget _buildRubikFace(int faceIndex) {
    return Container(
      margin: const EdgeInsets.all(2),
      child: Column(
        children: List.generate(3, (row) {
          return Row(
            children: List.generate(3, (col) {
              final colorIndex = faceIndex * 9 + row * 3 + col;
              final cubeFaceColor = cube.colors[colorIndex];

              return GestureDetector(
                onTap: () {
                  setState(() {
                    final mappedColor = _mapFlutterColorToCubeColor(selectedColor);
                    if (mappedColor != null) {
                      cube.updateColor(colorIndex, mappedColor);
                    }
                  });
                },
                child: Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: _mapCubeColorToFlutterColor(cubeFaceColor as cube_color.Color),
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                ),
              );
            }),
          );
        }),
      ),
    );
  }







  Widget _buildColorPicker() {
    final colors = [
      Colors.yellow, Colors.orange, Colors.green,
      Colors.white, Colors.red, Colors.blue,
    ];

    return Container(
      height: 80, // Tăng chiều cao để dễ chọn hơn
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: colors.map((color) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedColor = color; // Cập nhật màu được chọn
              });
            },
            child: Container(
              width: 50,
              height: 50,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: color,
                border: Border.all(
                  color: selectedColor == color ? Colors.black : Colors.transparent,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }


  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: scrambleCube,
          child: const Text('Scramble'),
        ),
        ElevatedButton(
          onPressed: solveCube,
          child: const Text('Solve'),
        ),
      ],
    );
  }

  Widget _buildSolutionSteps() {
    return Expanded(
      child: ListView.builder(
        itemCount: solutionSteps.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(solutionSteps[index]),
          );
        },
      ),
    );
  }

  Color _mapCubeColorToFlutterColor(dynamic cubeColor) {
    if (cubeColor is cube_color.Color) {
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
    } else if (cubeColor is cuber_color.Color) {
      // Thêm logic chuyển đổi nếu cần.
      return Colors.grey; // Mặc định, nếu cần hỗ trợ chuyển đổi thêm.
    } else {
      return Colors.grey;
    }
  }


  cube_color.Color? _mapFlutterColorToCubeColor(Color flutterColor) {
    if (flutterColor == Colors.yellow) return cube_color.Color.up;
    if (flutterColor == Colors.orange) return cube_color.Color.right;
    if (flutterColor == Colors.green) return cube_color.Color.front;
    if (flutterColor == Colors.white) return cube_color.Color.down;
    if (flutterColor == Colors.red) return cube_color.Color.left;
    if (flutterColor == Colors.blue) return cube_color.Color.bottom;
    return null;
  }
}
