import 'package:flutter/material.dart';

import '../screens/base_screen/no_data_found_screen.dart';
import '../utils/cm_file.dart';

///    Created By Bhavesh Makwana on 17/01/23
class CustomListview<T> extends StatelessWidget {
  final Widget Function(T, int) listItemView;
  final List<T> dataList;
  final String noDataFoundText;
  final bool shrinkWrap;
  final bool isInLoadingState;
  final ScrollController? controller;

  const CustomListview({
    Key? key,
    this.controller,
    required this.listItemView,
    required this.dataList,
    this.shrinkWrap = false,
    this.isInLoadingState = false,
    this.noDataFoundText = "",
  }) : super(key: key);

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
            ? CM.loadingView()
            : NoDataFoundScreen(
                noDataFoundText: noDataFoundText,
              );
  }
}
