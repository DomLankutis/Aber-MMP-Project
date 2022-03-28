import 'package:flutter/material.dart';
import 'package:search_algorithm_visualiser/misc/helper.dart';
import 'package:search_algorithm_visualiser/widgets/algorithm_selection.dart';

class ChartAlgorithmSelector extends StatefulWidget {
  final Function(SearchAlgorithm) toggleCallback;
  final Function(SearchAlgorithm) getToggleCallback;

  const ChartAlgorithmSelector(
      {Key? key, required this.toggleCallback, required this.getToggleCallback})
      : super(key: key);

  @override
  _ChartAlgorithmSelectorState createState() => _ChartAlgorithmSelectorState();
}

class _ChartAlgorithmSelectorState extends State<ChartAlgorithmSelector> {
  Widget selector(SearchAlgorithm searchAlgorithm) {
    return Flexible(
      child: GestureDetector(
        onTap: () {
          widget.toggleCallback(searchAlgorithm);
        },
        child: Card(
          color: widget.getToggleCallback(searchAlgorithm)
              ? Colors.white
              : Colors.white10,
          child: Row(
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    color: lineColor[searchAlgorithm],
                  ),
                ),
              ),
              Flexible(
                flex: 5,
                child: Text(getAlgorithmName(searchAlgorithm)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        selector(SearchAlgorithm.linear),
        selector(SearchAlgorithm.binary),
        selector(SearchAlgorithm.fixed),
      ],
    );
  }
}
