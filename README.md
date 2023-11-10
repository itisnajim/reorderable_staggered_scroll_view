# reorderable_staggered_scroll_view

[![pub package](https://img.shields.io/pub/v/reorderable_staggered_scroll_view.svg)](https://pub.dartlang.org/packages/reorderable_staggered_scroll_view) [![GitHub license](https://img.shields.io/github/license/itisnajim/reorderable_staggered_scroll_view)](https://github.com/itisnajim/reorderable_staggered_scroll_view/blob/master/LICENSE)  [![GitHub issues](https://img.shields.io/github/issues/itisnajim/reorderable_staggered_scroll_view)](https://github.com/itisnajim/reorderable_staggered_scroll_view/issues)

A Flutter package for creating reorderable and draggable staggered grid and list views. This package provides a smooth and intuitive way to reorder items in both grid and list layouts, making it perfect for creating interactive and user-friendly applications.

| List Demo | Grid Demo |
|:---:|:---:|
| ![List](https://raw.githubusercontent.com/itisnajim/reorderable_staggered_scroll_view/main/readme/list.gif) | ![Grid](https://raw.githubusercontent.com/itisnajim/reorderable_staggered_scroll_view/main/readme/grid.gif) |


## Features

* Reorder items with ease using drag and drop gestures.
* Supports both staggered grid and list layouts.
* Configurable drag-and-drop behavior.
* Designed for a seamless user experience.

## Getting Started

To use this package, add it to your pubspec.yaml file:


```yaml
dependencies:
  reorderable_staggered_scroll_view: ^latest_version
```
Replace ^latest_version with the actual version you want to use.

Import the package in your Dart code:

```dart
import 'package:reorderable_staggered_scroll_view/reorderable_staggered_scroll_view.dart';
```

## Usage

### Grid

```dart
ReorderableStaggeredScrollView.grid(
  enable: _dragEnabled,
  padding: const EdgeInsets.all(16),
  scrollDirection: Axis.vertical,
  physics: const BouncingScrollPhysics(),
  crossAxisCount: 4,
  isLongPressDraggable: false,
  onDragEnd: (details, item) {
    print('onDragEnd: $details ${item.key}');
  },
  children: List.generate(
    10,
    (index) => ReorderableStaggeredScrollViewGridItem(
      key: ValueKey(index.toString()),
      mainAxisCellCount: 1,
      crossAxisCellCount: Random().nextInt(2) + 1,
      widget: Card(
        child: Center(child: Text('Item $index')),
      ),
    ),
  ),
);
```

### List

For a list view of items use `list` constructor:
```dart
ReorderableStaggeredScrollView.list(
  ...
)
```

### Custom

You can integrate the `ReorderableStaggeredScrollView` package with your custom list or grid widget by wrapping your custom list or grid widget with the necessary components.

```dart
DragNotification(
  child: ListView(
    scrollDirection: Axis.vertical,
    children: [
      DragContainer(
        scrollDirection: Axis.vertical,
        isLongPressDraggable: true,
        buildItems: (List<Widget> children) {
          return YourCustomListViewWidget(
            // Your custom list or grid widget configuration
            children: children,
          );
        },
        dataList: yourList, // Your List of ReorderableStaggeredScrollViewListItem or ReorderableStaggeredScrollViewGridItem
        items: (ReorderableStaggeredScrollViewListItem element, DraggableWidget draggableWidget) {
          // Map each item in your dataList into a draggable widget
          return Container(
            key: ValueKey(element.key.toString()),
            child: draggableWidget(element.widget),
          );
        }
      ),
    ],
  ),
);
```
Replace the comments with your actual widget configuration and data. This setup will allow you to use the ReorderableStaggeredScrollView package with your custom widget.

For more detailed usage instructions and configuration options, refer to the [example](https://github.com/itisnajim/reorderable_staggered_scroll_view/tree/main/example) directory in this repository.


## Contributing

We welcome contributions! If you have ideas for improvements or encounter issues, please open an issue or submit a pull request.

## Author

itisnajim, itisnajim@gmail.com

## License
This package is licensed under the MIT License. See the LICENSE file for more details.
