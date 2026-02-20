import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShimmerEffectLayer extends StatefulWidget {
  final Widget child;
  const ShimmerEffectLayer({super.key, required this.child});

  @override
  State<ShimmerEffectLayer> createState() => _ShimmerEffectLayerState();
}

class _ShimmerEffectLayerState extends State<ShimmerEffectLayer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  )..repeat();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return FractionalTranslation(
              translation: Offset(_controller.value * 2 - 1, 0),
              child: Container(
                decoration: BoxDecoration(
                  // gradient: LinearGradient(
                  //   colors: [
                  //     Colors.grey,
                  //     // Colors.white.withOpacity(0.5),
                  //     // Colors.white.withOpacity(0.0),
                  //   ],
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomRight,
                  // ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
