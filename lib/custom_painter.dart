import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:search_algorithm_visualiser/home_page.dart';
import 'package:search_algorithm_visualiser/live_chart.dart';
import 'package:search_algorithm_visualiser/searches/binary_search.dart';
import 'package:search_algorithm_visualiser/searches/fixed_step_search.dart';
import 'package:search_algorithm_visualiser/searches/linear_Search.dart';
import 'package:search_algorithm_visualiser/searches/search_class.dart';

const Duration updateInterval = Duration(milliseconds: 500);
const Duration animationDuration = Duration(seconds: 1);

// TODO: List more information as text, Iteration count, variables and their states

// TODO: Show code of search and highlight which section we are currently running.

// TODO: Try and implement the siv idea

class PainterBuilder extends StatefulWidget {
  final Widget Function(BuildContext context, SearchClass searchClass) builder;

  final int arrSize;
  final int searchFor;
  final SearchAlgorithm searchAlgorithm;

  const PainterBuilder({
    Key? key,
    required this.builder,
    required this.arrSize,
    required this.searchFor,
    required this.searchAlgorithm,
  }) : super(key: key);

  @override
  _PainterBuilderState createState() =>
      _PainterBuilderState(arrSize, searchFor, searchAlgorithm);
}

Widget customPainterBuilder(BuildContext context, int arrSize, int searchFor,
    SearchAlgorithm algorithm) {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  return PainterBuilder(
    arrSize: arrSize,
    searchFor: searchFor,
    searchAlgorithm: algorithm,
    builder: (context, search) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LiveChart(plotData: search.plotData),
          CustomPaint(
            painter: CustomCanvas(search),
          )
        ],
      );
    },
  );
}

class _PainterBuilderState extends State<PainterBuilder>
    with TickerProviderStateMixin {
  int arrSize;
  int searchFor;
  SearchAlgorithm searchAlgorithm;

  _PainterBuilderState(this.arrSize, this.searchFor, this.searchAlgorithm);

  late final Timer _timer;
  late SearchClass search;
  late AnimationController _animationController;
  late Animation<double> offset;
  bool canRun = true;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: animationDuration);

    offset = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: SearchClass.maxAnimationHeight),
        weight: 10,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: SearchClass.maxAnimationHeight, end: 0),
        weight: 5,
      ),
    ]).animate(_animationController)
      ..addListener(() => setState(() {}));

    switch (searchAlgorithm) {
      case SearchAlgorithm.linear:
        search = LinearSearch(arrSize, searchFor, offset);
        break;
      case SearchAlgorithm.binary:
        search = BinarySearch(0, arrSize - 1, arrSize, searchFor, offset);
        break;
      case SearchAlgorithm.fixed:
        search = FixedStepSearch(
            arrSize, searchFor, offset, sqrt(arrSize).round().abs());
        break;
    }

    _timer = Timer.periodic(updateInterval, (timer) => {_onTick()});
  }

  void _onTick() {
    if (canRun) {
      for (var element in search.arr) {
        element.color = Colors.red;
      }

      search.iteration();

      _animationController.reset();
      _animationController.forward();
      setState(() {});
    }

    canRun = !_animationController.isAnimating;
  }

  @override
  void didChangeDependencies() {
    // _ticker.muted = !TickerMode.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final result = widget.builder(context, search);
    return result;
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer.cancel();
    super.dispose();
  }
}

class CustomCanvas extends CustomPainter {
  SearchClass search;

  CustomCanvas(this.search);

  @override
  void paint(Canvas canvas, Size size) {
    int _maximumSmallSize = SearchClass.calculateMaximumSize(
        SearchClass.smallCanvasPixelSize, SearchClass.smallGap);

    int _maximumMediumSize = SearchClass.calculateMaximumSize(
        SearchClass.mediumCanvasPixelSize, SearchClass.mediumGap);

    if (search.arraySize <= _maximumSmallSize) {
      search.renderSmallSize(canvas, size);
    } else if (search.arraySize <= _maximumMediumSize) {
      search.renderMediumSize(canvas, size);
    } else {
      search.renderLargeSize(canvas, size);
    }
  }

  @override
  bool shouldRepaint(CustomCanvas oldDelegate) => true;
}
