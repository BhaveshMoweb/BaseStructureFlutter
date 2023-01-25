import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Created custom TextField with multiple properties for Input text.
class CustomTextField extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? errorText;
  final String? titleText;
  final Function()? onEditingComplete;
  final bool readOnly;
  final Function()? onTap;
  final int? maxLength;
  final Function(String s)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String? val)? validator;
  final bool? isRequired;
  final bool? isPassword;
  final Color textColor;
  final Color backgroundColor;
  final bool? enable;
  final int? maxLines;
  final int? minLines;
  final InputBorder? inputBorder;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;

  CustomTextField(
      {Key? key,
      this.hint,
      this.padding,
      this.controller,
      this.keyboardType,
      this.errorText,
      this.titleText,
      this.onEditingComplete,
      this.readOnly = false,
      this.onTap,
      this.maxLength,
      this.onChanged,
      this.inputFormatters,
      this.validator,
      this.isRequired = false,
      this.isPassword = false,
      this.maxLines,
      this.minLines,
      this.borderRadius,
      this.enable,
      this.textColor = const Color(0xff000000),
      this.backgroundColor = const Color(0x00000000),
      this.inputBorder})
      : assert(!isPassword! || maxLines == 1,
            'Password fields cannot be multiline.'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 10)),
      ),
      child: TextFormField(
        controller: controller,
        textCapitalization: TextCapitalization.sentences,
        inputFormatters: inputFormatters,
        maxLength: maxLength,
        maxLines: maxLines ?? 1,
        minLines: minLines ?? 1,
        readOnly: readOnly,
        onTap: onTap,
        onChanged: onChanged,
        enabled: enable,
        obscureText: isPassword!,
        style: Theme.of(context)
            .textTheme
            .displayMedium!
            .copyWith(color: textColor),
        onEditingComplete: onEditingComplete,
        keyboardType: keyboardType,
        cursorColor: textColor,
        decoration: InputDecoration(
            border: inputBorder,
            hintText: isRequired == true ? "$hint*" : hint),
      ),
    );
  }
}
