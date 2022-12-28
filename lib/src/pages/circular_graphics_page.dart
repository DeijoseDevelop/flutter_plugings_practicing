import 'dart:ui';

import 'package:disenos_app/src/widgets/radial_progress.dart';
import 'package:flutter/material.dart';

class CircularGraphics extends StatefulWidget {
  const CircularGraphics({super.key});

  @override
  State<CircularGraphics> createState() => _CircularGraphicsState();
}

class _CircularGraphicsState extends State<CircularGraphics> {
  double percentage = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            percentage += 10;
            if (percentage > 100) percentage = 0;
          });
        },
        child: const Icon(Icons.refresh),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomRadialProgress(percentage: percentage, color: Colors.blue),
              CustomRadialProgress(percentage: percentage, color: Colors.red)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomRadialProgress(
                  percentage: percentage, color: Colors.yellow),
              CustomRadialProgress(percentage: percentage, color: Colors.purple)
            ],
          ),
        ],
      ),
    );
  }
}

class CustomRadialProgress extends StatelessWidget {
  const CustomRadialProgress({
    Key? key,
    required this.percentage,
    required this.color,
  }) : super(key: key);

  final double percentage;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 180,
      // color: Colors.red,
      child: RadialProgress(
        percentage: percentage,
        primaryWeight: 10,
        secondaryWeight: 15,
        colors: const <Color>[
          Color(0xffC012FF),
          Color(0xff6D05E8),
          Colors.red,
        ],
      ),
    );
  }
}
