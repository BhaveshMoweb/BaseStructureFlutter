import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../screens/base_screen/no_data_found_screen.dart';
import '../utils/cm_file.dart';

///    Created By Bhavesh Makwana on 17/01/23

class CustomListview<T> extends StatelessWidget {
  final Widget Function(T, int) listItemView;
  final List<T> dataList;
  final String noDataFoundText;
  final bool shrinkWrap;
  final bool isInLoadingState;
  final bool enableShimmer;
  final ScrollController? controller;

  const CustomListview(
      {Key? key,
      this.controller,
      required this.listItemView,
      required this.dataList,
      this.shrinkWrap = false,
      this.noDataFoundText = "",
      this.enableShimmer = false,
      this.isInLoadingState = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return dataList.isNotEmpty
        ? ListView.builder(
            controller: controller,
            itemCount: dataList.length,
            shrinkWrap: shrinkWrap,
            itemBuilder: (context, index) {
              return listItemView(dataList[index], index);
            })
        : isInLoadingState
            ? enableShimmer
                ? Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: ListView.builder(
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 1.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: SizedBox(height: 10.h),
                        );
                      },
                    ),
                  )
                : CM.loadingView()
            : NoDataFoundScreen(
                noDataFoundText: noDataFoundText,
              );
  }
}
