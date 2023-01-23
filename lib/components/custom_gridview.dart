import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../screens/base_screen/no_data_found_screen.dart';
import '../utils/cm_file.dart';

///    Created By Bhavesh Makwana on 18/01/23
class CustomGridView<T> extends StatelessWidget {
  final Widget Function(T, int) listItemView;
  final List<T> dataList;
  final String noDataFoundText;
  final int columnCount;
  final bool shrinkWrap;
  final bool isInLoadingState;
  final bool enableShimmer;
  final double crossAxisSpacing;
  final double mainAxisSpacing;

  const CustomGridView({
    Key? key,
    required this.listItemView,
    required this.dataList,
    this.noDataFoundText = "",
    this.columnCount = 2,
    this.shrinkWrap = false,
    this.mainAxisSpacing = 5.0,
    this.crossAxisSpacing = 5.0,
    this.isInLoadingState = false,
    this.enableShimmer = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return dataList.isNotEmpty
        ? GridView.builder(
            itemCount: dataList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columnCount,
              crossAxisSpacing: crossAxisSpacing,
              mainAxisSpacing: mainAxisSpacing,
            ),
            itemBuilder: (context, index) {
              return listItemView(dataList[index], index);
            })
        : isInLoadingState
            ? enableShimmer
                ? Shimmer.fromColors(
                    baseColor:
                        Theme.of(context).backgroundColor.withOpacity(0.7),
                    highlightColor:
                        Theme.of(context).backgroundColor.withOpacity(0.1),
                    child: GridView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 1.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: SizedBox(height: 10.h),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: crossAxisSpacing,
                        mainAxisSpacing: mainAxisSpacing,
                      ),
                    ),
                  )
                : CM.loadingView()
            : NoDataFoundScreen(
                noDataFoundText: noDataFoundText,
              );
  }
}
