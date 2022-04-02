import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:search_algorithm_visualiser/searches/binary_search.dart';
import 'package:search_algorithm_visualiser/searches/fixed_step_search.dart';
import 'package:search_algorithm_visualiser/searches/increasing_step_size_search.dart';
import 'package:search_algorithm_visualiser/searches/linear_Search.dart';
import 'package:search_algorithm_visualiser/searches/search_class.dart';
import 'package:search_algorithm_visualiser/widgets/algorithm_selection.dart';

const Duration updateInterval = Duration(milliseconds: 250);
const Duration animationDuration = Duration(seconds: 1);

class PainterBuilder extends StatefulWidget {
  final Widget Function(BuildContext context, SearchClass searchClass) builder;

  final int arrSize;
  final int searchFor;
  final SearchAlgorithm searchAlgorithm;
  final int fixedStep;
  final double Function()? getSpeedSliderVal;
  final Function? notifyParent;
  late SearchClass Function() getSearch;
  bool Function()? getCanRun;

  PainterBuilder({
    Key? key,
    required this.builder,
    required this.arrSize,
    required this.searchFor,
    required this.searchAlgorithm,
    required this.fixedStep,
    required this.notifyParent,
    this.getSpeedSliderVal,
  }) : super(key: key);

  @override
  _PainterBuilderState createState() => _PainterBuilderState();
}

Widget customPainterBuilder(
  BuildContext context,
  int arrSize,
  int searchFor,
  SearchAlgorithm algorithm,
  int fixedStep,
  double Function() getSpeedSlider,
  Function? function,
) {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  return PainterBuilder(
    arrSize: arrSize,
    searchFor: searchFor,
    searchAlgorithm: algorithm,
    fixedStep: fixedStep,
    notifyParent: function,
    getSpeedSliderVal: getSpeedSlider,
    builder: (context, search) {
      return CustomPaint(
        painter: CustomCanvas(search),
      );
    },
  );
}

class _PainterBuilderState extends State<PainterBuilder>
    with TickerProviderStateMixin {
  _PainterBuilderState();

  late final Timer _timer;
  late SearchClass search;
  late AnimationController animationController;
  late Animation<double> offset;
  bool canRun = true;

  @override
  void initState() {
    super.initState();

    widget.getCanRun = () => canRun;

    animationController =
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
    ]).animate(animationController)
      ..addListener(() => setState(() {}));

    search = getSearchAlgorithm();

    widget.getSearch = () => search;

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
      case SearchAlgorithm.increasingStep:
        _search =
            IncreasingStepSizeSearch(widget.arrSize, widget.searchFor, offset);
        break;
    }
    return _search;
  }

  void _onTick() {
    if (widget.getSpeedSliderVal!().toInt() !=
        animationController.duration!.inMilliseconds * 10) {
      animationController.duration =
          Duration(milliseconds: widget.getSpeedSliderVal!().toInt() * 10);
    }

    if (canRun) {
      for (var element in search.arr) {
        element.color = Colors.blue;
      }

      search.iteration();

      animationController.reset();
      animationController.forward();
      widget.notifyParent!();
      setState(() {});
    }

    canRun = !animationController.isAnimating;
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
    animationController.dispose();
    _timer.cancel();
    super.dispose();
  }
}

class CustomCanvas extends CustomPainter {
  SearchClass search;

  CustomCanvas(
    this.search,
  );

  @override
  void paint(Canvas canvas, Size size) {
    search.render(canvas, size);
  }

  @override
  bool shouldRepaint(CustomCanvas oldDelegate) => true;
}
