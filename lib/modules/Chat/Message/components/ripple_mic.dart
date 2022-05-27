import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:helpy_app/modules/onBoarding/widget/circle_painter.dart';
import 'package:helpy_app/modules/onBoarding/widget/curve_wave.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';

class RipplesMicAnimation extends StatefulWidget {
  const RipplesMicAnimation({
    Key? key,
    this.size = 25.0,
    this.color = Colors.transparent,
    this.onPressed,
    this.child,
  }) : super(key: key);
  final double size;
  final Color color;
  final Widget? child;
  final VoidCallback? onPressed;
  @override
  _RipplesMicAnimationState createState() => _RipplesMicAnimationState();
}

class _RipplesMicAnimationState extends State<RipplesMicAnimation>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  Widget _button() {
    return ClipRRect(
        borderRadius: BorderRadius.circular(widget.size),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: <Color>[
                Colors.red[200]!,
                Color.lerp(widget.color, Colors.blueGrey[700], .05)!
              ],
            ),
          ),
          child: ScaleTransition(
              scale: Tween(begin: 0.95, end: 1.0).animate(
                CurvedAnimation(
                  parent: _controller!,
                  curve: const CurveWave(),
                ),
              ),
              child: const Icon(
                Icons.mic,
                color: Colors.white,
              )),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CirclePainter(_controller!, color: Colors.amber),
      child: SizedBox(
        width: widget.size * 4.125,
        height: widget.size * 4.125,
        child: _button(),
      ),
    );
  }
}
