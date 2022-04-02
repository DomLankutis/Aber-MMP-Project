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

  ScrollController scrollController = ScrollController();

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
        Flexible(
          child: Card(
            color: color,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(codeLine.value),
            ),
          ),
        ),
      );
    }

    if (scrollController.hasClients && codeAt.isNotEmpty) {
      int scrollTo = codeAt.fold(0,
              (previousValue, element) => (previousValue as int) + element) ~/
          codeAt.length;

      var codeHeight =
          scrollController.position.maxScrollExtent ~/ code.length - 1;
      var padding = codeHeight * 3;

      scrollTo = scrollTo * codeHeight;

      if (scrollTo > padding * 2) {
        scrollTo += padding;
      } else if (scrollTo < padding * 1.5) {
        scrollTo -= (padding * 0.75).toInt();
      }

      scrollController.animateTo(scrollTo.toDouble(),
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    }

    return arr;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: codeLines(),
        ),
      ),
    );
  }
}
