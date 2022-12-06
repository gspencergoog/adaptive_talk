// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Flutter code sample for [AnimatedBuilder].

import 'package:flutter/material.dart';

void main() => runApp(const LayoutBuilderExample());

/// This displays a row of icon buttons, and if the row is too narrow to display
/// all of them, it moves any that don't fit into an overflow menu.
///
/// This widget is a [PreferredSizeWidget], so it can be used as a
/// [Scaffold.appBar].
class IconButtonBar extends StatelessWidget with PreferredSizeWidget {
  const IconButtonBar({
    super.key,
    required this.childSize,
    required this.children,
  });

  /// The fixed width for each of the children.
  final Size childSize;

  /// The list of widgets (typically [IconButton]s) to display.
  ///
  /// They should each be able to be displayed at [childSize]. They will
  /// automatically be placed inside of a [SizedBox] that is [childSize] in
  /// size.
  final List<Widget> children;

  @override
  Size get preferredSize => Size(childSize.width * children.length, childSize.height);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        int visibleChildren = constraints.constrain(preferredSize).width ~/ childSize.width;
        visibleChildren = (visibleChildren < children.length) ? visibleChildren - 1 : children.length;
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ...children.sublist(0, visibleChildren),
            if (visibleChildren < children.length)
              OverflowMenu(children: children.sublist(visibleChildren, children.length)),
          ].map<Widget>((Widget child) => SizedBox.fromSize(size: childSize, child: child)).toList(),
        );
      },
    );
  }
}

class OverflowMenu extends StatelessWidget {
  const OverflowMenu({
    super.key,
    required this.children,
    this.icon,
  });

  final List<Widget> children;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      style: const MenuStyle(alignment: AlignmentDirectional.bottomStart),
      builder: (context, controller, child) {
        return IconButton(
          icon: icon ?? const Icon(Icons.more_vert),
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
        );
      },
      menuChildren: children,
    );
  }
}

class LayoutBuilderExample extends StatelessWidget {
  const LayoutBuilderExample({ super.key });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: IconButtonBar(
          childSize: const Size(48, 48),
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.calendar_month)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.hotel)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.car_rental)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.airplanemode_on)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.train)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.rocket)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.alarm_add)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.alarm_off)),
          ],
        ),
        body: const Center(
          child: AspectRatio(
            aspectRatio: 1.0,
            child: FlutterLogo(),
          ),
        ),
      ),
    );
  }
}
