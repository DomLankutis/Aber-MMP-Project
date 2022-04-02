import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class ExpandingSlider extends StatefulWidget {
  final Function(double? val) setter;
  final double Function() getter;

  const ExpandingSlider({
    Key? key,
    required this.setter,
    required this.getter,
  }) : super(key: key);

  @override
  _ExpandingSliderState createState() => _ExpandingSliderState();
}

class _ExpandingSliderState extends State<ExpandingSlider> {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: Expandable(
        collapsed: ExpandableButton(
          child: const Icon(Icons.speed),
        ),
        expanded: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ExpandableButton(
              child: ExpandableIcon(),
            ),
            Flexible(
              child: RotatedBox(
                quarterTurns: 1,
                child: Slider(
                  min: 0,
                  max: 100,
                  divisions: 100,
                  value: widget.getter(),
                  label: widget.getter().toInt().toString(),
                  onChanged: widget.setter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
