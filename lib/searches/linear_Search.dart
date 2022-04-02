import 'package:flutter/material.dart';
import 'package:search_algorithm_visualiser/searches/search_class.dart';
import 'package:search_algorithm_visualiser/widgets/algorithm_selection.dart';

class LinearSearch extends SearchClass {
  int lookingAt = 0;

  LinearSearch(
    int arrSize,
    int searchFor,
    Animation<double>? offset,
  ) : super(arrSize, searchFor, Paint(), offset) {
    identifier = SearchAlgorithm.linear;
    code = [
      "for (; i < fastArr.length; i++) {",
      "    if (fastArr[i] == fastSearchFor) {",
      "        return;",
      "    }",
      "}",
    ];
  }

  static Map<Color, String> getColorExplanations() {
    return SearchClass.baseExplanations;
  }

  @override
  void fastRun() {
    int i = 0;
    fastOperationCount++; // declare i

    for (; i < fastArr.length; i++) {
      fastOperationCount++; // < comparison
      fastOperationCount++; // i iteration (?) / add 1
      fastOperationCount++; // == comparison

      if (fastArr[i] == fastSearchFor) {
        return;
      }
    }
  }

  @override
  void iteration() {
    super.iteration();
    arr[lookingAt].color = Colors.yellow;
    setCodeAt([]);

    if (arr[lookingAt].value != searchFor) {
      setCodeAt([0, 1, 2, 3, 4]);
      lookingAt++;
    } else {
      finished = true;
    }
  }

  @override
  Map<String, int> getVariableStates() {
    return {"Iteration": iterationCount, "Looking at": lookingAt};
  }
}
