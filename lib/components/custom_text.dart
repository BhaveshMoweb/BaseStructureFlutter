import 'package:flutter/material.dart';

/// Created custom common Text with medium display
class CustomText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final int maxLine;
  final TextStyle? textStyle;
  final double? textScaleFactor;

  const CustomText({
    Key? key,
    this.text = "",
    this.textAlign = TextAlign.start,
    this.maxLine = 1,
    this.textScaleFactor,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle ?? Theme.of(context).textTheme.displayMedium,
      textAlign: textAlign,
      textScaleFactor: textScaleFactor,
      maxLines: maxLine,
    );
  }
}
