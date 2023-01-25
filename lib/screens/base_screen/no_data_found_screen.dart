import 'package:base_structure/components/custom_text.dart';
import 'package:base_structure/constants/image_constant.dart';
import 'package:base_structure/utils/cm_file.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../components/custom_button.dart';
import '../../utils/app_colors.dart';
import '../../utils/strings.dart';

///    Created By Bhavesh Makwana on 17/01/23

class NoDataFoundScreen extends StatelessWidget {
  final String noDataFoundText;
  const NoDataFoundScreen({Key? key, this.noDataFoundText = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(ImageConstant.noDataFound),
        CM.sb(4.h),
        CustomText(
            text:
                noDataFoundText.isEmpty ? Label.noDataFound : noDataFoundText),
        CM.sb(5.h),
        CustomButton(
          width: 40.w,
          title: Label.tryAgain,
          onClick: () {},
          backgroundColor: AppColors.primaryColor,
          textStyle: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(color: AppColors.appBarHeadingColor),
        )
      ],
    );
  }
}
