import 'package:flutter/material.dart';
import 'package:search_algorithm_visualiser/searches/search_class.dart';
import 'package:search_algorithm_visualiser/widgets/algorithm_selection.dart';

class IncreasingStepSizeSearch extends SearchClass {
  late int left;
  late int right;
  late int position;
  late int stepLength;
  late bool _whileConditionMet;

  static Map<Color, String> getColorExplanations() {
    return {
      ...SearchClass.baseExplanations,
      Colors.green: "Shows which element is first and last"
    };
  }

  IncreasingStepSizeSearch(
      int arraySize, int searchFor, Animation<double>? offset)
      : super(arraySize, searchFor, Paint(), offset) {
    left = 0;
    right = arraySize - 1;
    position = left;
    stepLength = 1;

    _whileConditionMet = (left <= right);

    identifier = SearchAlgorithm.increasingStep;

    code = [
      "while (_left <= _right) {",
      "    if (fastArr[_position] == fastSearchFor) {",
      "        return;",
      "    } else if (fastArr[_position] > fastSearchFor) {",
      "        _right = _position - 1;",
      "        _stepLength = 1;",
      "        _position = _left;",
      "    } else {",
      "        _left = _position + 1;",
      "        if ((_position + _stepLength) <= _right) {",
      "            _position += _stepLength;",
      "            _stepLength *= 2;",
      "        } else {",
      "            _stepLength = 1;",
      "            _position += _stepLength;",
      "        }",
      "    }",
      "}",
    ];
  }

  @override
  void iteration() {
    super.iteration();
    if (_whileConditionMet) {
      setCodeAt([0, 17]);
      _whileConditionMet = (left <= right);
      if (arr[position].value == searchFor) {
        setCodeAt([0, 17, 1, 2, 3]);
        finished = true;
        return;
      } else if (arr[position].value > searchFor) {
        setCodeAt([0, 17, 3, 4, 5, 6, 7]);
        right = position - 1;
        stepLength = 1;
        position = left;
      } else {
        setCodeAt([0, 17, 7, 8, 16]);
        left = position + 1;
        if (position + stepLength <= right) {
          setCodeAt([0, 17, 9, 10, 11, 12]);
          position += stepLength;
          stepLength *= 2;
        } else {
          setCodeAt([0, 17, 12, 13, 14, 15]);
          stepLength = 1;
          position += stepLength;
        }
      }

      arr[left].color = Colors.green;
      arr[right].color = Colors.green;
      arr[position].color = Colors.yellow;
    }
  }

  @override
  void fastRun() {
    int _left = 0;
    int _right = fastArr.length - 1;
    int _position = _left;
    int _stepLength = 1;
    while (_left <= _right) {
      fastOperationCount++; // <= comparison

      fastOperationCount++; // == comparison
      if (fastArr[_position] == fastSearchFor) {
        return;
      } else if (fastArr[_position] > fastSearchFor) {
        fastOperationCount++; // > comparison

        _right = _position - 1;
        fastOperationCount++; // sub _pos
        fastOperationCount++; // assign _right

        _stepLength = 1;
        fastOperationCount++; // assign _step

        _position = _left;
        fastOperationCount++; // assign _pos
      } else {
        fastOperationCount++; // > Comparison from previous if

        _left = _position + 1;
        fastOperationCount++; // add _pos
        fastOperationCount++; // assign _left

        fastOperationCount++; // addition
        fastOperationCount++; // <= comparison
        if ((_position + _stepLength) <= _right) {
          _position += _stepLength;
          fastOperationCount++; // add
          fastOperationCount++; // assign

          _stepLength *= 2;
          fastOperationCount++; // multiply
          fastOperationCount++; // assign

        } else {
          _stepLength = 1;
          fastOperationCount++; // assign

          _position += _stepLength;
          fastOperationCount++; // add
          fastOperationCount++; // assign
        }
      }
    }
  }

  @override
  Map<String, int> getVariableStates() {
    return {
      "Iteration": iterationCount,
      "Position": position,
      "Step Length": stepLength,
      "Left": left,
      "Right": right,
    };
  }
}
