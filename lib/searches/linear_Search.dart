import 'package:flutter/material.dart';
import 'package:search_algorithm_visualiser/searches/search_class.dart';
import 'package:search_algorithm_visualiser/widgets/algorithm_selection.dart';

class LinearSearch extends SearchClass {
  int lookingAt = 0;

  LinearSearch(int arrSize, int searchFor, Animation<double>? offset)
      : super(arrSize, searchFor, Paint(), offset) {
    identifier = SearchAlgorithm.linear;
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

    codeAt = "found";

    if (arr[lookingAt].value != searchFor) {
      lookingAt++;
      codeAt = "if (arr[lookingAt].value != searchFor)";
    }
  }

  @override
  Map<String, int> getVariableStates() {
    return {"Iteration": iterationCount, "Looking at": lookingAt};
  }

  @override
  String getCodeScope() {
    return codeAt;
  }
}
