import "package:flutter/material.dart";
import "dart:ui";
import "dart:typed_data";

class ShapePainter extends CustomPainter {

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final rotateMatrix = Matrix4.rotationZ(3.14 * 0.0);
    List<double> data = List(16);
    rotateMatrix.copyIntoArray(data);
    canvas.transform(Float64List.fromList(data));

    final painter = Paint();
    painter.color = Colors.red;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), painter);

    painter.color = Colors.green;
    painter.style = PaintingStyle.fill;
    canvas.drawCircle(Offset(50,50), 40, painter);
    painter.style = PaintingStyle.stroke;
    painter.strokeWidth = 4;
    painter.color = Colors.orange;
    canvas.drawCircle(Offset(50,50), 40, painter);


    painter.style = PaintingStyle.stroke;
    final path = Path();
    path.moveTo(100, 100);
    path.lineTo(120, 120);
    path.lineTo(120, 140);
    path.lineTo(100, 160);
    canvas.drawPath(path, painter);


    final positions = <Offset>[
      Offset(140, 140),
      Offset(100, 180),
      Offset(180, 180)
    ];
    final colors = <Color>[
      Colors.red,
      Colors.green,
      Colors.yellow
    ];
    final vertices = Vertices(VertexMode.triangles,
        positions.toList(),
    colors: colors);
    canvas.drawVertices(vertices, BlendMode.color, painter);

  }
}

class PaintScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("自定义绘图"),
      ),
      body: Container(
        alignment: Alignment.center,
        child:  CustomPaint(
          size: Size.fromHeight(400),
            painter: ShapePainter()
        ),
      )


    );
  }
}