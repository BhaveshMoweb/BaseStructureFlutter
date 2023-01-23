import 'package:base_structure/components/common_text.dart';
import 'package:base_structure/utils/cm_file.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/routes.dart';
import '../base_screen/base_screen.dart';

/// Created By Bhavesh Makwana on 19/01/23

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: getDashboardBody(),
      shouldShowBackButton: false,
      title: "Dashboard",
    );
  }

  getDashboardBody() {
    return Column(
      children: [
        /// posts list page card
        Card(
          child: Container(
            width: 100.w,
            padding: EdgeInsets.all(4.w),
            child: GestureDetector(
              onTap: () {
                CM.callNextScreen(context, Routes.productList);
              },
              child: const CommonText(
                text: "Product List Page",
              ),
            ),
          ),
        ),

        /// product list page card
        Card(
          child: Container(
            width: 100.w,
            padding: EdgeInsets.all(4.w),
            child: GestureDetector(
              onTap: () {
                CM.callNextScreen(context, Routes.postListScreen);
              },
              child: const CommonText(
                text: "Posts List With Pagination",
              ),
            ),
          ),
        ),
      ],
    );
  }
}
