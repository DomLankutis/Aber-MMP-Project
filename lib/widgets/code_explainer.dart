import 'package:flutter/material.dart';

class CodeExplainer extends StatefulWidget {
  final List<String> Function()? getCode;
  final List<int> Function()? getCodeAt;

  const CodeExplainer({
    Key? key,
    required this.getCode,
    required this.getCodeAt,
  }) : super(key: key);

  @override
  _CodeExplainerState createState() => _CodeExplainerState();
}

class _CodeExplainerState extends State<CodeExplainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  int highlightedLine = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Widget> codeLines() {
    List<Widget> arr = List.empty(growable: true);

    List<String> code = widget.getCode != null ? widget.getCode!() : [];
    List<int> codeAt = widget.getCodeAt != null ? widget.getCodeAt!() : [];

    for (var codeLine in code.asMap().entries) {
      Color color = Colors.white;

      if (codeAt.contains(codeLine.key)) {
        color = Colors.white10;
      }

      arr.add(
        Align(
          alignment: Alignment.centerLeft,
          child: Expanded(
            child: Card(
              color: color,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(codeLine.value),
              ),
            ),
          ),
        ),
      );
    }

    return arr;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        child: Column(
          children: codeLines(),
        ),
      ),
    );
  }
}
