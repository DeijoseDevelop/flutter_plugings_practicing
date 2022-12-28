import 'package:flutter/material.dart';

class MultipleValueListenableBuilder<A, B, C> extends StatelessWidget {
  const MultipleValueListenableBuilder({
    required this.firstValue,
    required this.secondValue,
    required this.thirdValue,
    required this.child,
    super.key,
  });
  final ValueNotifier<A> firstValue;
  final ValueNotifier<B> secondValue;
  final ValueNotifier<C> thirdValue;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<A>(
      valueListenable: firstValue,
      builder: (BuildContext context, A primaryBullet, Widget? child) {
        return ValueListenableBuilder<B>(
          valueListenable: secondValue,
          builder: (BuildContext context, B secondaryBullet, Widget? child) {
            return ValueListenableBuilder<C>(
              valueListenable: thirdValue,
              builder: (BuildContext context, C pageViewIndex, Widget? child) {
                return this.child;
              },
            );
          },
        );
      },
    );
  }
}
