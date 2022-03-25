import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:search_algorithm_visualiser/widgets/algorithm_selection.dart';

class FixedStepParameterField extends StatelessWidget {
  final SearchAlgorithm? algorithm;
  final TextEditingController textEditingController = TextEditingController();

  FixedStepParameterField({Key? key, required this.algorithm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (algorithm == SearchAlgorithm.fixed) {
      return Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: TextField(
            controller: textEditingController,
            decoration: InputDecoration(labelText: "Step size"),
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
