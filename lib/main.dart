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

class HoverBox extends StatefulWidget {
  const HoverBox({super.key});
  @override
  State<HoverBox> createState() => _HoverBoxState();
}

class _HoverBoxState extends State<HoverBox> {
  bool _hovering = false;
  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      onShowHoverHighlight: (bool value) { setState(() { _hovering = value; }); },
      child: Container(
        width: 100, height: 100, color: _hovering ? Colors.red : Colors.blue),
    );
  }
}
