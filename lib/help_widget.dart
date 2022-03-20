import 'package:flutter/material.dart';
import 'package:search_algorithm_visualiser/home_page.dart';
import 'package:search_algorithm_visualiser/searches/binary_search.dart';
import 'package:search_algorithm_visualiser/searches/fixed_step_search.dart';
import 'package:search_algorithm_visualiser/searches/linear_Search.dart';

Widget rectExplainer(Color color, String text) {
  return Card(
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: SizedBox(
            width: 20,
            height: 20,
            child: Container(
              color: color,
            ),
          ),
        ),
        Text(text),
      ],
    ),
  );
}

class HelpWidget extends StatelessWidget {
  final SearchAlgorithm algorithm;

  const HelpWidget({Key? key, required this.algorithm}) : super(key: key);

  Map<Color, String> getSearchColorExplanation() {
    switch (algorithm) {
      case SearchAlgorithm.linear:
        return LinearSearch.getColorExplanations();
      case SearchAlgorithm.binary:
        return BinarySearch.getColorExplanations();
      case SearchAlgorithm.fixed:
        return FixedStepSearch.getColorExplanations();
    }
  }

  @override
  Widget build(BuildContext context) {
    var explanations = getSearchColorExplanation();

    return Column(
      children: <Widget>[
        for (var explain in explanations.entries)
          rectExplainer(explain.key, explain.value)
      ],
    );
  }
}
