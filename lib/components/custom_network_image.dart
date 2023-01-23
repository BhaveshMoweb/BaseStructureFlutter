import 'package:base_structure/constants/image_constant.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

///    Created By Bhavesh Makwana on 18/01/23

class CustomNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final bool cache;
  final bool clearMemoryCacheWhenDispose;
  final BoxBorder? border;
  final BoxShape? shape;
  final BorderRadius? borderRadius;
  final String? placeHolderImage;
  final bool enableShimmer;
  final bool? isInLoadingState;

  const CustomNetworkImage(
      {Key? key,
      required this.imageUrl,
      this.height,
      this.width,
      this.cache = false,
      this.border,
      this.shape,
      this.borderRadius,
      this.placeHolderImage = "",
      this.enableShimmer = false,
      this.isInLoadingState = false,
      this.clearMemoryCacheWhenDispose = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return enableShimmer && isInLoadingState!
        ? Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Card(
              elevation: 1.0,
              shape: shape == BoxShape.circle
                  ? RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    )
                  : RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
              child: SizedBox(
                height: height,
                width: width,
              ),
            ),
          )
        : ExtendedImage.network(
            imageUrl!,
            width: width,
            height: height,
            cache: cache,
            border: border,
            shape: shape,
            clearMemoryCacheWhenDispose: clearMemoryCacheWhenDispose,
            borderRadius:
                borderRadius ?? const BorderRadius.all(Radius.circular(5.0)),
            loadStateChanged: (ExtendedImageState state) {
              switch (state.extendedImageLoadState) {
                case LoadState.loading:
                  return placeHolderImage!.isNotEmpty && !enableShimmer
                      ? Image.asset(
                          placeHolderImage!,
                        )
                      : null;
                case LoadState.completed:
                  return null;
                case LoadState.failed:
                  return GestureDetector(
                    child: Image.asset(
                      placeHolderImage!.isEmpty
                          ? ImageConstant.placeholderImage
                          : placeHolderImage!,
                      fit: BoxFit.fill,
                    ),
                    onTap: () {},
                  );
              }
            },
          );
  }
}
