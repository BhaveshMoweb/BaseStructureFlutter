import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final int maxLine;
  final TextStyle? textStyle;

  const CustomText({
    Key? key,
    this.text = "",
    this.textAlign = TextAlign.start,
    this.maxLine = 1,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Created custom common Text with medium display
    return Text(
      text,
      style: textStyle ?? Theme.of(context).textTheme.displayMedium,
      textAlign: textAlign,
      maxLines: maxLine,
    );
  }
}
