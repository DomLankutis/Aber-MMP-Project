import 'package:flutter/material.dart';

class InfoWidget extends StatelessWidget {
  final String information;

  const InfoWidget({Key? key, required this.information}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: information,
      triggerMode: TooltipTriggerMode.tap,
      child: const Icon(Icons.info_outline, size: 18),
    );
  }
}
