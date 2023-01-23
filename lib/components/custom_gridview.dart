import 'package:flutter/material.dart';

import '../screens/base_screen/no_data_found_screen.dart';
import '../utils/cm_file.dart';

///    Created By Bhavesh Makwana on 18/01/23
class CustomGridView<T> extends StatelessWidget {
  final Widget Function(T, int) listItemView;
  final List<T> dataList;
  final String noDataFoundText;
  final int columnCount;
  final bool shrinkWrap;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final bool isInLoadingState;

  const CustomGridView({
    Key? key,
    required this.listItemView,
    required this.dataList,
    this.noDataFoundText = "",
    this.columnCount = 2,
    this.shrinkWrap = false,
    this.isInLoadingState = false,
    this.mainAxisSpacing = 5.0,
    this.crossAxisSpacing = 5.0,
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
            ? CM.loadingView()
            : NoDataFoundScreen(
                noDataFoundText: noDataFoundText,
              );
  }
}
