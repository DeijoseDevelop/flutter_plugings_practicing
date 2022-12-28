import 'package:disenos_app/src/pages/animations_page.dart';
import 'package:disenos_app/src/labs/circular_progress_page.dart';
import 'package:disenos_app/src/pages/circular_graphics_page.dart';
import 'package:disenos_app/src/pages/headers_page.dart';
import 'package:disenos_app/src/labs/slideshow_page.dart';
import 'package:disenos_app/src/pages/slideshow_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App design',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const App(),
    );
  }
}

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const CircularGraphics())),
                child: const Text('Radial'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SlideshowPage())),
                child: const Text('Slides'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/* class SplashPage extends StatelessWidget {
  const SplashPage({super.key, required this.widgetChild});
  final Widget widgetChild;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: <Widget>[
        Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100.0),
              child: widgetChild,
            )),
        const CustomBackground(),
      ]),
    );
  }
}

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200,
        height: 200,
        child: Image.asset(
          'assets/splash_logo.png',
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
        ));
  }
}

class CustomBackground extends StatelessWidget {
  const CustomBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      //color: const Color(0xff615AAB),
      child: CustomPaint(
        painter: _CustomBackgroundPainter(),
      ),
    );
  }
}

class _CustomBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect =
        Rect.fromCircle(center: const Offset(350.0, 150.0), radius: 180);

    const Gradient gradient = LinearGradient(colors: <Color>[
      Color(0xff2c1449),
      Color(0xff510e54),
      Color(0xff6a0c5b),
      Color(0xff7f0a5c),
    ]);

    /* const Gradient gradientRed = LinearGradient(colors: <Color>[
      Colors.redAccent,
      Colors.red,
    ]); */

    Paint paint = Paint()..shader = gradient.createShader(rect);
    // Paint paintRed = Paint()..shader = gradientRed.createShader(rect);
    Paint paintRed = Paint();
    Paint paintGrey = Paint();
    paintGrey.color = const Color(0xFFE8E1ED);
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2.0;

    paintRed.color = const Color(0xffb8054d);
    paintRed.style = PaintingStyle.fill;
    paintRed.strokeWidth = 20.0;

    paintGrey.style = PaintingStyle.fill;
    paintGrey.strokeWidth = 20.0;

    Path path = Path();

    Path pathRed = Path();

    Path pathGrey = Path();

    path.moveTo(size.width, size.height * 0.67);
    path.quadraticBezierTo(
        size.width * 0.5, size.height * 0.9, 0, size.height * 0.77);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);

    pathRed.moveTo(0, size.height * 0.77);
    pathRed.lineTo(0, size.height * 0.74);
    pathRed.quadraticBezierTo(
        size.width * 0.35, size.height * 0.86, size.width, size.height * 0.72);
    pathRed.lineTo(size.width, size.height * 0.75);
    pathRed.lineTo(size.width, size.height);
    pathRed.lineTo(0, size.height);

    pathGrey.moveTo(0, size.height * 0.74);
    pathGrey.lineTo(0, size.height * 0.69);
    pathGrey.quadraticBezierTo(
        size.width * 0.38, size.height * 0.85, size.width, size.height * 0.728);
    pathGrey.lineTo(size.width, size.height);
    pathGrey.lineTo(0, size.height);

    canvas.drawPath(pathGrey, paintGrey);
    canvas.drawPath(pathRed, paintRed);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CustomBackgroundPainter oldDelegate) => false;
}
 */