import 'package:base_structure/components/bouncing_widget.dart';
import 'package:base_structure/components/custom_text.dart';
import 'package:base_structure/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function()? onClick;
  final Color? backgroundColor;
  final double height;
  final double width;
  final Color textColor;
  final double textSize;
  final double? borderRadius;
  final OutlinedBorder? shape;
  final FontWeight fontWeight;
  final TextStyle? textStyle;
  final bool? isBorderEnable;
  final bool? isShadow;
  final TextAlign? textAlign;

  const CustomButton(
      {Key? key,
      required this.title,
      required this.onClick,
      this.borderRadius,
      this.backgroundColor,
      this.height = 50.0,
      this.width = 100.0,
      this.textColor = const Color(0xffEFEEEE),
      this.textSize = 20.0,
      this.shape,
      this.textStyle,
      this.isBorderEnable,
      this.isShadow,
      this.textAlign,
      this.fontWeight = FontWeight.normal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BouncingWidget(
      onPressed: onClick!,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 6.0)),
          color: backgroundColor ?? AppColors.offlineToastBg,
          border: isBorderEnable != null
              ? (isBorderEnable!
                  ? Border.all(color: textColor, width: 1)
                  : null)
              : null,
          boxShadow: isShadow == null || isShadow == true
              ? [
                  BoxShadow(
                    color: Colors.black.withAlpha(50),
                    blurRadius: 4.0,
                    spreadRadius: 2,
                    offset: const Offset(
                      0,
                      2,
                    ),
                  )
                ]
              : null,
        ),
        height: height,
        width: width,
        child: Align(
          alignment: Alignment.center,
          child: CustomText(
            text: title,
            textScaleFactor: 1.0,
            textAlign: textAlign ?? TextAlign.center,
          ),
        ),
      ),
    );

    /*ElevatedButton(
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
            minimumSize: Size(width, height),
            shape: shape ?? const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 12),
            backgroundColor: buttonColor),
        child: CustomText(
          text: title,
        ));*/
  }
}
