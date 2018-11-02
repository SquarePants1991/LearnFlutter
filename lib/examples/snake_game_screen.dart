import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SnakeData {
  List<Offset> snakeCorners;
  num _snakeLength;
  Offset _walkDirection;
  num speed = 1.0;

  SnakeData(Offset beginPos, num beginLen, num speed) {
    _walkDirection = Offset(1, 0);

    snakeCorners = List();
    snakeCorners.add(beginPos);
    snakeCorners.add(beginPos - _walkDirection * beginLen);
    _snakeLength = beginLen;
  }

  step(num deltaTime) {
    if (snakeCorners.length < 2) {
      return;
    }
    Offset head = snakeCorners.last;
    Offset newHead = head + _walkDirection * speed * deltaTime / 1000.0;
    Offset tail = snakeCorners.first;
    Offset tailDirection = _normalizeOffset(snakeCorners[1] - snakeCorners[0]);
    Offset newTail = tail + tailDirection * speed * deltaTime;
    if (!_offsetBetween(newTail, snakeCorners[1], snakeCorners[0])) {
      snakeCorners.removeAt(0);
    } else {
      snakeCorners[0] = newTail;
    }
    snakeCorners[snakeCorners.length - 1] = newHead;
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


class SnakePainter extends CustomPainter {

  SnakePainter({this.snakeData});

  final SnakeData snakeData;

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(Color.fromARGB(0, 0, 0, 0), BlendMode.color);

    final painter = Paint();
    painter.color = Colors.red;
    painter.style = PaintingStyle.stroke;
    final path = Path();
    Offset head = snakeData.snakeCorners.last;
    path.moveTo(head.dx, head.dy);
    for (var pt in snakeData.snakeCorners) {
      path.lineTo(pt.dx, pt.dy);
    }
    canvas.drawPath(path, painter);
  }
}


class SnakeGameScreen extends StatefulWidget {
  // 贪吃蛇小游戏
  @override
  SnakeGameScreenState createState() => SnakeGameScreenState();
}

class SnakeGameScreenState extends State<SnakeGameScreen> with SingleTickerProviderStateMixin {

  var _frameCallbackID;
  SnakeData _snakeData;
  @override
  void initState() {
    super.initState();
    _frameCallbackID = SchedulerBinding.instance.scheduleFrameCallback(_tick);
    _snakeData = SnakeData(Offset(200, 200), 20.0, 3.0);
  }

  @override
  void dispose() {
    super.dispose();
    SchedulerBinding.instance.cancelFrameCallbackWithId(_frameCallbackID);
  }

  void _tick(Duration timestamp) {
    setState(() {
      _snakeData.step(1.0 / 40.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Snake"),
        ),
        body: Container(
          alignment: Alignment.center,
          child:  CustomPaint(
              size: Size.fromHeight(400),
              painter: SnakePainter(
                snakeData: _snakeData
              )
          ),
        )
    );
  }
}