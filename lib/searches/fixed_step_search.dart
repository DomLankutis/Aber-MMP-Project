import 'package:flutter/material.dart';
import 'package:search_algorithm_visualiser/searches/search_class.dart';

// TODO: StepSize as parameter in gui
class FixedStepSearch extends SearchClass {
  int position = 0;
  int stepSize;
  late int _initialStepSize;

  late bool _whileLoopConditionMet;

  FixedStepSearch(
      int arrSize, int searchFor, Animation<double> offset, this.stepSize)
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

  static Map<Color, String> getColorExplanations() {
    return {
      Colors.red: "Default colour, has no meaning",
      Colors.blue: "Element which the array is comparing",
    };
  }

  @override
  void fastRun() {
    int _pos = 0;
    int _stepSize = _initialStepSize;
    while ((_pos < arraySize) && (arr[_pos].value < searchFor)) {
      _pos += stepSize;
    }
    if ((_pos >= arraySize) || (arr[_pos].value > searchFor)) {
      do {
        _pos--;
        _stepSize--;
        if ((_pos < arraySize) && (arr[_pos].value == searchFor)) {
          return;
        }
      } while (_stepSize > 0);
    }
    return;
  }

  @override
  void iteration() {
    if (_whileLoopConditionMet) {
      position += stepSize;
      arr[position].color = Colors.blue;
      _whileLoopConditionMet =
          (position < arraySize) && (arr[position].value < searchFor);
    }
    if ((position >= arraySize) || (arr[position].value > searchFor)) {
      if (stepSize > 0) {
        position--;
        stepSize--;
        arr[position].color = Colors.blue;
        if ((position < arraySize) && (arr[position].value == searchFor)) {
          return;
        }
      }
    }
    super.iteration();
  }
}
