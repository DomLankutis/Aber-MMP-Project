import 'dart:math';

import 'package:flutter/material.dart';
import 'package:search_algorithm_visualiser/searches/search_class.dart';
import 'package:search_algorithm_visualiser/widgets/algorithm_selection.dart';

class FixedStepSearch extends SearchClass {
  int position = 0;
  int stepSize;
  late int _initialStepSize;

  late bool _whileLoopConditionMet;

  FixedStepSearch(
      int arrSize, int searchFor, Animation<double>? offset, this.stepSize)
      : super(arrSize, searchFor, Paint(), offset) {
    _initialStepSize = stepSize;

    identifier = SearchAlgorithm.fixed;

    code = [
      "while ((_pos < fastArr.length) && (fastArr[_pos] < fastSearchFor)) {",
      "    _pos += stepSize;",
      "}",
      "if ((_pos >= fastArr.length) || (fastArr[_pos] > fastSearchFor)) {",
      "    do {",
      "        _pos--;",
      "        _stepSize--;",
      "        if ((_pos < fastArr.length) && (fastArr[_pos] == fastSearchFor)) {",
      "            return;",
      "        }",
      "    } while (_stepSize > 0);",
      "}",
    ];
  }

  @override
  void updateArray(int newSize) {
    super.updateArray(newSize);
    _initialStepSize = sqrt(arraySize).round().abs();
  }

  static Map<Color, String> getColorExplanations() {
    return SearchClass.baseExplanations;
  }

  @override
  void fastRun() {
    int _pos = 0;
    int _stepSize = _initialStepSize;

    fastOperationCount++; // Var init
    fastOperationCount++; // var init
    while ((_pos < fastArr.length) && (fastArr[_pos] < fastSearchFor)) {
      fastOperationCount++; // < comparison
      fastOperationCount++; // < comparison
      fastOperationCount++; // && logic gate

      _pos += stepSize;
      fastOperationCount++; // add
      fastOperationCount++; // assign
    }

    fastOperationCount++; // >= comparison
    fastOperationCount++; // > comparison
    fastOperationCount++; // || logic gate
    if ((_pos >= fastArr.length) || (fastArr[_pos] > fastSearchFor)) {
      do {
        fastOperationCount++; // while > comparison

        _pos--;
        _stepSize--;

        fastOperationCount++; // sub _pos
        fastOperationCount++; // sub _step
        fastOperationCount++; // < comparison
        fastOperationCount++; // == comparison
        fastOperationCount++; // && logic gate
        if ((_pos < fastArr.length) && (fastArr[_pos] == fastSearchFor)) {
          return;
        }
      } while (_stepSize > 0);
    }
    return;
  }

  @override
  void iteration() {
    super.iteration();

    _whileLoopConditionMet =
        (position < arraySize) && (arr[position].value < searchFor);

    if (_whileLoopConditionMet) {
      setCodeAt([0, 1, 2]);
      position += stepSize;
      arr[position].color = Colors.yellow;

      return;
    }

    if ((position >= arraySize) || (arr[position].value > searchFor)) {
      setCodeAt([3, 4, 5, 6, 7, 8, 9, 10, 11]);
      if (stepSize > 0) {
        position--;
        stepSize--;
        arr[position].color = Colors.yellow;
        if ((position < arraySize) && (arr[position].value == searchFor)) {
          setCodeAt([3, 11, 7, 8, 9]);
          finished = true;
          return;
        }
      }
    }
  }

  @override
  Map<String, int> getVariableStates() {
    return {
      "Iteration": iterationCount,
      "Position": position,
      "StepSize": stepSize
    };
  }
}
