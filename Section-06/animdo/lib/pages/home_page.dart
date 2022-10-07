import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  double _buttonRadius = 100;

  final Tween<double> _backgroundScale = Tween(begin: 0.0, end: 1.0);

  AnimationController? _starAnimController;

  @override
  void initState() {
    super.initState();
    _starAnimController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _starAnimController!.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              _pageBackground(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _circularAnimationButton(),
                  _starIcon(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _pageBackground() {
    return TweenAnimationBuilder(
      curve: Curves.easeInOutCubicEmphasized,
      builder: (BuildContext context, double value, Widget? child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      duration: const Duration(seconds: 1),
      tween: _backgroundScale,
      child: Container(color: Colors.blueAccent),
    );
  }

  Widget _circularAnimationButton() {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _buttonRadius += _buttonRadius == 200 ? -100 : 100;
          });
        },
        child: AnimatedContainer(
          height: _buttonRadius,
          width: _buttonRadius,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(_buttonRadius),
          ),
          duration: Duration(seconds: 2),
          curve: Curves.bounceInOut,
          child: Center(child: Text("Animated Widget")),
        ),
      ),
    );
  }

  Widget _starIcon() {
    return AnimatedBuilder(
      animation: _starAnimController!.view,
      builder: (BuildContext context, Widget? child) {
        return Transform.rotate(
          angle: _starAnimController!.value * 2 * pi, // in radian
          child: child,
        );
      },
      child: const Icon(
        Icons.star,
        size: 100,
        color: Colors.white,
      ),
    );
  }
}
