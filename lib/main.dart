import 'package:flutter/material.dart';
import 'package:flutter_animations/home_page.dart';
import 'animations/animated_list.dart';
import 'animations/clip_path.dart';
import 'animations/cross_fade.dart';
import 'animations/custom_implicit_animation.dart';
import 'animations/implicit_animation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Animations',
      home: const HomePage(),
      routes: {
        "implicitAnimation": (context) => const ImplicitAnimation(),
        "customImplicitAnimation": (context) => const CustomImplicitAnimation(),
        "animatedList": (context) => const AnimatedListScreen(),
        "animatedClipPath": (context) => const AnimatedClipPath(),
        "crossFade": (context) => const CrossFadeAnimation(),
      },
    );
  }
}
