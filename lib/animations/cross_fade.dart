import 'package:flutter/material.dart';

class CrossFadeAnimation extends StatefulWidget {
  const CrossFadeAnimation({Key? key}) : super(key: key);

  @override
  State<CrossFadeAnimation> createState() => _CrossFadeAnimationState();
}

class _CrossFadeAnimationState extends State<CrossFadeAnimation> {
  CrossFadeState crossFadeState = CrossFadeState.showSecond;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cross Fade Animation"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Fade Animation"),
                  // const SizedBox(
                  //   width: 20,
                  // ),
                  AnimatedCrossFade(
                      firstChild: const CircleAvatar(
                        radius: 25,
                        child: Text("1st "),
                      ),
                      secondChild: const SizedBox(width: 15),
                      crossFadeState: crossFadeState,
                      duration: const Duration(seconds: 1)),
                ],
              )),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (crossFadeState == CrossFadeState.showFirst) {
                    crossFadeState = CrossFadeState.showSecond;
                  } else {
                    crossFadeState = CrossFadeState.showFirst;
                  }
                });
              },
              child: const Text("fade"),
            )
          ],
        ),
      ),
    );
  }
}
