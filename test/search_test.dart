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
  });
}
