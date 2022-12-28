import 'package:flutter/material.dart';
import 'dart:math' as Math;
import 'dart:ui';

class RadialProgress extends StatefulWidget {
  final double percentage;
  final Color primaryColor;
  final Color secondaryColor;
  final double primaryWeight;
  final double secondaryWeight;
  final int percentageTitleFontSize;
  final List<Color>? colors;

  const RadialProgress({
    super.key,
    required this.percentage,
    this.primaryColor = Colors.blue,
    this.secondaryColor = Colors.grey,
    this.secondaryWeight = 4,
    this.primaryWeight = 10,
    this.percentageTitleFontSize = 30,
    this.colors,
  });

  @override
  State<RadialProgress> createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late double previousPercentage;

  @override
  void initState() {
    previousPercentage = widget.percentage;
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward(from: 0.0);
    final double animateDifference = widget.percentage - previousPercentage;
    previousPercentage = widget.percentage;
    final Size size = MediaQuery.of(context).size;
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) {
          final double data = (widget.percentage - animateDifference) +
              (animateDifference * controller.value);
          return Container(
            padding: const EdgeInsets.all(10.0),
            width: size.width,
            height: size.height,
            child: Stack(children: <Widget>[
              SizedBox.expand(
                child: CustomPaint(
                  painter: _MyRadialProgressPainter(
                    data,
                    widget.primaryColor,
                    widget.secondaryColor,
                    widget.secondaryWeight,
                    widget.primaryWeight,
                    widget.percentageTitleFontSize,
                    widget.colors ?? [],
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    '${data.round()}%',
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                  )),
            ]),
          );
        });
  }
}

class _MyRadialProgressPainter extends CustomPainter {
  _MyRadialProgressPainter(
    this.percentage,
    this.primaryColor,
    this.secondaryColor,
    this.secondaryWeight,
    this.primaryWeight,
    this.percentageTitleFontSize,
    this.colors,
  );
  final double percentage;
  final Color primaryColor;
  final Color secondaryColor;
  final double primaryWeight;
  final double secondaryWeight;
  final int percentageTitleFontSize;
  final List<Color> colors;

  @override
  void paint(Canvas canvas, Size size) {
    // complete circle
    Paint paint = Paint()
      ..strokeWidth = secondaryWeight
      ..color = secondaryColor
      ..style = PaintingStyle.stroke;

    Offset center = Offset(size.width * 0.5, size.height * 0.5);
    double radius = Math.min(size.width * 0.5, size.height * 0.5);

    canvas.drawCircle(center, radius, paint);

    // arc
    Paint paintArc = Paint()
      ..strokeWidth = primaryWeight
      // ..color = primaryColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    if (colors.isNotEmpty) {
      final Rect rect =
          Rect.fromCircle(center: const Offset(0, 0), radius: 180);
      final Gradient gradient = LinearGradient(colors: colors);
      paintArc.shader = gradient.createShader(rect);
    }
    if (colors.isEmpty) paintArc.color = primaryColor;

    double arcAngle = 2 * Math.pi * (percentage / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -Math.pi / 2,
      arcAngle,
      false,
      paintArc,
    );
  }

  @override
  bool shouldRepaint(_MyRadialProgressPainter oldDelegate) => true;
}
