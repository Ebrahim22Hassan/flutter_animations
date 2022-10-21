import 'package:flutter/material.dart';

class AnimatedClipPath extends StatefulWidget {
  const AnimatedClipPath({Key? key}) : super(key: key);

  @override
  State<AnimatedClipPath> createState() => _AnimatedClipPathState();
}

class _AnimatedClipPathState extends State<AnimatedClipPath>
    with SingleTickerProviderStateMixin {
  List<ColorModel> colors = const [
    ColorModel(Colors.pinkAccent, Alignment.topLeft),
    ColorModel(Colors.pink, Alignment.topCenter),
    ColorModel(Colors.greenAccent, Alignment.topRight),
    ColorModel(Colors.grey, Alignment.centerLeft),
    ColorModel(Colors.blueAccent, Alignment.center),
    ColorModel(Colors.brown, Alignment.centerRight),
    ColorModel(Colors.orangeAccent, Alignment.bottomLeft),
    ColorModel(Colors.red, Alignment.bottomRight),
  ];

  late AnimationController animationController;
  late ColorModel currentColor;
  late ColorModel prevColor;

  @override
  void initState() {
    super.initState();
    currentColor = colors.first;
    prevColor = colors.last;
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    super.dispose();

    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clip Path Animation"),
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                color: prevColor.color,
                width: double.infinity,
              ),
              AnimatedBuilder(
                  animation: animationController,
                  builder: (context, child) {
                    return ClipPath(
                      clipper: CustomPath(
                        value: animationController.value,
                        alignment: currentColor.alignmentl,
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        color: currentColor.color,
                        width: double.infinity,
                      ),
                    );
                  }),
            ],
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: GridView.builder(
                itemCount: colors.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      currentColor = colors[index];
                      animationController.forward(from: 0.0).whenComplete(() {
                        prevColor = currentColor;
                        setState(() {});
                      });
                    },
                    child: GridViewItems(
                      color: colors[index].color,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GridViewItems extends StatelessWidget {
  const GridViewItems({Key? key, required this.color}) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: color,
    );
  }
}

class ColorModel {
  final Color color;
  final Alignment alignmentl;

  const ColorModel(this.color, this.alignmentl);
}

class CustomPath extends CustomClipper<Path> {
  final double value;
  final Alignment alignment;

  CustomPath({required this.alignment, required this.value});

  @override
  Path getClip(Size size) // size of Container
  {
    Path path = Path();

    if (alignment == Alignment.topLeft) {
      buildPath(size, path, const Offset(0, 0));
    } else if (alignment == Alignment.topCenter) {
      buildPath(size, path, Offset(size.width / 2, 0));
    } else if (alignment == Alignment.topRight) {
      buildPath(size, path, Offset(size.width, 0));
    } else if (alignment == Alignment.centerLeft) {
      buildPath(size, path, Offset(0, size.height / 2));
    } else if (alignment == Alignment.center) {
      buildPath(size, path, Offset(size.width / 2, size.height / 2));
    } else if (alignment == Alignment.centerRight) {
      buildPath(size, path, Offset(size.width, size.height / 2));
    } else if (alignment == Alignment.bottomLeft) {
      buildPath(size, path, Offset(0, size.height));
    } else if (alignment == Alignment.bottomRight) {
      buildPath(size, path, Offset(size.width, size.height));
    }

    return path;
  }

  void buildPath(Size size, Path path, Offset offset) {
    return path.addOval(
      Rect.fromCenter(
        center: offset,
        width: size.width * 2 * value,
        height: size.height * 2 * value,
      ),
    );
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
