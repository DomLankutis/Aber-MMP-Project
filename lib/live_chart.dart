import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:search_algorithm_visualiser/searches/search_class.dart';

//TODO: Make chart update while modal is on. Perhaps use a callback function to notify widget update
// TODO: do  all searches

class LiveChart extends StatelessWidget {
  final SearchClass search;

  const LiveChart({Key? key, required this.search}) : super(key: key);

  // Run this with a set state or something and it should update as it runs
  List<FlSpot> calculatePlotData() {
    List<FlSpot> data = List<FlSpot>.empty(growable: true);
    for (int i = 1; i < 5000000; i += 100000) {
      search.resetFastIterCount();
      search.updateArray(i);
      search.fastRun();
      data.add(FlSpot(i.toDouble(), search.fastOperationCount.toDouble()));
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
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: false),
                      spots: calculatePlotData(),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
