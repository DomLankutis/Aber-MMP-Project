import 'package:flutter/material.dart';
import 'package:search_algorithm_visualiser/styles/custom_slider_thumb_rect.dart';
import 'package:search_algorithm_visualiser/widgets/algorithm_selection.dart';
import 'package:search_algorithm_visualiser/widgets/info_widget.dart';

import 'fixed_step_param_field.dart';

class ParameterSelection extends StatefulWidget {
  final SearchAlgorithm algorithm;
  final double maximumArraySize;
  final Function(String? val) radioSetCallback;
  final Function(double? val) sliderSetCallback;
  final TextEditingController Function() getEditingController;

  const ParameterSelection(
      {Key? key,
      required this.algorithm,
      required this.maximumArraySize,
      required this.radioSetCallback,
      required this.sliderSetCallback,
      required this.getEditingController})
      : super(key: key);

  @override
  _ParameterSelectionState createState() => _ParameterSelectionState();
}

class _ParameterSelectionState extends State<ParameterSelection> {
  late double _arraySizeSlider;
  String? _elementToSearchFor;

  void parameterRadioListChanged(String? val) {
    widget.radioSetCallback(val);
    setState(() {
      _elementToSearchFor = val;
    });
  }

  void sliderParameterChanged(double? val) {
    widget.sliderSetCallback(val!.floorToDouble());
    setState(() {
      _arraySizeSlider = val.floorToDouble();
    });
  }

  _ParameterSelectionState();

  @override
  void initState() {
    super.initState();
    _arraySizeSlider = 10;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Text("Select Parameters"),
                    ),
                    InfoWidget(
                        information:
                            "Select the all parameters for the chosen algorithm")
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.all(5),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          label: Text("Array Size"),
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            thumbShape: CustomSliderThumbRect(
                              min: 10,
                              max: widget.maximumArraySize.toInt() - 10,
                              thumbRadius: 6,
                              thumbHeight: 40,
                            ),
                            showValueIndicator: ShowValueIndicator.never,
                          ),
                          child: Slider(
                            value: _arraySizeSlider,
                            min: 10,
                            max: widget.maximumArraySize,
                            divisions: widget.maximumArraySize.toInt() - 10,
                            label: _arraySizeSlider.floor().toString(),
                            onChanged: sliderParameterChanged,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: FixedStepParameterField(
                    algorithm: widget.algorithm,
                    getEditingController: widget.getEditingController),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.all(5),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: Text('Search For'),
                          ),
                          InfoWidget(
                            information:
                                "Select which element you would like to search for in the array",
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 15),
                        child: Card(
                          child: Column(
                            children: [
                              RadioListTile<String>(
                                title: const Text("First Element"),
                                onChanged: parameterRadioListChanged,
                                groupValue: _elementToSearchFor,
                                value: "first",
                                visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity,
                                ),
                              ),
                              RadioListTile<String>(
                                title: const Text("Middle Element"),
                                onChanged: parameterRadioListChanged,
                                groupValue: _elementToSearchFor,
                                value: "middle",
                                visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity,
                                ),
                              ),
                              RadioListTile<String>(
                                title: const Text("Last Element"),
                                onChanged: parameterRadioListChanged,
                                groupValue: _elementToSearchFor,
                                value: "last",
                                visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity,
                                ),
                              ),
                              RadioListTile<String>(
                                title: const Text("Random Element"),
                                onChanged: parameterRadioListChanged,
                                groupValue: _elementToSearchFor,
                                value: "random",
                                visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
