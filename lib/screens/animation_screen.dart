import 'package:flutter/material.dart';
import 'package:search_algorithm_visualiser/widgets/algorithm_selection.dart';
import 'package:search_algorithm_visualiser/widgets/custom_painter.dart';

class AnimationScreen extends StatefulWidget {
  final int arrSize;
  final int searchFor;
  final SearchAlgorithm algorithm;
  final int fixedStep;

  const AnimationScreen({
    Key? key,
    required this.arrSize,
    required this.searchFor,
    required this.algorithm,
    required this.fixedStep,
  }) : super(key: key);

  @override
  _AnimationScreenState createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  List<Widget> _list = List.empty(growable: true);
  String code = "";
  late Widget _customPainter;

  void printStates() {
    _list = List.empty(growable: true);

    PainterBuilder _pB = _customPainter as PainterBuilder;
    for (var e in _pB.getSearch!().getVariableStates().entries) {
      _list.add(
        SizedBox(
          width: 200,
          child: Card(
            color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(e.key),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(e.value.toString()),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    code = _pB.getSearch!().codeAt;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _customPainter = customPainterBuilder(
      context,
      widget.arrSize,
      widget.searchFor,
      widget.algorithm,
      widget.fixedStep,
      printStates,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 1,
          child: _customPainter,
        ),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Card(
                  child: Column(
                    children: [
                      const Expanded(child: Text("Variable States")),
                      Expanded(
                        flex: 10,
                        child: Card(
                            child: Column(
                          children: _list,
                        )),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Card(
                    child: Column(
                  children: [
                    const Expanded(child: Text("Current Code Scope")),
                    Expanded(
                      flex: 10,
                      child: Card(
                        child: Text(code),
                      ),
                    )
                  ],
                )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
