import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final int maxLine;
  final TextStyle? textStyle;

  const CommonText({
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
