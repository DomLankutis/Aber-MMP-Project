import 'package:flutter/material.dart';
import 'package:search_algorithm_visualiser/searches/search_class.dart';

class LinearSearch extends SearchClass {
  int lookingAt = 0;

  LinearSearch(int arrSize, int searchFor, Animation<double>? offset)
      : super(
          arrSize,
          searchFor,
          Paint(),
          offset,
        );

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
    arr[lookingAt].color = Colors.blue;

    codeAt = "found";

    if (arr[lookingAt].value != searchFor) {
      lookingAt++;
      codeAt = "if (arr[lookingAt].value != searchFor)";
    }

    super.iteration();
  }

  @override
  void printDetails(Canvas canvas) {
    textPainter.text = TextSpan(
        text: "Iteration: $iterationCount\n"
            "Looking at: $lookingAt\n"
            "Code: $codeAt");

    super.printDetails(canvas);
  }
}
