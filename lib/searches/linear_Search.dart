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
    for (int i = 0; i < fastArr.length; i++) {
      if (fastArr[i] == fastSearchFor) {
        return;
      }
    }
  }

  @override
  void iteration() {
    arr[lookingAt].color = Colors.blue;

    if (arr[lookingAt].value != searchFor) {
      lookingAt++;
    }

    super.iteration();
  }
}
