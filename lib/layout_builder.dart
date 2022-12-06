// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() => runApp(const AnimatedBuilderExample());

/// This widget listens for changes in the focus state of the subtree defined by
/// its [child] widget, changing the border and color of the container it is in
/// when it has focus.
///
/// A [FocusListenerContainer] swaps out the [BorderSide] of a border around the
/// child widget with [focusedSide] when a widget that is a descendant of this
/// widget has focus.
class FocusListenerContainer extends StatefulWidget {
  const FocusListenerContainer({
    super.key,
    this.border = const RoundedRectangleBorder(),
    this.focusedSide,
    required this.child,
  });

  /// This is the border that will be used when not focused, and which defines
  /// all the attributes except for the [OutlinedBorder.side] when focused.
  final OutlinedBorder border;

  /// This is the [BorderSide] that will be used for [border] when the [child]
  /// subtree is focused.
  final BorderSide? focusedSide;

  /// This is defines the subtree to listen to for focus changes.
  final Widget child;

  @override
  State<FocusListenerContainer> createState() => _FocusListenerContainerState();
}

class _FocusListenerContainerState extends State<FocusListenerContainer> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _focusNode,
      child: Focus(
        focusNode: _focusNode,
        skipTraversal: true,
        canRequestFocus: false,
        child: widget.child,
      ),
      builder: (BuildContext context, Widget? child) {
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: ShapeDecoration(
            shape: widget.border.copyWith(
              side: _focusNode.hasFocus ? widget.focusedSide : null,
            ),
          ),
          child: child,
        );
      },
    );
  }
}

class MyField extends StatefulWidget {
  const MyField({super.key, required this.label});

  final String label;

  @override
  State<MyField> createState() => _MyFieldState();
}

class _MyFieldState extends State<MyField> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: Text(widget.label)),
        Expanded(
          flex: 2,
          child: TextField(
            controller: controller,
            onEditingComplete: () {
              debugPrint('Field ${widget.label} changed to ${controller.value}');
            },
          ),
        ),
      ],
    );
  }
}

class AnimatedBuilderExample extends StatelessWidget {
  const AnimatedBuilderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('AnimatedBuilder Example')),
        body: Center(
          child: SizedBox(
            width: 300,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: MyField(label: 'Company'),
                  ),
                  FocusListenerContainer(
                    border: const RoundedRectangleBorder(
                      side: BorderSide(
                        strokeAlign: BorderSide.strokeAlignOutside,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    // The border side will get wider when the subtree has focus.
                    focusedSide: const BorderSide(
                      width: 4,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text('Owner:'),
                        MyField(label: 'First Name'),
                        MyField(label: 'Last Name'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}