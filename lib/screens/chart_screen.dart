import 'package:flutter/material.dart';
import 'package:search_algorithm_visualiser/widgets/algorithm_selection.dart';
import 'package:search_algorithm_visualiser/widgets/line_chart_algorithm_selector.dart';
import 'package:search_algorithm_visualiser/widgets/live_chart.dart';

class ChartScreen extends StatefulWidget {
  final int arraySize;
  final int searchFor;
  final int fixedStep;

  const ChartScreen({
    Key? key,
    required this.arraySize,
    required this.searchFor,
    required this.fixedStep,
  }) : super(key: key);

  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  Map<SearchAlgorithm, bool> enabledSearches = {
    SearchAlgorithm.linear: true,
    SearchAlgorithm.binary: true,
    SearchAlgorithm.fixed: true,
    SearchAlgorithm.increasingStep: true,
  };

  void toggleCallback(SearchAlgorithm searchAlgorithm) {
    enabledSearches[searchAlgorithm] = !enabledSearches[searchAlgorithm]!;
    setState(() {});
  }

  bool getToggleCallback(SearchAlgorithm searchAlgorithm) {
    return enabledSearches[searchAlgorithm]!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 8,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
            child: LiveChart(
              arraySize: widget.arraySize,
              searchFor: widget.searchFor,
              fixedStep: widget.fixedStep,
              enabledSearches: enabledSearches,
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: ChartAlgorithmSelector(
            toggleCallback: toggleCallback,
            getToggleCallback: getToggleCallback,
          ),
        )
      ],
    );
  }
}
