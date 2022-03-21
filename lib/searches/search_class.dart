import 'package:flutter/material.dart';
import 'package:search_algorithm_visualiser/array_element.dart';

// TODO: Add IncreasedFixedStepSize

abstract class SearchClass {
  static const double smallCanvasPixelSize = 20;
  static const double mediumCanvasPixelSize = 5;
  static const double largeCanvasPixelSize = 1;

  static const double smallGap = 1;
  static const double mediumGap = 0.5;
  static const double largeGap = 0.2;

  static const double maxAnimationHeight = 10;

  static final Map<Color, String> baseExplanations = {
    Colors.red: "Default colour, has no meaning",
    Colors.yellow: "Element which we are searching for",
    Colors.blue: "Element which the array is comparing",
  };

  static int calculateMaximumSize(double pixelSize, double gapSize) {
    int _screenWidth =
        MediaQueryData.fromWindow(WidgetsBinding.instance!.window)
            .size
            .width
            .toInt();

    int maxSize = (_screenWidth / pixelSize).floor();
    return ((_screenWidth - gapSize * maxSize) / pixelSize).floor();
  }

  late Paint paint;
  late Animation<double>? offset;

  late int arraySize;
  late int searchFor;
  late List<ArrayElement> arr;

  late List<int> fastArr;
  late int fastSearchFor;

  int fastIterationCount = 0;

  SearchClass(this.arraySize, this.searchFor, this.paint, this.offset) {
    arr = List.generate(arraySize, (index) => ArrayElement(index, Colors.red));
  }

  /*
    Assumes we only run for the live chart
   */
  void updateArray(int newSize) {
    fastArr = List.generate(newSize, (index) => index);
    fastSearchFor = (newSize * (searchFor / arraySize)).toInt();
  }

  void iteration() {
    arr[searchFor].color = Colors.yellow;
  }

  void fastRun() {
    fastIterationCount++;
  }

  void renderSmallSize(Canvas canvas, Size size) {
    for (var item in arr) {
      paint.color = item.color;

      TextPainter _textPainter = TextPainter(
        text: TextSpan(text: item.value.toString()),
        textAlign: TextAlign.justify,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: size.width);

      var i = item.value;
      var gap = smallGap;
      var _size = const Size(smallCanvasPixelSize, smallCanvasPixelSize);
      var pos = Offset(gap * i + (i * _size.width),
          50.0 + (item.color == Colors.blue ? offset!.value : 0));

      canvas.drawRect(pos & _size, paint);
      _textPainter.paint(canvas, pos + const Offset(2.5, 0));
    }
  }

  void renderMediumSize(Canvas canvas, Size size) {
    for (var item in arr) {
      paint.color = item.color;

      var i = item.value;
      var gap = mediumGap;
      var _size = const Size(mediumCanvasPixelSize, mediumCanvasPixelSize);
      var pos = Offset(gap * i + (i * _size.width),
          50 + (item.color == Colors.blue ? offset!.value : 0));

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
          50.0 + (item.color == Colors.blue ? offset!.value : 0));

      canvas.drawRect(pos & _size, paint);
    }
  }
}
