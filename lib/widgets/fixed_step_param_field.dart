import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:search_algorithm_visualiser/widgets/algorithm_selection.dart';

class FixedStepParameterField extends StatelessWidget {
  final SearchAlgorithm? algorithm;
  final TextEditingController Function() getEditingController;

  FixedStepParameterField(
      {Key? key, required this.algorithm, required this.getEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (algorithm == SearchAlgorithm.fixed) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: getEditingController(),
            decoration: const InputDecoration(labelText: "Step size"),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        ),
      );
    }
    return Container();
    // return null;
  }
}
