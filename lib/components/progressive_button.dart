// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:sizer/sizer.dart';

import '../utils/cm_file.dart';
import '../utils/strings.dart';

///    Created By Bhavesh Makwana on 11/01/23
class ProgressiveButton extends StatefulWidget {
  String? title;
  final Function()? onPressed;
  Color? initialButtonColor = Colors.deepPurple.shade500;
  Color? loadingButtonColor = Colors.deepPurple.shade700;
  String loadingText = "Loading";
  double borderRadius;
  ButtonState? buttonState = ButtonState.idle;
  ProgressiveButton(
      {Key? key,
      this.title,
      this.initialButtonColor,
      this.onPressed,
      this.buttonState,
      this.borderRadius = 10})
      : super(key: key);

  @override
  State<ProgressiveButton> createState() => _ProgressiveButtonState();
}

class _ProgressiveButtonState extends State<ProgressiveButton> {
  @override
  Widget build(BuildContext context) {
    return ProgressButton(
      minWidth: 52,
      radius: widget.borderRadius,
      stateWidgets: {
        ButtonState.idle: Text(
          widget.title!,
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(color: Colors.white),
        ),
        ButtonState.loading: Text(
          "",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        ButtonState.fail: const Text(
          "Fail",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        ButtonState.success: Text(
          widget.title!,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        )
      },
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      stateColors: {
        ButtonState.idle: widget.initialButtonColor ?? Colors.grey.shade400,
        ButtonState.loading: widget.initialButtonColor ?? Colors.blue.shade300,
        ButtonState.fail: widget.initialButtonColor ?? Colors.red.shade300,
        ButtonState.success: widget.initialButtonColor ?? Colors.green.shade400,
      },
      onPressed: () async {
        if (await CM.checkInternet()) {
          widget.onPressed!();
        } else {
          CM.showCustomToast(context, Label.noInternet, isError: true);
        }
      },
      state: widget.buttonState,
    );
  }
}
