import 'package:base_structure/utils/app_colors.dart';
import 'package:flutter/material.dart';

//ignore: must_be_immutable
class CommonTitleText extends StatelessWidget {
  String text;
  TextAlign textAlign;
  int maxLine;

  CommonTitleText(
      {Key? key,
      this.text = "",
      this.textAlign = TextAlign.start,
      this.maxLine = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Created custom common Text with medium display
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
