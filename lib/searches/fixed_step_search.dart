import 'dart:math';

import 'package:flutter/material.dart';
import 'package:search_algorithm_visualiser/searches/search_class.dart';

class FixedStepSearch extends SearchClass {
  int position = 0;
  int stepSize;
  late int _initialStepSize;

  late bool _whileLoopConditionMet;

  FixedStepSearch(
      int arrSize, int searchFor, Animation<double>? offset, this.stepSize)
      : super(
          arrSize,
          searchFor,
          Paint(),
          offset,
        ) {
    _whileLoopConditionMet =
        (position < arrSize) && (arr[position].value < searchFor);
    _initialStepSize = stepSize;
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

    if (_whileLoopConditionMet) {
      codeAt =
          "\nwhile((position < arraySize) && (arr[position].value < searchFor)) {"
          "\n\tposition += stepSize;\n}";

      position += stepSize;
      arr[position].color = Colors.yellow;
      _whileLoopConditionMet =
          (position < arraySize) && (arr[position].value < searchFor);
      return;
    }

    if ((position >= arraySize) || (arr[position].value > searchFor)) {
      codeAt =
          "\nif ((position >= arraySize) || (arr[position].value > searchFor)) {";
      if (stepSize > 0) {
        codeAt += "\n\tif (stepSize > 0) {"
            "\n\t\tposition--;"
            "\n\t\tstepSize--;";
        position--;
        stepSize--;
        arr[position].color = Colors.yellow;
        if ((position < arraySize) && (arr[position].value == searchFor)) {
          codeAt +=
              "\n\t\tif ((position < arraySize) && (arr[position].value == searchFor)) {"
              "\n\t\t\treturn; // Found item"
              "\n\t\t}\n}";
          return;
        } else {
          codeAt += "\n\t}\n}";
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

  @override
  String getCodeScope() {
    return codeAt;
  }
}
