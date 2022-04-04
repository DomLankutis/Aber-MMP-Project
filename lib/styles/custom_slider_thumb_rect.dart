import 'package:flutter/material.dart';

class CustomSliderThumbRect extends SliderComponentShape {
  final int min;
  final int max;
  final double thumbRadius;
  final double thumbHeight;

  const CustomSliderThumbRect({
    required this.min,
    required this.max,
    required this.thumbRadius,
    required this.thumbHeight,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  String getValue(double value) {
    return (min + (max - min) * value).round().toString();
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final Canvas canvas = context.canvas;

    final roundedRectangle = RRect.fromRectAndRadius(
      Rect.fromCenter(
          center: center, width: thumbHeight * 1.1, height: thumbHeight * 0.6),
      Radius.circular(thumbRadius),
    );

    final paint = Paint()
      ..color = sliderTheme.activeTrackColor!
      ..style = PaintingStyle.fill;

    TextSpan textSpan = TextSpan(
      text: getValue(value),
      style: TextStyle(
        fontSize: thumbHeight * 0.3,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        height: 1,
      ),
    );

    TextPainter textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    Offset textCenter = Offset(
      center.dx - (textPainter.width / 2),
      center.dy - (textPainter.height / 2),
    );

    canvas.drawRRect(roundedRectangle, paint);
    textPainter.paint(canvas, textCenter);
  }
}
