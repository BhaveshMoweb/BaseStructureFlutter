import 'package:base_structure/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../utils/app_colors.dart';

//ignore: must_be_immutable
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
  final bool? isForLogin;
  final Color textColor;
  final bool? isMultiline;
  final bool? enable;
  int? maxLines;
  int? minLines;

  CustomTextField(
      {Key? key,
      this.hint,
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
      this.isRequired,
      this.isForLogin = false,
      this.isPassword = false,
      this.maxLines,
      this.minLines,
      this.isMultiline = false,
      this.enable,
      this.textColor = const Color(0xff1C497E)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*
    - Created custom TextField with multiple properties for Input text.
   */
    return Container(
      height: isMultiline! ? 130 : 55,
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      decoration: BoxDecoration(
        color: AppColors.inputBackgroundColor,
        borderRadius: isForLogin == true
            ? const BorderRadius.all(Radius.circular(27.5))
            : const BorderRadius.all(Radius.circular(10)),
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
        style: Theme.of(context).textTheme.displayMedium,
        onEditingComplete: onEditingComplete,
        keyboardType: keyboardType,
        cursorColor: AppColors.inputTextColor.withOpacity(0.5),
        decoration: InputDecoration(
          label: CustomText(
            text: isRequired == true ? "$hint*" : hint!,
          ),
          border: InputBorder.none,
          counterText: "",
        ),
      ),
    );
  }
}
