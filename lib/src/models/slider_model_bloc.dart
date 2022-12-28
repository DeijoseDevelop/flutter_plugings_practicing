import 'package:flutter/material.dart';

class CustomProvider extends InheritedWidget {
  const CustomProvider({
    required super.child,
    super.key,
    required this.sliderModelBLOC,
  });

  final SliderModelBLOC sliderModelBLOC;

  static CustomProvider of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<CustomProvider>()!;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}

class SliderModelBLOC {
  ValueNotifier<int> currentIndex = ValueNotifier(0);

  setCurrentIndex(int index) {
    currentIndex.value = index;
  }
}