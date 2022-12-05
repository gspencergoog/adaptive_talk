import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: HoverBox(),
        ),
      ),
    );
  }
}

class HoverBox extends StatelessWidget {
  const HoverBox({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: FocusManager.instance,
      builder: (BuildContext context, Widget? child) {
        return Container(
        width: 100, height: 100, color: _hovering ? Colors.red : Colors.blue)
      }
      child: ,
    );
  }
}
