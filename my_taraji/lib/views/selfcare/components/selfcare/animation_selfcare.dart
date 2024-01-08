import 'package:flutter/material.dart';

class AnimationSelfCareMenu extends StatefulWidget {
  const AnimationSelfCareMenu({
    super.key,
    required this.child,
    required this.animationDirection,
  });

  final Widget child;
  final double animationDirection;

  @override
  AnimationSelfCareMenuState createState() => AnimationSelfCareMenuState();
}

class AnimationSelfCareMenuState extends State<AnimationSelfCareMenu>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    initAnimation();

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void initAnimation() {
    _animation = Tween<Offset>(
      begin: Offset(widget.animationDirection, 0),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  Widget buildSlideTransition(Widget child) {
    return SlideTransition(
      position: _animation,
      child: child,
    );
  }

  void playAnimation() {
    initAnimation();
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    playAnimation();
    return buildSlideTransition(widget.child);
  }
}
