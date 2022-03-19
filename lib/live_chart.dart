import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

//TODO: Make chart update while modal is on. Perhaps use a callback function to notify widget update
class LiveChart extends StatelessWidget {
  final List<FlSpot> plotData;

  const LiveChart({Key? key, required this.plotData}) : super(key: key);

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
                  lineBarsData: [LineChartBarData(spots: plotData)],
                )),
              );
            });
      },
    );
  }
}
