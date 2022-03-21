import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:search_algorithm_visualiser/searches/search_class.dart';

//TODO: Make chart update while modal is on. Perhaps use a callback function to notify widget update
class LiveChart extends StatelessWidget {
  final SearchClass search;

  const LiveChart({Key? key, required this.search}) : super(key: key);

  List<FlSpot> calculatePlotData() {
    List<FlSpot> data = List<FlSpot>.empty(growable: true);
    for (int i = 0; i < 10000; i++) {
      SearchClass _search = search;
      final stopwatch = Stopwatch()..start();
      _search.fastRun();
      stopwatch.stop();
      var timeTaken = stopwatch.elapsed.inMicroseconds;
      data.add(FlSpot(i.toDouble(), timeTaken.toDouble()));
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text("Live Chart"),
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: LineChart(LineChartData(
                  lineBarsData: [LineChartBarData(spots: calculatePlotData())],
                )),
              );
            });
      },
    );
  }
}
