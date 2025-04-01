import 'package:flutter/material.dart';

void main() {
  runApp(CubePuzzleApp());
}

class CubePuzzleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '3D Küpün Sırrı',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CubeFaceScreen(),
    );
  }
}

class CubeFaceScreen extends StatefulWidget {
  @override
  _CubeFaceScreenState createState() => _CubeFaceScreenState();
}

class _CubeFaceScreenState extends State<CubeFaceScreen> {
  List<List<int>> face = [
    [1, 0, 0], // Kilit taşı sol üstte
    [0, 0, 0],
    [0, 0, 0],
  ];

  void rotateRow(int rowIdx, int direction) {
    setState(() {
      List<int> row = face[rowIdx];
      if (direction == 1) {
        face[rowIdx] = [row.last] + row.sublist(0, 2);
      } else {
        face[rowIdx] = row.sublist(1) + [row.first];
      }
    });
    checkWin();
  }

  void rotateCol(int colIdx, int direction) {
    setState(() {
      List<int> col = [face[0][colIdx], face[1][colIdx], face[2][colIdx]];
      if (direction == 1) {
        col = [col.last] + col.sublist(0, 2);
      } else {
        col = col.sublist(1) + [col.first];
      }
      for (int i = 0; i < 3; i++) {
        face[i][colIdx] = col[i];
      }
    });
    checkWin();
  }

  void checkWin() {
    if (face[1][1] == 1) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Tebrikler!'),
          content: Text('Kilit taşı ortada! Renklerin Efendisi sensin!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Tamam'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Küpün Sırrı - Kırmızı Yüz')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 3; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int j = 0; j < 3; j++)
                    GestureDetector(
                      onHorizontalDragEnd: (details) {
                        if (details.velocity.pixelsPerSecond.dx > 0) {
                          rotateRow(i, 1);
                        } else {
                          rotateRow(i, -1);
                        }
                      },
                      onVerticalDragEnd: (details) {
                        if (details.velocity.pixelsPerSecond.dy > 0) {
                          rotateCol(j, 1);
                        } else {
                          rotateCol(j, -1);
                        }
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        margin: EdgeInsets.all(2),
                        color: face[i][j] == 1 ? Colors.red : Colors.grey,
                        child: Center(
                          child: Text(
                            face[i][j] == 1 ? 'K' : '',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
