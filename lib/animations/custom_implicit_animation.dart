import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomImplicitAnimation extends StatefulWidget {
  const CustomImplicitAnimation({Key? key}) : super(key: key);

  @override
  State<CustomImplicitAnimation> createState() =>
      _CustomImplicitAnimationState();
}

class _CustomImplicitAnimationState extends State<CustomImplicitAnimation> {
  double angle = 0;
  double height = 200.0;
  double width = 200.0;
  double radius = 20.0;
  double _currentValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Custom Implicit Animation"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TweenAnimationBuilder<double>(
              duration: const Duration(seconds: 2),
              tween: Tween(begin: 0, end: angle),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(radius)),
                ),
                height: height,
                width: width,
              ),
              builder: (context, double angle, child) {
                return Transform.rotate(
                  angle: angle,
                  child: child,
                );
              },
            ),
            Slider(
              value: _currentValue,
              onChanged: (value) {
                setState(() {
                  angle = value;
                  _currentValue = value;
                });
              },
              max: math.pi * 2, //pi=180 => pi/2=90
              min: -math.pi * 2,
            ),
          ],
        ),
      ),
    );
  }
}
