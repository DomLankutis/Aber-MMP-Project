import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:search_algorithm_visualiser/misc/helper.dart';
import 'package:search_algorithm_visualiser/searches/binary_search.dart';
import 'package:search_algorithm_visualiser/searches/fixed_step_search.dart';
import 'package:search_algorithm_visualiser/searches/increasing_step_size_search.dart';
import 'package:search_algorithm_visualiser/searches/linear_Search.dart';
import 'package:search_algorithm_visualiser/searches/search_class.dart';
import 'package:search_algorithm_visualiser/widgets/algorithm_selection.dart';

class LiveChart extends StatefulWidget {
  final int arraySize;
  final int searchFor;
  final int fixedStep;

  final Map<SearchAlgorithm, bool> enabledSearches;

  const LiveChart({
    Key? key,
    required this.arraySize,
    required this.searchFor,
    required this.fixedStep,
    required this.enabledSearches,
  }) : super(key: key);

  @override
  _LiveChartState createState() => _LiveChartState();
}

class _LiveChartState extends State<LiveChart> {
  late Timer timer;

  List<LineChartBarData> data = List<LineChartBarData>.empty(growable: true);
  List<SearchClass> searches = List.empty(growable: true);
  int arraySize = 0;

  void calculatePlotData() {
    arraySize += 10000;
    for (var i = 0; i < searches.length; i++) {
      SearchClass search = searches[i];

      search.resetFastIterCount();
      search.updateArray(arraySize);
      search.fastRun();

      data[i] = LineChartBarData(
        isCurved: true,
        preventCurveOverShooting: true,
        dotData: FlDotData(show: false),
        colors: [lineColor[search.identifier]!],
        spots: [
          ...data[i].spots,
          FlSpot(arraySize.toDouble(), search.fastOperationCount.toDouble())
        ],
      );
    }
    setState(() {});
  }

  void generateSearches() {
    if (widget.enabledSearches[SearchAlgorithm.linear]!) {
      searches.add(LinearSearch(widget.arraySize, widget.searchFor, null));
    }

    if (widget.enabledSearches[SearchAlgorithm.binary]!) {
      searches.add(BinarySearch(
          0, widget.arraySize - 1, widget.arraySize, widget.searchFor, null));
    }

    if (widget.enabledSearches[SearchAlgorithm.fixed]!) {
      searches.add(FixedStepSearch(
          widget.arraySize,
          widget.searchFor,
          null,
          widget.fixedStep == 0
              ? sqrt(widget.arraySize).abs().toInt()
              : widget.fixedStep));
    }

    if (widget.enabledSearches[SearchAlgorithm.increasingStep]!) {
      searches.add(
          IncreasingStepSizeSearch(widget.arraySize, widget.searchFor, null));
    }
  }

  void initBarData() {
    for (var i = 0; i < searches.length; i++) {
      data.add(LineChartBarData());
    }
  }

  @override
  void initState() {
    super.initState();

    generateSearches();
    initBarData();

    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      calculatePlotData();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LiveChart oldWidget) {
    super.didUpdateWidget(oldWidget);

    arraySize = 0;
    searches.clear();
    data.clear();

    generateSearches();
    initBarData();
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: data,
      ),
    );
  }
}
