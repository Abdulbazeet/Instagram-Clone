import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class LikeAnimation extends StatefulWidget {
  final Widget childView;
  final bool isAnimating;
  final bool smallLike;
  final Duration duration;
  final VoidCallback? onEnd;

  const LikeAnimation(
      {super.key,
      required this.childView,
      required this.isAnimating,
      this.smallLike = false,
      this.duration = const Duration(milliseconds: 150),
       this.onEnd});

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scale;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.duration.inMilliseconds ~/ 2));
    scale = Tween<double>(begin: 1, end: 1.2).animate(controller);
  }

  @override
  void didUpdateWidget(covariant LikeAnimation oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimating != oldWidget.isAnimating) {
      startAnimating();
    }
  }

  startAnimating() async {
    if (widget.isAnimating || widget.smallLike) {
      await controller.forward();
      await controller.reverse();
      await Future.delayed(
        const Duration(milliseconds: 200),
      );
      if(widget.onEnd != null){
        widget.onEnd!();
      }
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: widget.childView,
    );
  }
}
