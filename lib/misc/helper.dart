import 'package:flutter/material.dart';
import 'package:search_algorithm_visualiser/widgets/algorithm_selection.dart';

const Map<SearchAlgorithm, Color> lineColor = {
  SearchAlgorithm.linear: Colors.red,
  SearchAlgorithm.binary: Colors.blue,
  SearchAlgorithm.fixed: Colors.green,
};

String getAlgorithmName(SearchAlgorithm searchAlgorithm) {
  String str = "";
  switch (searchAlgorithm) {
    case SearchAlgorithm.linear:
      str = "Linear Search";
      break;
    case SearchAlgorithm.binary:
      str = "Binary Search";
      break;
    case SearchAlgorithm.fixed:
      str = "Fixed Step Size Search";
      break;
  }
  return str;
}
