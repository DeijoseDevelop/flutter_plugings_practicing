import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SlideShow extends StatelessWidget {
  const SlideShow({
    super.key,
    required this.slides,
    this.upPoints = false,
    this.primaryColor = Colors.blue,
    this.secondaryColor = Colors.grey,
    this.primaryBullet = 12,
    this.secondaryBullet = 12,
  });

  final List<Widget> slides;
  final bool upPoints;
  final Color primaryColor;
  final Color secondaryColor;
  final double primaryBullet;
  final double secondaryBullet;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _SlideshowModel(),
      child: SafeArea(
        child: Center(
          child: Builder(builder: (BuildContext context) {
            context.read<_SlideshowModel>().primaryColor = primaryColor;
            context.read<_SlideshowModel>().secondaryColor = secondaryColor;
            context.read<_SlideshowModel>().primaryBullet = primaryBullet;
            context.read<_SlideshowModel>().secondaryBullet = secondaryBullet;
            return _CreateSlideshowStructure(
                upPoints: upPoints, slides: slides);
          }),
        ),
      ),
    );
  }
}

class _CreateSlideshowStructure extends StatelessWidget {
  const _CreateSlideshowStructure({
    Key? key,
    required this.upPoints,
    required this.slides,
  }) : super(key: key);

  final bool upPoints;
  final List<Widget> slides;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (upPoints) _Dots(slides.length),
        Expanded(
          child: _Slides(slides),
        ),
        if (!upPoints) _Dots(slides.length),
      ],
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots(this.totalSlides);
  final int totalSlides;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      // color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          totalSlides,
          (int index) => _Dot(index),
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot(this.index);
  final int index;

  @override
  Widget build(BuildContext context) {
    final _SlideshowModel slideShowModel = context.watch<_SlideshowModel>();
    double tamano = 0;
    late Color color;
    if (slideShowModel.currentPage >= index - 0.5 &&
        slideShowModel.currentPage < index + 0.5) {
      tamano = slideShowModel.primaryBullet;
      color = slideShowModel.primaryColor;
    } else {
      tamano = slideShowModel.secondaryBullet;
      color = slideShowModel.secondaryColor;
    }
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      width: tamano,
      height: tamano,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  const _Slides(this.slides);
  final List<Widget> slides;

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  final PageController pageViewController = PageController();

  @override
  void initState() {
    pageViewController.addListener(() {
      context.read<_SlideshowModel>().currentPage = pageViewController.page!;
    });
    super.initState();
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageViewController,
      children: widget.slides.map((slide) => _Slide(slide)).toList(),
    );
  }
}

class _Slide extends StatelessWidget {
  const _Slide(this.slide);
  final Widget slide;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(30.0),
      child: slide,
    );
  }
}

class _SlideshowModel extends ChangeNotifier {
  double _currentPage = 0;
  Color _primaryColor = Colors.blue;
  Color _secondaryColor = Colors.grey;
  double _primaryBullet = 12;
  double _secondaryBullet = 12;

  double get currentPage => _currentPage;

  set currentPage(double newPage) {
    _currentPage = newPage;
    // print('newPage: $newPage');
    notifyListeners();
  }

  Color get primaryColor => _primaryColor;
  set primaryColor(Color newPrimaryColor) {
    _primaryColor = newPrimaryColor;
    notifyListeners();
  }

  Color get secondaryColor => _secondaryColor;
  set secondaryColor(Color newSecondaryColor) {
    _secondaryColor = newSecondaryColor;
    notifyListeners();
  }

  double get primaryBullet => _primaryBullet;
  set primaryBullet(double newPrimaryBullet) {
    _primaryBullet = newPrimaryBullet;
    notifyListeners();
  }

  double get secondaryBullet => _secondaryBullet;
  set secondaryBullet(double newSecondaryBullet) {
    _secondaryBullet = newSecondaryBullet;
    notifyListeners();
  }
}
