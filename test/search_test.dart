import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:search_algorithm_visualiser/searches/binary_search.dart';
import 'package:search_algorithm_visualiser/searches/fixed_step_search.dart';
import 'package:search_algorithm_visualiser/searches/increasing_step_size_search.dart';
import 'package:search_algorithm_visualiser/searches/linear_Search.dart';

void main() {
  group('Linear Search', () {
    void runIterationsAndCheck(LinearSearch search) {
      while (!search.finished) {
        search.iteration();
      }

      expect(search.lookingAt, search.searchFor);
    }

    test("Array size is 100", () {
      LinearSearch search = LinearSearch(100, 0, null);

      expect(search.arr.length, 100);
    });

    test("Can find first element in array", () {
      LinearSearch search = LinearSearch(100, 0, null);

      runIterationsAndCheck(search);
    });

    test("Can find middle element in array", () {
      LinearSearch search = LinearSearch(100, 0, null);
      search.searchFor = (search.arr.length / 2).floor();
      runIterationsAndCheck(search);
    });

    test("Can find last element in array", () {
      LinearSearch search = LinearSearch(100, 0, null);
      search.searchFor = search.arr.length - 1;
      runIterationsAndCheck(search);
    });

    test("Can find random element in array", () {
      LinearSearch search = LinearSearch(100, 0, null);
      search.searchFor = Random().nextInt(search.arraySize - 1);
      runIterationsAndCheck(search);
    });

    test("getCode returns valid code example", () {
      LinearSearch search = LinearSearch(100, 0, null);

      expect(search.getCode(), [
        "for (; i < fastArr.length; i++) {",
        "    if (fastArr[i] == fastSearchFor) {",
        "        return;",
        "    }",
        "}",
      ]);
    });

    test("updateArray creates new array and updates fastSearchFor", () {
      LinearSearch search = LinearSearch(100, 0, null);

      search.updateArray(1000);
      expect(search.fastArr.length, 1000);
      expect(search.fastSearchFor, 0);
    });
  });

  group('Binary Search', () {
    void runIterationsAndCheck(BinarySearch search) {
      while (!search.finished) {
        search.iteration();
      }

      expect(search.middle, search.searchFor);
    }

    test("Array size is 100", () {
      BinarySearch search = BinarySearch(0, 99, 100, 0, null);

      expect(search.arr.length, 100);
    });

    test("Can find first element in array", () {
      BinarySearch search = BinarySearch(0, 99, 100, 0, null);

      runIterationsAndCheck(search);
    });

    test("Can find middle element in array", () {
      BinarySearch search = BinarySearch(0, 99, 100, 0, null);

      search.searchFor = (search.arr.length / 2).floor();
      runIterationsAndCheck(search);
    });

    test("Can find last element in array", () {
      BinarySearch search = BinarySearch(0, 99, 100, 0, null);

      search.searchFor = search.arr.length - 1;
      runIterationsAndCheck(search);
    });

    test("Can find random element in array", () {
      BinarySearch search = BinarySearch(0, 99, 100, 0, null);

      search.searchFor = Random().nextInt(search.arraySize - 1);
      runIterationsAndCheck(search);
    });

    test("getCode returns valid code example", () {
      BinarySearch search = BinarySearch(0, 99, 100, 0, null);

      expect(search.getCode(), [
        "while (_fastFirst <= _fastLast) {",
        "    _fastMiddle = ((_fastFirst + _fastLast) / 2).floor();",
        "    if (fastArr[_fastMiddle] == fastSearchFor) {",
        "        return;",
        "    } else if (fastArr[_fastMiddle] > fastSearchFor) {",
        "        _fastLast = _fastMiddle - 1;",
        "    } else {",
        "        fastFirst = _fastMiddle + 1;",
        "    }",
        "}",
      ]);
    });

    test("updateArray creates new array and updates fastSearchFor", () {
      BinarySearch search = BinarySearch(0, 99, 100, 0, null);

      search.updateArray(1000);
      expect(search.fastArr.length, 1000);
      expect(search.fastSearchFor, 0);
    });
  });

  group('Fixed Step Size Search', () {
    void runIterationsAndCheck(FixedStepSearch search) {
      while (!search.finished) {
        search.iteration();
      }

      expect(search.position, search.searchFor);
    }

    test("Array size is 100", () {
      FixedStepSearch search = FixedStepSearch(100, 0, null, 5);

      expect(search.arr.length, 100);
    });

    test("Can find first element in array", () {
      FixedStepSearch search = FixedStepSearch(100, 0, null, 5);

      runIterationsAndCheck(search);
    });

    test("Can find middle element in array", () {
      FixedStepSearch search = FixedStepSearch(100, 0, null, 5);

      search.searchFor = (search.arr.length / 2).floor();
      runIterationsAndCheck(search);
    });

    test("Can find last element in array", () {
      FixedStepSearch search = FixedStepSearch(100, 0, null, 5);

      search.searchFor = search.arr.length - 1;
      runIterationsAndCheck(search);
    });

    test("Can find random element in array", () {
      FixedStepSearch search = FixedStepSearch(100, 0, null, 5);

      search.searchFor = Random().nextInt(search.arraySize - 1);
      runIterationsAndCheck(search);
    });

    test("getCode returns valid code example", () {
      FixedStepSearch search = FixedStepSearch(100, 0, null, 5);

      expect(search.getCode(), [
        "while ((_pos < fastArr.length) && (fastArr[_pos] < fastSearchFor)) {",
        "    _pos += stepSize;",
        "}",
        "if ((_pos >= fastArr.length) || (fastArr[_pos] > fastSearchFor)) {",
        "    do {",
        "        _pos--;",
        "        _stepSize--;",
        "        if ((_pos < fastArr.length) && (fastArr[_pos] == fastSearchFor)) {",
        "            return;",
        "        }",
        "    } while (_stepSize > 0);",
        "}",
      ]);
    });

    test("updateArray creates new array and updates fastSearchFor", () {
      FixedStepSearch search = FixedStepSearch(100, 0, null, 5);

      search.updateArray(1000);
      expect(search.fastArr.length, 1000);
      expect(search.fastSearchFor, 0);
    });
  });

  group('Increasing Step Size Search', () {
    void runIterationsAndCheck(IncreasingStepSizeSearch search) {
      while (!search.finished) {
        search.iteration();
      }

      expect(search.position, search.searchFor);
    }

    test("Array size is 100", () {
      IncreasingStepSizeSearch search = IncreasingStepSizeSearch(100, 0, null);

      expect(search.arr.length, 100);
    });

    test("Can find first element in array", () {
      IncreasingStepSizeSearch search = IncreasingStepSizeSearch(100, 0, null);

      runIterationsAndCheck(search);
    });

    test("Can find middle element in array", () {
      IncreasingStepSizeSearch search = IncreasingStepSizeSearch(100, 0, null);

      search.searchFor = (search.arr.length / 2).floor();
      runIterationsAndCheck(search);
    });

    test("Can find last element in array", () {
      IncreasingStepSizeSearch search = IncreasingStepSizeSearch(100, 0, null);

      search.searchFor = search.arr.length - 1;
      runIterationsAndCheck(search);
    });

    test("Can find random element in array", () {
      IncreasingStepSizeSearch search = IncreasingStepSizeSearch(100, 0, null);

      search.searchFor = Random().nextInt(search.arraySize - 1);
      runIterationsAndCheck(search);
    });

    test("getCode returns valid code example", () {
      IncreasingStepSizeSearch search = IncreasingStepSizeSearch(100, 0, null);

      expect(search.getCode(), [
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
      ]);
    });

    test("updateArray creates new array and updates fastSearchFor", () {
      IncreasingStepSizeSearch search = IncreasingStepSizeSearch(100, 0, null);

      search.updateArray(1000);
      expect(search.fastArr.length, 1000);
      expect(search.fastSearchFor, 0);
    });
  });
}
