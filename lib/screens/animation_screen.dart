import 'package:flutter/material.dart';
import 'package:search_algorithm_visualiser/widgets/algorithm_selection.dart';
import 'package:search_algorithm_visualiser/widgets/code_explainer.dart';
import 'package:search_algorithm_visualiser/widgets/custom_painter.dart';
import 'package:search_algorithm_visualiser/widgets/info_widget.dart';

class AnimationScreen extends StatefulWidget {
  final int arrSize;
  final int searchFor;
  final SearchAlgorithm algorithm;
  final int fixedStep;

  final double Function() getSpeedSliderVal;

  const AnimationScreen({
    Key? key,
    required this.arrSize,
    required this.searchFor,
    required this.algorithm,
    required this.fixedStep,
    required this.getSpeedSliderVal,
  }) : super(key: key);

  @override
  _AnimationScreenState createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  List<Widget> _list = List.empty(growable: true);

  late Widget _customPainter;

  List<String> Function()? getCode;
  List<int> Function()? getCodeAt;

  void printStates() {
    _list = List.empty(growable: true);

    PainterBuilder _pB = _customPainter as PainterBuilder;
    for (var e in _pB.getSearch().getVariableStates().entries) {
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

    getCode = _pB.getSearch().getCode;
    getCodeAt = _pB.getSearch().getCodeAt;

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
      widget.getSpeedSliderVal,
      printStates,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 12, 8, 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: _customPainter,
              ),
            ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6),
                              child: Text("Variable States"),
                            ),
                            InfoWidget(
                              information:
                                  "The variables used in the selected search algorithm and their current values",
                            ),
                          ],
                        ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6),
                              child: Text("Current Explanation"),
                            ),
                            InfoWidget(
                              information:
                                  "Displays algorithm code and highlights currently running code",
                            ),
                          ],
                        ),
                        Expanded(
                          flex: 10,
                          child: CodeExplainer(
                            getCode: getCode,
                            getCodeAt: getCodeAt,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
