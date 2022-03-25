import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:search_algorithm_visualiser/live_chart.dart';
import 'package:search_algorithm_visualiser/searches/binary_search.dart';
import 'package:search_algorithm_visualiser/searches/fixed_step_search.dart';
import 'package:search_algorithm_visualiser/searches/linear_Search.dart';
import 'package:search_algorithm_visualiser/searches/search_class.dart';
import 'package:search_algorithm_visualiser/widgets/algorithm_selection.dart';

const Duration updateInterval = Duration(milliseconds: 500);
const Duration animationDuration = Duration(seconds: 1);

// TODO: Live option to change animation speed [Animation Duration Slider in custom Painter]

// TODO: Try and implement the siv idea

// TODO: Add zoom

class PainterBuilder extends StatefulWidget {
  final Widget Function(BuildContext context, SearchClass searchClass) builder;

  final int arrSize;
  final int searchFor;
  final SearchAlgorithm searchAlgorithm;
  final int fixedStep;

  const PainterBuilder({
    Key? key,
    required this.builder,
    required this.arrSize,
    required this.searchFor,
    required this.searchAlgorithm,
    required this.fixedStep,
  }) : super(key: key);

  @override
  _PainterBuilderState createState() => _PainterBuilderState();
}

Widget customPainterBuilder(BuildContext context, int arrSize, int searchFor,
    SearchAlgorithm algorithm, int fixedStep) {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  return PainterBuilder(
    arrSize: arrSize,
    searchFor: searchFor,
    searchAlgorithm: algorithm,
    fixedStep: fixedStep,
    builder: (context, search) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LiveChart(
            search: search,
          ),
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
  _PainterBuilderState();

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

    search = getSearchAlgorithm();

    _timer = Timer.periodic(updateInterval, (timer) => {_onTick()});
  }

  SearchClass getSearchAlgorithm() {
    SearchClass _search;
    switch (widget.searchAlgorithm) {
      case SearchAlgorithm.linear:
        _search = LinearSearch(widget.arrSize, widget.searchFor, offset);
        break;
      case SearchAlgorithm.binary:
        _search = BinarySearch(
            0, widget.arrSize - 1, widget.arrSize, widget.searchFor, offset);
        break;
      case SearchAlgorithm.fixed:
        _search = FixedStepSearch(
            widget.arrSize, widget.searchFor, offset, widget.fixedStep);
        break;
    }
    return _search;
  }

  void _onTick() {
    if (canRun) {
      for (var element in search.arr) {
        element.color = Colors.blue;
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

    search.printDetails(canvas);
  }

  @override
  bool shouldRepaint(CustomCanvas oldDelegate) => true;
}
