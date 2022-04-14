import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:search_algorithm_visualiser/misc/array_element.dart';
import 'package:search_algorithm_visualiser/widgets/algorithm_selection.dart';

abstract class SearchClass {
  static const double maxAnimationHeight = 10;
  static const double smallestPixelSize = 2;
  static const double gap = 1;

  static final Map<Color, String> baseExplanations = {
    Colors.blue: "Default colour, has no meaning",
    Colors.red: "Element which we are searching for",
    Colors.yellow: "Element which the array is comparing",
  };

  static int getMaxArraySize() {
    var _screenWidth =
        (window.physicalSize / window.devicePixelRatio).width * 0.75;
    var arraySize = _screenWidth / smallestPixelSize;
    var totalGapSize = (_screenWidth / arraySize) * gap;
    var effectiveScreenSize = _screenWidth - totalGapSize;
    var trueArraySize = effectiveScreenSize ~/ smallestPixelSize;

    return trueArraySize;
  }

  late TextPainter textPainter;

  late Paint paint;
  late Animation<double>? offset;

  late int arraySize;
  late int searchFor;
  late List<ArrayElement> arr;

  late List<int> fastArr;
  late int fastSearchFor;

  late SearchAlgorithm identifier;

  int iterationCount = 0;
  int fastOperationCount = 0;
  List<String> code = [];
  List<int> codeAt = [];
  bool finished;

  SearchClass(this.arraySize, this.searchFor, this.paint, this.offset)
      : finished = false {
    arr = List.generate(arraySize, (index) => ArrayElement(index, Colors.blue));

    textPainter = TextPainter(
      text: const TextSpan(text: ""),
      textAlign: TextAlign.justify,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: (window.physicalSize / window.devicePixelRatio).width);
  }

  void fastRun();

  Map<String, int> getVariableStates();

  List<String> getCode() => code;

  List<int> getCodeAt() => codeAt;

  void setCodeAt(List<int> codeAt) {
    this.codeAt = codeAt;
  }

  /*
    Assumes we only run for the live chart
   */
  void updateArray(int newSize) {
    fastArr = List.generate(newSize, (index) => index);
    fastSearchFor = (newSize * (searchFor / arraySize)).toInt();
  }

  void iteration() {
    if (arr.isNotEmpty) {
      arr[searchFor].color = Colors.red;
    }

    if (!finished) {
      iterationCount++;
    }
  }

  void resetFastIterCount() {
    fastOperationCount = 0;
  }

  Size getPixelSize(Size canvasSize) {
    var pixelSize = canvasSize.width / arraySize;
    var totalGapSize = (canvasSize.width / pixelSize) * gap;
    var effectiveScreenSize = canvasSize.width - totalGapSize;
    var truePixelSize = effectiveScreenSize / arraySize;

    return Size.square(truePixelSize);
  }

  void render(Canvas canvas, Size size) {
    for (var item in arr) {
      paint.color = item.color;

      var i = item.value;
      var _size = getPixelSize(size);
      var pos = Offset(gap * i + (i * _size.width),
          50.0 + (item.color == Colors.yellow ? offset!.value : 0));

      if (_size.width >= 15) {
        textPainter.text = TextSpan(
            text: item.value.toString(), style: const TextStyle(fontSize: 12));
        textPainter.layout(maxWidth: double.infinity);
      }

      canvas.drawRect(pos & _size, paint);
      textPainter.paint(
          canvas,
          pos +
              Offset(_size.width / 2 - textPainter.width / 2,
                  _size.width / 2 - textPainter.height / 2));
    }
  }
}
