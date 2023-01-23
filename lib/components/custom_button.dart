import 'package:flutter/material.dart';

//ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  final String title;
  final Function()? onClick;
  final Color? buttonColor;
  final double height;
  final double width;
  final Color textColor;
  final double textSize;
  OutlinedBorder? shape;
  FontWeight fontWeight;
  TextStyle? textStyle;

  CustomButton(
      {Key? key,
      required this.title,
      this.onClick,
      this.buttonColor,
      this.height = 20.0,
      this.width = 100.0,
      this.textColor = const Color(0xffEFEEEE),
      this.textSize = 20.0,
      this.shape,
      this.textStyle,
      this.fontWeight = FontWeight.normal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      style: ElevatedButton.styleFrom(
          minimumSize: Size(width, height),
          shape: shape ?? const StadiumBorder(),
          padding: const EdgeInsets.symmetric(vertical: 12),
          backgroundColor: buttonColor),
      child: Text(title,
          style: textStyle ?? Theme.of(context).textTheme.displayMedium),
    );
  }
}
