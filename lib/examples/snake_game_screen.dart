import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import "dart:ui";
import 'package:vector_math/vector_math.dart' as VecMath;
import 'dart:core';
import 'dart:math';
import '../utils/sky_image_loader.dart';

class SnakeData {
  List<Offset> snakeCorners;
  num _snakeLength;
  Offset walkDirection;
  num speed = 30.0;

  SnakeData(Offset beginPos, num beginLen, num speed) {
    walkDirection = Offset(1, 0);

    snakeCorners = List();
    snakeCorners.add(beginPos - walkDirection * beginLen);
    snakeCorners.add(beginPos);
    _snakeLength = beginLen;
  }

  step(num deltaTime) {
    if (snakeCorners.length < 2) {
      return;
    }
    Offset head = snakeCorners.last;
    Offset newHead = head + walkDirection * speed * deltaTime;
    Offset tail = snakeCorners.first;
    Offset tailDirection = _normalizeOffset(snakeCorners[1] - snakeCorners[0]);
    Offset newTail = tail + tailDirection * speed * deltaTime;
    if (!_offsetBetween(newTail, snakeCorners[1], snakeCorners[0]) || tailDirection.distance == 0) {
      snakeCorners.removeAt(0);
    } else {
      snakeCorners[0] = newTail;
    }
    snakeCorners[snakeCorners.length - 1] = newHead;
  }

  turn(Offset dir) {
    if (walkDirection == dir) {
      return;
    }
    walkDirection = dir;
    snakeCorners.add(Offset(snakeCorners.last.dx, snakeCorners.last.dy));
  }

  Offset _normalizeOffset(Offset input) {
    num len = input.distance;
    if (len == 0) {
      return Offset(0, 0);
    }
    return input / len;
  }

  bool _offsetBetween(Offset target, Offset src, Offset dst) {
    Offset v1 = src - target;
    Offset v2 = target - dst;
    num dotProduct = v1.dx * v2.dx + v1.dy * v2.dy;
    return dotProduct >= 0;
  }
}


class SnakePainter extends ChangeNotifier implements CustomPainter {

  SnakePainter({this.snakeData}) {
    ImageLoader.loadImage("assets/icons/gem_icon.png").then((image) {
      bgImage = image;
    });
  }

  final SnakeData snakeData;
  var bgImage;

  void forceRedraw() {
    notifyListeners();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(Color.fromARGB(0, 0, 0, 0), BlendMode.color);

    final paint = Paint();
    paint.color = Colors.red;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 5;

    final path = Path();
    var smoothLine = _smoothLine(snakeData.snakeCorners);
//    Offset head = smoothLine.last;
//    path.moveTo(head.dx, head.dy);
//    for (var pt in smoothLine.reversed) {
//      path.lineTo(pt.dx, pt.dy);
//    }
//    canvas.drawPath(path, paint);

    const snakeWidth = 10.0;
    const snakeHeadLen = 10.0;

    List<Offset> positions = List<Offset>();
    // snake header
    final headPos = smoothLine.last;
    final forwardVec = snakeData.walkDirection;
    final rightVec = _rotateOffset(snakeData.walkDirection, 90);
    positions.add(headPos + forwardVec * snakeHeadLen + rightVec * snakeWidth * 0.5);
    positions.add(headPos + forwardVec * snakeHeadLen - rightVec * snakeWidth * 0.5);
    positions.add(headPos + rightVec * snakeWidth * 0.5);
    positions.add(headPos - rightVec * snakeWidth * 0.5);

    Offset lastCorner = smoothLine.last;
    for (var i = smoothLine.length - 2; i >= 0; --i) {
      final currentCorner = smoothLine[i];
      final currentForwardVec = _normalizeOffset(lastCorner - currentCorner);
      final currentRightVec = _rotateOffset(currentForwardVec, 90);
      positions.add(currentCorner + currentRightVec * snakeWidth * 0.5);
      positions.add(currentCorner - currentRightVec * snakeWidth * 0.5);
      lastCorner = smoothLine[i];
    }

    List<Color> colors = List<Color>();
    for (var pos in positions) {
      colors.add(Colors.red);
    }

    final vertices = Vertices(VertexMode.triangleStrip, positions);
    canvas.drawVertices(vertices, BlendMode.color, paint);


    if (bgImage != null) {
      canvas.drawImage(bgImage, Offset(0, 0), paint);
    }

  }

