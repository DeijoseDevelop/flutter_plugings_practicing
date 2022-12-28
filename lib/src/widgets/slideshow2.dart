import 'package:flutter/material.dart';

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
    return _CustomProvider(
      sliderModelBLOC: _SliderModelBLOC(),
      child: SafeArea(
        child: Center(
          child: Builder(builder: (BuildContext context) {
            final sliderModelBLOC = _CustomProvider.of(context).sliderModelBLOC;
            sliderModelBLOC.setPrimaryBullet(primaryBullet);
            sliderModelBLOC.setSecondaryBullet(secondaryBullet);
            return Column(
              children: <Widget>[
                if (upPoints)
                  _Dots(slides.length, primaryColor, secondaryColor),
                Expanded(
                  child: _Slides(slides),
                ),
                if (!upPoints)
                  _Dots(slides.length, primaryColor, secondaryColor),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots(this.totalSlides, this.primaryColor, this.secondaryColor);
  final int totalSlides;
  final Color primaryColor;
  final Color secondaryColor;

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
          (int index) => _Dot(index, primaryColor, secondaryColor),
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot(this.index, this.primaryColor, this.secondaryColor);
  final int index;
  final Color primaryColor;
  final Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    final sliderModelBLOC = _CustomProvider.of(context).sliderModelBLOC;
    return ValueListenableBuilder<int>(
        valueListenable: sliderModelBLOC.currentIndex,
        builder: (BuildContext context, int value, Widget? child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            width: value == index
                ? sliderModelBLOC.primaryBullet.value
                : sliderModelBLOC.secondaryBullet.value,
            height: value == index
                ? sliderModelBLOC.primaryBullet.value
                : sliderModelBLOC.secondaryBullet.value,
            decoration: BoxDecoration(
              color: value == index ? primaryColor : secondaryColor,
              shape: BoxShape.circle,
            ),
          );
        });
  }
}

class _Slides extends StatelessWidget {
  _Slides(this.slides);
  final List<Widget> slides;

  final PageController pageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    final sliderModelBLOC = _CustomProvider.of(context).sliderModelBLOC;
    return PageView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      controller: pageViewController,
      onPageChanged: (int value) => sliderModelBLOC.setCurrentIndex(value),
      children: slides.map((slide) => _Slide(slide)).toList(),
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

class _CustomProvider extends InheritedWidget {
  const _CustomProvider({
    required super.child,
    required this.sliderModelBLOC,
  });

  final _SliderModelBLOC sliderModelBLOC;

  static _CustomProvider of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<_CustomProvider>()!;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}

class _SliderModelBLOC {
  ValueNotifier<int> currentIndex = ValueNotifier(0);
  ValueNotifier<double> primaryBullet = ValueNotifier(0.0);
  ValueNotifier<double> secondaryBullet = ValueNotifier(0.0);

  setCurrentIndex(int index) {
    currentIndex.value = index;
  }

  setPrimaryBullet(double bullet) {
    primaryBullet.value = bullet;
  }

  setSecondaryBullet(double bullet) {
    secondaryBullet.value = bullet;
  }
}
