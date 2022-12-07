// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Flutter code sample for [AnimatedBuilder].

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MenuBarExample());

class ApplicationMenu extends StatelessWidget with PreferredSizeWidget {
  const ApplicationMenu({super.key});

  @override
  Size get preferredSize => const Size(double.infinity, 48);

  void _showAbout(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Example App',
      applicationIcon: const FlutterLogo(),
      applicationVersion: '1.0.0',
    );
  }

  @override
  Widget build(BuildContext context) {
    return MenuBar(
      children: <Widget>[
        SubmenuButton(
          menuChildren: <Widget>[
            MenuItemButton(
              onPressed: () => _showAbout(context),
              shortcut: const SingleActivator(LogicalKeyboardKey.keyA, meta: true),
              child: const MenuAcceleratorLabel("&About"),
            ),
            const Divider(),
            MenuItemButton(
              onPressed: () => exit(0),
              shortcut: const SingleActivator(LogicalKeyboardKey.keyQ, meta: true),
              child: const MenuAcceleratorLabel('&Quit'),
            ),
          ],
          child: const MenuAcceleratorLabel("&Example App"),
        ),
      ],
    );
  }
}

class MenuBarExample extends StatelessWidget {
  const MenuBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(visualDensity: VisualDensity.compact),
      home: const Scaffold(
        appBar: ApplicationMenu(),
        body: Center(
          child: AspectRatio(
            aspectRatio: 1.0,
            child: FlutterLogo(),
          ),
        ),
      ),
    );
  }
}
