import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

///    Created By Bhavesh Makwana on 20/01/23
class ShimmerLayout extends StatelessWidget {
  final ShapeBorder? shapeBorder;
  final double? height;
  final double? width;
  final Color? baseColor;
  final Color? highlightColor;
  const ShimmerLayout({
    Key? key,
    this.shapeBorder,
    this.height = 100,
    this.width = 200,
    this.baseColor,
    this.highlightColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: baseColor ?? Colors.grey[300]!,
        highlightColor: highlightColor ?? Colors.grey[100]!,
        child: Card(
          elevation: 1.0,
          shape: shapeBorder ??
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
          child: SizedBox(
            height: height,
            width: width,
          ),
        ));
  }
}
