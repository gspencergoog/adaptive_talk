// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Flutter code sample for [AnimatedBuilder].

import 'package:flutter/material.dart';

void main() => runApp(const MenuBarExample());

class ApplicationMenu extends StatelessWidget with PreferredSizeWidget {
  const ApplicationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: MenuBar(
                children: <Widget>[
                  SubmenuButton(
                    menuChildren: [
                      MenuItemButton(
                        onPressed: () {
                          showAboutDialog(context: context);
                        },
                        child: const MenuAcceleratorLabel("&About"),
                      ),
                      const Padding(
                        padding: EdgeInsetsDirectional.only(start: 8.0),
                        child: Text('Options:', style: TextStyle(fontStyle: FontStyle.italic)),
                      ),
                      MenuItemButton(
                        onPressed: () {},
                        child: const MenuAcceleratorLabel("Option &1"),
                      ),
                      MenuItemButton(
                        onPressed: () {},
                        child: const MenuAcceleratorLabel("Option &2"),
                      ),
                    ],
                    child: const MenuItemButton(
                      child: MenuAcceleratorLabel("Example &App"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 48);
}

class MenuBarExample extends StatelessWidget {
  const MenuBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
