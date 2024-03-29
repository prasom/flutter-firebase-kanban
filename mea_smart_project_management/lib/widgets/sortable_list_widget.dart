import 'package:flutter/material.dart';

class SortableListView extends StatefulWidget {
  final List items;
  final IndexedWidgetBuilder itemBuilder;

  SortableListView({this.items, this.itemBuilder})
      : assert(items != null),
        assert(itemBuilder != null);

  @override
  State createState() => new SortableListViewState();
}

class SortableListViewState extends State<SortableListView> {
  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(
      builder: (context, constraint) {
        return Container(
          color: Colors.transparent,
          child: new ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: widget.items.length + 1,
            addRepaintBoundaries: true,
            itemBuilder: (context, index) {
              return new LongPressDraggable<int>(
                data: index,
                child: new DragTarget<int>(
                  onAccept: (int data) {
                    _handleAccept(data, index);
                  },
                  onWillAccept: (data) {
                    return true;
                  },
                  builder: (BuildContext context, List<int> data,
                      List<dynamic> rejects) {
                    List<Widget> children = [];
                    if (data.isNotEmpty) {
                      children.add(
                        new Container(
                          child: new Opacity(
                            opacity: 0.5,
                            child: _getListItem(context, data[0]),
                          ),
                        ),
                      );
                    }
                    children.add(_getListItem(context, index));

                    return new Column(
                      children: children,
                    );
                  },
                ),
                onDragStarted: () {
                  Scaffold.of(context).showSnackBar(
                    new SnackBar(
                        content: new Text("Drag the row to change places")),
                  );
                },
                feedback: new Opacity(
                  opacity: 0.75,
                  child: new SizedBox(
                    width: constraint.maxWidth,
                    child: _getListItem(context, index, true),
                  ),
                ),
                childWhenDragging: new Container(),
              );
            },
          ),
        );
      },
    );
  }

  void _handleAccept(int data, int index) {
    setState(() {
      // Decrement index so that after removing we'll still insert the item
      // in the correct position.
      if (index > data) {
        index--;
      }
      dynamic imageToMove = widget.items[data];
      widget.items.removeAt(data);
      widget.items.insert(index, imageToMove);
    });
  }

  Widget _getListItem(BuildContext context, int index, [bool dragged = false]) {
    // A little hack: our ListView has an extra invisible trailing item to
    // allow moving the dragged item to the last position.
    if (index == widget.items.length) {
      // This invisible item uses the previous item to determine its size. If
      // the list is empty, though, there's no dragging really.
      if (widget.items.isEmpty) {
        return new Container();
      }
      return new Opacity(
        opacity: 0.0,
        child: _getListItem(context, index - 1),
      );
    }

    return new Material(
      elevation: dragged ? 20.0 : 0.0,
      color: Colors.transparent,
      child: widget.itemBuilder(context, index),
    );
  }
}
