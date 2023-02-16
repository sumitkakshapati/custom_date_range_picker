import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ValueListenableBuilder2<Listenable1Type, Listenable2Type>
    extends StatelessWidget {
  final ValueListenable<Listenable1Type> listener1;
  final ValueListenable<Listenable2Type> listener2;
  final Widget Function(BuildContext, Listenable1Type, Listenable2Type) builder;

  const ValueListenableBuilder2({
    super.key,
    required this.listener1,
    required this.listener2,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Listenable1Type>(
      valueListenable: listener1,
      builder: (context, value, child) {
        return ValueListenableBuilder<Listenable2Type>(
          valueListenable: listener2,
          builder: (context, value2, child) {
            return builder(context, value, value2);
          },
        );
      },
    );
  }
}
