import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:search_algorithm_visualiser/misc/array_element.dart';
import 'package:search_algorithm_visualiser/widgets/algorithm_selection.dart';

// TODO: Add IncreasedFixedStepSize
// TODO: add finished bool to stop iteration count;

abstract class SearchClass {
  static const double smallCanvasPixelSize = 20;
  static const double mediumCanvasPixelSize = 5;
  static const double largeCanvasPixelSize = 1;

  static const double smallGap = 1;
  static const double mediumGap = 0.5;
  static const double largeGap = 0.2;

  static const double maxAnimationHeight = 10;

  static final Map<Color, String> baseExplanations = {
    Colors.blue: "Default colour, has no meaning",
    Colors.red: "Element which we are searching for",
    Colors.yellow: "Element which the array is comparing",
  };

  static int calculateMaximumSize(double pixelSize, double gapSize) {
    int _screenWidth =
    ((window.physicalSize / window.devicePixelRatio).width * 0.9).toInt();

    int maxSize = (_screenWidth / pixelSize).floor();
    return ((_screenWidth - gapSize * maxSize) / pixelSize).floor();
  }

  final Offset detailsOffset = Offset(100, 100);
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
  String codeAt = "";

  SearchClass(this.arraySize, this.searchFor, this.paint, this.offset) {
    arr = List.generate(arraySize, (index) => ArrayElement(index, Colors.blue));
    textPainter = TextPainter(
      text: const TextSpan(text: ""),
      textAlign: TextAlign.justify,
      textDirection: TextDirection.ltr,
    )
      ..layout(maxWidth: (window.physicalSize / window.devicePixelRatio).width);
  }

  /*
    Assumes we only run for the live chart
   */
  void updateArray(int newSize) {
    fastArr = List.generate(newSize, (index) => index);
    fastSearchFor = (newSize * (searchFor / arraySize)).toInt();
  }

  void iteration() {
    arr[searchFor].color = Colors.red;
    iterationCount++;
  }

  void fastRun();

  void resetFastIterCount() {
    fastOperationCount = 0;
  }

  Map<String, int> getVariableStates();

  String getCodeScope();

  void renderSmallSize(Canvas canvas, Size size) {
    for (var item in arr) {
      paint.color = item.color;

      textPainter.text = TextSpan(
          text: item.value.toString(), style: const TextStyle(fontSize: 12));
      textPainter.layout(maxWidth: double.infinity);

      var i = item.value;
      var gap = smallGap;
      var _size = const Size(smallCanvasPixelSize, smallCanvasPixelSize);
      var pos = Offset(gap * i + (i * _size.width),
          50.0 + (item.color == Colors.yellow ? offset!.value : 0));

      canvas.drawRect(pos & _size, paint);
      textPainter.paint(canvas, pos + const Offset(2.5, 0));
    }
  }

  void renderMediumSize(Canvas canvas, Size size) {
    for (var item in arr) {
      paint.color = item.color;

      var i = item.value;
      var gap = mediumGap;
      var _size = const Size(mediumCanvasPixelSize, mediumCanvasPixelSize);
      var pos = Offset(gap * i + (i * _size.width),
          50 + (item.color == Colors.yellow ? offset!.value : 0));

      canvas.drawRect(pos & _size, paint);
    }
  }

  var oldRows = List<List<Rect>>.empty(growable: true);

  void renderLargeSize(Canvas canvas, Size size) {
    for (var item in arr) {
      paint.color = item.color;

      var i = item.value;
      var gap = largeGap;
      var _size = const Size(largeCanvasPixelSize, largeCanvasPixelSize);
      var pos = Offset(gap * i + (i * _size.width),
          50.0 + (item.color == Colors.yellow ? offset!.value : 0));

      canvas.drawRect(pos & _size, paint);
    }
  }
}
