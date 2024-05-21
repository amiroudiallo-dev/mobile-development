// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  double _borderRadius = 200;
  final Tween<double> _backgroundScale = Tween(begin: 0.0, end: 1.0);
  AnimationController? _startIconAnimationController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                _startIcon(),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _startIconAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    _startIconAnimationController!.repeat();
  }

  Widget _pageBackground() {
    return TweenAnimationBuilder(
      tween: _backgroundScale,
      curve: Curves.easeIn,
      duration: const Duration(seconds: 2),
      builder: (_context, _scale, _child) {
        return Transform.scale(
          scale: _scale,
          child: _child,
        );
      },
      child: Container(
        color: Colors.blueAccent,
      ),
    );
  }

  Widget _circularAnimationButton() {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _borderRadius += _borderRadius == 200 ? -100 : 100;
          });
          print("borderRaduis: $_borderRadius");
        },
        child: AnimatedContainer(
          duration: const Duration(seconds: 2),
          curve: Curves.bounceOut,
          height: _borderRadius,
          width: _borderRadius,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(_borderRadius)),
          child: const Center(
            child: Text(
              "Tap Here!",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  Widget _startIcon() {
    return AnimatedBuilder(
      animation: _startIconAnimationController!.view,
      builder: (_buildContext, _child) {
        return Transform.rotate(
          angle: _startIconAnimationController!.value * 2 * pi,
          child: _child,
        );
      },
      child: const Icon(
        Icons.hive,
        size: 120,
        color: Colors.white,
      ),
    );
  }
}
