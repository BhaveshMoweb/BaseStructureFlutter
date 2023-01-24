import 'package:base_structure/utils/app_colors.dart';
import 'package:flutter/material.dart';

//ignore: must_be_immutable
class CustomTitleText extends StatelessWidget {
  String text;
  TextAlign textAlign;
  int maxLine;

  CustomTitleText(
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
