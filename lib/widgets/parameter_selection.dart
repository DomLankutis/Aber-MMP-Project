import 'package:flutter/material.dart';
import 'package:search_algorithm_visualiser/widgets/algorithm_selection.dart';

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
  double _arraySizeSlider = 0;
  String? _elementToSearchFor;

  void parameterRadioListChanged(String? val) {
    widget.radioSetCallback(val);
    setState(() {
      _elementToSearchFor = val;
    });
  }

  void sliderParameterChanged(double? val) {
    widget.sliderSetCallback(val);
    setState(() {
      _arraySizeSlider = val!;
    });
  }

  _ParameterSelectionState();

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: Text("Select Parameters"),
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
                        child: Slider(
                          value: _arraySizeSlider,
                          min: 0,
                          max: widget.maximumArraySize,
                          divisions: widget.maximumArraySize.toInt(),
                          label: _arraySizeSlider.round().toString(),
                          onChanged: sliderParameterChanged,
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
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Text('Search For'),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 10, 0, 15),
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
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
