import 'package:base_structure/components/custom_button.dart';
import 'package:base_structure/components/custom_text_field.dart';
import 'package:base_structure/utils/app_colors.dart';
import 'package:base_structure/utils/cm_file.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'base_screen/base_screen.dart';

class AllWidgets extends StatefulWidget {
  const AllWidgets({super.key});

  @override
  State<AllWidgets> createState() => _AllWidgetsState();
}

class _AllWidgetsState extends State<AllWidgets> {
  AnimationController? animatedController;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: allWidgetsBody(),
      title: "All Widgets",
    );
  }

  Widget allWidgetsBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(),
            CM.sb(2.h),
            CustomTextField(
              hint: "Dynamic",
              onTap: () {},
              backgroundColor: AppColors.darkRed,
              textColor: AppColors.successToastBg,
              borderRadius: 10,
              inputBorder: InputBorder.none,
              maxLines: 2,
              minLines: 2,
              keyboardType: TextInputType.number,
            ),
            CM.sb(2.h),
            CustomButton(
              title: "Click",
              onClick: () {},
              isShadow: false,
            ),
            CM.sb(1.h),
            CustomButton(
              title: "Click",
              onClick: () {},
              borderRadius: 25,
              backgroundColor: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
