import 'dart:math';

import 'package:fit_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 0.0,
        children: [
          _card("Steps", Color(0xFFFDC830), Color(0xFFF37335),
              Icon(Icons.sports_football_sharp)),
          _card("Sleep", Color(0xFF00B4DB), Color(0xFF0083B0),
              Icon(Icons.bed_sharp)),
          _card("Heartbeat", Color(0xFF00b09b), Color(0xFF96c93d),
              Icon(Icons.heart_broken)),
          _card(
              "Water", Color(0xFF4e54c8), Color(0xFF8f94fb), Icon(Icons.water))
        ],
      ),
    );
  }
}

Widget _card(String header, Color start, Color end, Icon icon) {
  return Stack(children: [
    Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          gradient: LinearGradient(
              begin: Alignment(-1.0, -4.0),
              end: Alignment(1.0, 4.0),
              colors: [
                start,
                end,
              ]),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 5.0,
            )
          ]),
      child: Column(children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
              child: Text(
                header,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
        Expanded(
          child: Container(
            child: SfRadialGauge(axes: <RadialAxis>[
              RadialAxis(
                  showLabels: false,
                  showTicks: false,
                  minimum: 0,
                  maximum: 100,
                  radiusFactor: 0.9,
                  axisLineStyle: AxisLineStyle(
                      thickness: 0.2,
                      thicknessUnit: GaugeSizeUnit.factor,
                      cornerStyle: CornerStyle.bothCurve),
                  pointers: <GaugePointer>[
                    RangePointer(
                      value: 60,
                      width: 0.2,
                      sizeUnit: GaugeSizeUnit.factor,
                      cornerStyle: CornerStyle.bothCurve,
                      gradient: const SweepGradient(
                          colors: <Color>[Color(0xFFCC2B5E), Color(0xFF753A88)],
                          stops: <double>[0.25, 0.75]),
                    )
                  ]),
            ]),
          ),
        )
      ]),
    ),
    Positioned(
      top: 0,
      left: 200,
      child: MyArc(100),
    ),
    Positioned(
      child: icon,
      top: 8,
      left: 168,
    )
  ]);
}

class ProgressBar extends CustomPainter {
  Color lineColor;
  ProgressBar(this.lineColor);

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    double percent = 0.5;
    var paint = Paint()
      ..color = Colors.white38
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
        Offset(0, size.height / 2), Offset(size.width, size.height / 2), paint);
    paint.color = lineColor;
    canvas.drawLine(Offset(0, size.height / 2),
        Offset(percent * size.width, size.height / 2), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

class MyArc extends StatelessWidget {
  final double diameter;

  MyArc(this.diameter);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(),
      size: Size(diameter, diameter),
    );
  }
}

// This is the Painter class
class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white38;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(0.0, 0.0),
        height: size.height,
        width: size.width,
      ),
      pi / 2,
      pi / 2,
      true,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
