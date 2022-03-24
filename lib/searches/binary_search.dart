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
  void printDetails(Canvas canvas) {
    textPainter.text = TextSpan(
        text: "Iteration: $iterationCount\n"
            "First: $first\nMiddle: $middle\nLast: $last\n"
            "\nCode: $codeAt");
    super.printDetails(canvas);
  }

  @override
  void iteration() {
    codeAt = "\nif (first <= last) {";

    if (first <= last) {
      codeAt += "\n\tif (arr[middle].value < searchFor) {";

      if (arr[middle].value < searchFor) {
        codeAt += "\n\t\tfirst = middle + 1; \n}"
            " else if (arr[middle].value == searchFor) {";

        first = middle + 1;
      } else if (arr[middle].value == searchFor) {
        codeAt += "\n\t\treturn \n}";
        super.iteration();
        return;
      } else {
        codeAt += "\n} else {\n\tlast = middle - 1;\n}";
        last = middle - 1;
      }

      codeAt += "\nmiddle = ((first + last) / 2).floor();";
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
    _fastFirst = 0;
    _fastLast = fastArr.length;
    while (_fastFirst <= _fastLast) {
      fastOperationCount++; // <= Compare
      _fastMiddle = ((_fastFirst + _fastLast) / 2).floor();
      fastOperationCount++; // Assign _fastMiddle
      fastOperationCount++; // Add first and last
      fastOperationCount++; // Divide by 2
      fastOperationCount++; // floor

      fastOperationCount++; // == Comparison
      if (fastArr[_fastMiddle] == fastSearchFor) {
        return;
      } else if (fastArr[_fastMiddle] > fastSearchFor) {
        fastOperationCount++; // > Comparison
        fastOperationCount++; // Assign last
        fastOperationCount++; // sub middle

        _fastLast = _fastMiddle - 1;
      } else {
        fastOperationCount++; // > Comparison

        fastOperationCount++; // Assign first
        fastOperationCount++; // add middle
        _fastFirst = _fastMiddle + 1;
      }
    }
  }
}
