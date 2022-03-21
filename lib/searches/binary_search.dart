import 'package:flutter/material.dart';
import 'package:search_algorithm_visualiser/searches/search_class.dart';

class BinarySearch extends SearchClass {
  int first;
  int last;
  int middle = 0;

  late int _fastFirst;
  late int _fastLast;
  late int _fastMiddle;

  BinarySearch(this.first, this.last, int arrSize, int searchFor,
      Animation<double>? offset)
      : super(
          arrSize,
          searchFor,
          Paint(),
          offset,
        ) {
    middle = getMiddle();
    _fastFirst = first;
    _fastLast = last;
    _fastMiddle = middle;
  }

  @override
  void updateArray(int newSize) {
    super.updateArray(newSize);
    _fastLast = fastArr.length;
  }

  int getMiddle() {
    return ((first + last) / 2).floor();
  }

  /*
   Want to have this in SearchClass and then override with extras but cant figure it out,
   not worth spending lots of time on this.
   */
  static Map<Color, String> getColorExplanations() {
    return {
      ...SearchClass.baseExplanations,
      Colors.green: "Shows which element is first and last",
    };
  }

  @override
  void iteration() {
    if (first <= last) {
      if (arr[middle].value < searchFor) {
        first = middle + 1;
      } else if (arr[middle].value == searchFor) {
        return;
      } else {
        last = middle - 1;
      }

      middle = getMiddle();

      arr[first].color = Colors.green;
      arr[last].color = Colors.green;
      arr[middle].color = Colors.blue;
    }

    if (first > last) {
      return;
    }

    super.iteration();
  }

  @override
  void renderLargeSize(Canvas canvas, Size size) {
    for (var item in arr) {
      paint.color = item.color;

      var i = item.value;
      var gap = 0.2;
      var _size = const Size(
          SearchClass.largeCanvasPixelSize, SearchClass.largeCanvasPixelSize);
      var pos = Offset(gap * i + (i * _size.width),
          50 + ((first <= i && i <= last) ? offset!.value : 0));

      canvas.drawRect(pos & _size, paint);
    }
  }

  @override
  void fastRun() {
    if (_fastLast >= _fastFirst) {
      _fastMiddle = ((_fastFirst + _fastLast) / 2).floor();
      if (fastSearchFor == fastArr[_fastMiddle]) {
        return;
      } else if (fastSearchFor > fastArr[_fastMiddle]) {
        _fastFirst = _fastMiddle + 1;
        fastRun();
      } else {
        _fastLast = _fastMiddle - 1;
        fastRun();
      }
    }
  }
}
