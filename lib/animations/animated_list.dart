import 'package:flutter/material.dart';

class AnimatedListScreen extends StatelessWidget {
  const AnimatedListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Animated List"),
      ),
      body: const CustomAnimatedList(),
    );
  }
}

class CustomAnimatedList extends StatefulWidget {
  const CustomAnimatedList({Key? key}) : super(key: key);

  @override
  State<CustomAnimatedList> createState() => _CustomAnimatedListState();
}

class _CustomAnimatedListState extends State<CustomAnimatedList> {
  final List<String> items = [];
  final GlobalKey<AnimatedListState> key = GlobalKey();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AnimatedList(
            key: key,
            controller: scrollController,
            initialItemCount: items.length,
            itemBuilder: (context, index, animation) {
              return

                  ///Size Transition
                  //   SizeTransition(
                  //   sizeFactor: animation,
                  //   child: ItemsList(
                  //     onDelPressed: () {
                  //       deleteItem(index);
                  //     },
                  //     text: items[index],
                  //   ),
                  // );
                  /// Slide Transition
                  SlideTransition(
                position: animation.drive(Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: const Offset(0, 0),
                )),
                child: ItemsList(
                  onDelPressed: () {
                    deleteItem(index);
                  },
                  text: items[index],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              ElevatedButton(onPressed: insertItem, child: const Text("add")),
        )
      ],
    );
  }

  void insertItem() {
    var index = items.length;
    items.add("item ${index + 1}");

    ///
    key.currentState!.insertItem(index);

    ///scroll to the bottom after inserting
    Future.delayed(const Duration(milliseconds: 300), () {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    });
  }

  void deleteItem(int index) {
    var removeItem = items.removeAt(index);

    ///
    key.currentState!.removeItem(index, (context, animation) {
      return SizeTransition(
          sizeFactor: animation,
          child: ItemsList(text: removeItem, onDelPressed: () {}));
    });
  }
}

class ItemsList extends StatelessWidget {
  const ItemsList({Key? key, required this.text, required this.onDelPressed})
      : super(key: key);

  final String text;
  final VoidCallback onDelPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.green,
        ),
        title: Text(text),
        trailing: IconButton(
          onPressed: onDelPressed,
          icon: const Icon(Icons.delete_forever),
        ),
      ),
    );
  }
}
