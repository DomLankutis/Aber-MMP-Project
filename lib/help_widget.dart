import 'package:flutter/material.dart';

Widget rectExplainer(Color color, String text) {
  return Card(
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: SizedBox(
            width: 20,
            height: 20,
            child: Container(
              color: color,
            ),
          ),
        ),
        Text(text),
      ],
    ),
  );
}

class HelpWidget extends StatelessWidget {
  final Map<Color, String> colorsToExplain;

  const HelpWidget({Key? key, required this.colorsToExplain}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (Color color in colorsToExplain.keys)
          rectExplainer(color, colorsToExplain[color]!)
      ],
    );
  }
}
