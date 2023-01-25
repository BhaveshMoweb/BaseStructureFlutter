import 'package:base_structure/components/custom_text.dart';
import 'package:base_structure/constants/image_constant.dart';
import 'package:base_structure/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/cm_file.dart';
import '../../utils/strings.dart';

///    Created By Bhavesh Makwana on 12/01/23
class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: 100.h,
          width: 100.w,
          color: AppColors.inputBackgroundColor,
          child: myBody(context)),
    );
  }

  Widget myBody(context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            ImageConstant.noInternet,
            width: 50.w,
            height: 50.w,
          ),
          CM.sb(5.h),
          const CustomText(
            text: Label.internetConnectionLost,
          ),
          CM.sb(7.h),
          const CustomText(
            text: Label.noInternetDesc,
            maxLine: 3,
            textAlign: TextAlign.center,
          ),
          CM.sb(10.h),
        ],
      ),
    );
  }
}
