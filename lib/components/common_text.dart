import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CommonText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final int maxLine;
  final TextStyle? textStyle;
  final bool? enableShimmer;
  final bool? isInLoadingState;

  const CommonText({
    Key? key,
    this.text = "",
    this.textAlign = TextAlign.start,
    this.maxLine = 1,
    this.textStyle,
    this.enableShimmer = false,
    this.isInLoadingState = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Created custom common Text with medium display
    return enableShimmer! && isInLoadingState!
        ? Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Card(
              elevation: 1.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: const SizedBox(
                height: 25,
                width: 100,
              ),
            ))
        : Text(
            text,
            style: textStyle ?? Theme.of(context).textTheme.displayMedium,
            textAlign: textAlign,
            maxLines: maxLine,
          );
  }
}
