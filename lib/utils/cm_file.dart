import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import 'app_colors.dart';

/// This file contains bunch methods which are accessible in project from
/// anywhere in this project

class CM {
  static BuildContext? _progressContext;

  static void callNextScreen(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  static void printLog(String text) {
    if (kDebugMode) {
      print(text);
    }
  }

  static void showCustomToast(context, message,
      {bool isError = false,
      double verticalMargin = 22,
      bool isOffline = false}) {
    if (isOffline) {
      showToast(message,
          context: context,
          animation: StyledToastAnimation.slideFromBottom,
          reverseAnimation: StyledToastAnimation.slideToBottom,
          startOffset: const Offset(0.0, 3.0),
          reverseEndOffset: const Offset(0.0, 3.0),
          position: StyledToastPosition.bottom,
          duration: const Duration(seconds: 4),
          backgroundColor:
              isOffline ? AppColors.offlineToastBg : AppColors.successToastBg,
          animDuration: const Duration(seconds: 1),
          curve: Curves.elasticOut,
          textPadding: EdgeInsets.symmetric(vertical: verticalMargin),
          toastHorizontalMargin: 16,
          textStyle: TextStyle(
              color: isOffline
                  ? AppColors.offlineTextColor
                  : AppColors.inputBackgroundColor,
              fontWeight: FontWeight.w700),
          reverseCurve: Curves.fastOutSlowIn,
          fullWidth: true);
    } else {
      showToast(message,
          context: context,
          animation: StyledToastAnimation.slideFromBottom,
          reverseAnimation: StyledToastAnimation.slideToBottom,
          startOffset: const Offset(0.0, 3.0),
          reverseEndOffset: const Offset(0.0, 3.0),
          position: StyledToastPosition.bottom,
          duration: const Duration(seconds: 4),
          backgroundColor:
              isError ? AppColors.errorToastBg : AppColors.successToastBg,
          animDuration: const Duration(seconds: 1),
          curve: Curves.elasticOut,
          textPadding: EdgeInsets.symmetric(vertical: verticalMargin),
          toastHorizontalMargin: 16,
          reverseCurve: Curves.fastOutSlowIn,
          fullWidth: true);
    }
  }

  /// Add sizeBox with height
  static Widget sb(double size) {
    return SizedBox(height: size);
  }

  /// Add sizeBox with width
  static Widget sbw(double size) {
    return SizedBox(width: size);
  }

  /// To check email validation
  static bool isEmailValidated(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.~!?#$%^&*_-]+@[a-zA-Z0-9~!?#$%^&*_-]+\.[a-zA-Z~!?#$%^&*_-]+")
        .hasMatch(email);
  }

  /// Loading view widget
  static Widget loadingView() {
    return Center(
        child: CircularProgressIndicator(
      color: AppColors.inputTextColor,
    ));
  }

  /// Hide progressbar
  static void hideProgressDialog() {
    if (_progressContext != null) {
      Navigator.of(_progressContext!).pop(true);
      _progressContext = null;
    } else {}
  }

  static Future<bool> checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}