  List<Offset> _smoothLine(List<Offset> line) {
    if (line.length == 2) {
      return line;
    }
    const cornerRadius = 20.0;
    List<Offset> smoothLine = List();
    for (var i = line.length - 2; i > 0; --i) {
      final prevPt = line[i + 1];
      final currentPt = line[i];
      final nextPt = line[i - 1];

      final prevLength = (prevPt - currentPt).distance;
      final nextLength = (currentPt - nextPt).distance;
      final prevVec =  _normalizeOffset(prevPt - currentPt);
      final nextVec = _normalizeOffset(nextPt - currentPt);
      final cornerCircleCenter = (prevVec + nextVec) * cornerRadius + currentPt;


      var prevCircleBeginPoint= prevPt;
      if (prevLength > cornerRadius) {
        if (i == line.length - 2) {
          smoothLine.add(prevPt);
        }
        prevCircleBeginPoint = currentPt + prevVec * cornerRadius;
      }

      var nextCircleBeginPoint= nextPt;
      if (nextLength > cornerRadius) {
        nextCircleBeginPoint = currentPt + nextVec * cornerRadius;
      }

      final beginVec = _normalizeOffset(prevCircleBeginPoint - cornerCircleCenter);
      final endVec = _normalizeOffset(nextCircleBeginPoint - cornerCircleCenter);

      const segments = 5;
      for (var seg = 0; seg <= segments; ++seg) {
        final percent = seg / segments;
        smoothLine.add( _normalizeOffset(beginVec * (1.0 - percent) + endVec * percent) * cornerRadius + cornerCircleCenter);
      }

      if (nextLength > cornerRadius) {
        if (i == 1) {
          smoothLine.add(nextPt);
        }
      }
    }
    return smoothLine;
  }

  Offset _rotateOffset(Offset input, double degree) {
    // rotate offset clockwise
    VecMath.Vector2 inputVec = VecMath.Vector2(input.dx, input.dy);
    final rotationMatrix = VecMath.Matrix3.rotationZ(VecMath.degrees2Radians * degree);
    VecMath.Vector2 outVec = inputVec.clone();
    rotationMatrix.transform2(outVec);
    return Offset(outVec.x, outVec.y);
  }

  Offset _normalizeOffset(Offset input) {
    final distance = input.distance;
    return input / distance;
  }

  @override
  bool hitTest(Offset position) => true;

  @override
  get semanticsBuilder => null;

  @override
  bool shouldRebuildSemantics(CustomPainter oldDelegate) => false;
}


class SnakeGameScreen extends StatefulWidget {
  // 贪吃蛇小游戏
  @override
  SnakeGameScreenState createState() => SnakeGameScreenState();
}

class SnakeGameScreenState extends State<SnakeGameScreen> {

  Ticker _ticker;
  SnakeData _snakeData;
  SnakePainter _snakePainter;
  @override
  void initState() {
    super.initState();
    _ticker = Ticker(_onTick);
    _snakeData = SnakeData(Offset(200, 200), 200.0, 2.0);
    _snakePainter = SnakePainter(
        snakeData: _snakeData
    );

    _ticker.start();
  }

  @override
  void dispose() {
    super.dispose();
    _ticker.dispose();
  }

  void _onTick(Duration timestamp) {
    _snakeData.step(1.0 / 40.0);
    _snakePainter.forceRedraw();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Snake"),
        ),
        body:
        GestureDetector(
          onTap: () {

          },
          onPanEnd: (DragEndDetails dragEndDetail) {
            final vx = dragEndDetail.velocity.pixelsPerSecond.dx;
            final vy = dragEndDetail.velocity.pixelsPerSecond.dy;
            if (vx.abs() > vy.abs()) {
              if (vx < 0) {
                _snakeData.turn(Offset(-1, 0));
              } else {
                _snakeData.turn(Offset(1, 0));
              }
            } else {
              if (vy < 0) {
                _snakeData.turn(Offset(0, -1));
              } else {
                _snakeData.turn(Offset(0, 1));
              }
            }
            _snakePainter.forceRedraw();
          },
          child: Container(
            alignment: Alignment.center,
            child:  CustomPaint(
                size: Size.fromHeight(400),
                painter: _snakePainter
            ),
          )
        )

    );
  }
}