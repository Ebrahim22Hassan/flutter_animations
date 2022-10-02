import 'dart:math';

import 'package:flutter/material.dart';

class ImplicitAnimation extends StatefulWidget {
  const ImplicitAnimation({Key? key}) : super(key: key);

  @override
  State<ImplicitAnimation> createState() => _ImplicitAnimationState();
}

class _ImplicitAnimationState extends State<ImplicitAnimation> {
  double _opacityLevel = 0.1;
  double height = 200.0;
  double width = 200.0;
  double radius = 20.0;
  Color color = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Implicit Animation"),
      ),
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(seconds: 2),
          opacity: _opacityLevel, // range 0.0 - 1.0
          child: GestureDetector(
            onTap: startAnimation,
            child: AnimatedContainer(
              duration: const Duration(seconds: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                color: color,
              ),
              height: height,
              width: width,
            ),
          ),
        ),
      ),
    );
  }

  void startAnimation() {
    setState(() {
      _opacityLevel = Random().nextDouble();
      height = Random().nextDouble() * 600;
      width = Random().nextDouble() * 600;
      radius = Random().nextDouble() * 200;

      color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    });
  }
}
