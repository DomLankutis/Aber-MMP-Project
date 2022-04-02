import 'package:flutter/material.dart';
import 'package:search_algorithm_visualiser/screens/animation_screen.dart';
import 'package:search_algorithm_visualiser/screens/chart_screen.dart';
import 'package:search_algorithm_visualiser/widgets/algorithm_selection.dart';
import 'package:search_algorithm_visualiser/widgets/expanding_slider.dart';

class DetailsScreen extends StatefulWidget {
  final int arrSize;
  final int searchFor;
  final SearchAlgorithm algorithm;
  final int fixedStep;

  const DetailsScreen({
    Key? key,
    required this.arrSize,
    required this.searchFor,
    required this.algorithm,
    required this.fixedStep,
  }) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with TickerProviderStateMixin {
  final List<bool> isSelected = List<bool>.from({true, false});

  late ExpandingSlider slider;
  double speedSlider = 100;

  void setSpeedSlider(double? val) {
    setState(() {
      speedSlider = val!;
    });
  }

  double getSpeedSlider() {
    return speedSlider;
  }

  Widget givenScreen(List<bool> toggle) {
    if (toggle[0] == true) {
      //CustomPainter
      return AnimationScreen(
        arrSize: widget.arrSize,
        searchFor: widget.searchFor,
        algorithm: widget.algorithm,
        fixedStep: widget.fixedStep,
        getSpeedSliderVal: getSpeedSlider,
      );
    } else {
      // Live Chart
      return ChartScreen(
        arraySize: widget.arrSize,
        searchFor: widget.searchFor,
        fixedStep: widget.fixedStep,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: ToggleButtons(
                    direction: Axis.vertical,
                    isSelected: isSelected,
                    children: const [
                      Icon(Icons.animation),
                      Icon(Icons.insert_chart_outlined),
                    ],
                    onPressed: (int index) {
                      setState(() {
                        for (var i = 0; i < isSelected.length; i++) {
                          if (i == index) {
                            isSelected[i] = true;
                          } else {
                            isSelected[i] = false;
                          }
                        }
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: ExpandingSlider(
                    setter: setSpeedSlider,
                    getter: getSpeedSlider,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 14,
            child: givenScreen(isSelected),
          ),
        ],
      ),
    );
  }
}
