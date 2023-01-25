import 'package:base_structure/utils/app_colors.dart';
import 'package:flutter/material.dart';

/// This widget will used when we need to show title in the screen.
class CustomTitleText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final int maxLine;

  const CustomTitleText(
      {Key? key,
      this.text = "",
      this.textAlign = TextAlign.start,
      this.maxLine = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .headlineMedium!
          .copyWith(color: AppColors.inputBackgroundColor),
      textAlign: textAlign,
      maxLines: maxLine,
    );
  }
}
