import 'package:flutter/material.dart';
import 'package:search_algorithm_visualiser/searches/search_class.dart';

class FixedStepSearch extends SearchClass {
  int position = 0;
  int stepSize;

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
  }

  static Map<Color, String> getColorExplanations() {
    return {
      Colors.red: "Default colour, has no meaning",
      Colors.blue: "Element which the array is comparing",
    };
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
