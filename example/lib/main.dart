import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reorderable_staggered_scroll_view/reorderable_staggered_scroll_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Example'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(isList: true),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text("List"),
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(isList: false),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text("Grid"),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class HomePage extends StatefulWidget {
  final bool isList;
  const HomePage({Key? key, required this.isList}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _dragEnabled = true;
  @override
  Widget build(BuildContext context) {
    final nonDraggable = ReorderableStaggeredScrollViewGridItem(
      key: ValueKey(10.toString()),
      mainAxisCellCount: 1,
      crossAxisCellCount: Random().nextInt(2) + 1,
      widget: const Card(
          child: Padding(
        padding: EdgeInsets.all(12),
        child: Center(child: Text('Non Draggable')),
      )),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isList ? "List Example" : "Grid Example"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _dragEnabled = !_dragEnabled;
                });
              },
              icon: Icon(
                _dragEnabled ? Icons.pause : Icons.play_arrow,
              ))
        ],
      ),
      body: widget.isList
          ? ReorderableStaggeredScrollView.list(
              enable: _dragEnabled,
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              axis: Axis.vertical,
              shrinkWrap: true,
              isLongPressDraggable: false,
              onDragEnd: (details, item) {
                debugPrint('onDragEnd: $details ${item.key}');
              },
              isNotDragList: [nonDraggable],
              children: List.generate(
                5,
                (index) => ReorderableStaggeredScrollViewListItem(
                  key: ValueKey(index.toString()),
                  widget: Card(
                      child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Center(child: Text('Item $index')),
                  )),
                ),
              )..addAll(
                  [
                    nonDraggable,
                    ...List.generate(
                      5,
                      (index) => ReorderableStaggeredScrollViewListItem(
                        key: ValueKey('${index + 5}'),
                        widget: Card(
                            child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Center(child: Text('Item ${index + 5}')),
                        )),
                      ),
                    )
                  ],
                ),
            )
          : ReorderableStaggeredScrollView.grid(
              enable: _dragEnabled,
              padding: const EdgeInsets.all(16),
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              crossAxisCount: 4,
              isLongPressDraggable: false,
              onAccept: (item1, item2, value) {
                print('item1 $item1 item2 $item2 value $value');
              },
              onDragEnd: (details, item) {
                print('onDragEnd: $details ${item.key}');
              },
              onMove: (item, item2, value) {
                print('onMove: item $item item2 $item2 value $value');
              },
              onDragUpdate: (details, item) {
                print('onDragUpdate: details $details item $item');
              },
              isNotDragList: [nonDraggable],
              children: List.generate(
                5,
                (index) => ReorderableStaggeredScrollViewGridItem(
                  key: ValueKey(index.toString()),
                  mainAxisCellCount: 1,
                  crossAxisCellCount: Random().nextInt(2) + 1,
                  widget: Card(child: Center(child: Text('Item $index'))),
                ),
              )..addAll([
                  nonDraggable,
                  ...List.generate(
                    5,
                    (index) => ReorderableStaggeredScrollViewGridItem(
                      key: ValueKey('${index + 5}'),
                      mainAxisCellCount: 1,
                      crossAxisCellCount: Random().nextInt(2) + 1,
                      widget:
                          Card(child: Center(child: Text('Item ${index + 5}'))),
                    ),
                  )
                ]), // Provide the list of reorderable items
            ),
    );
  }
}
