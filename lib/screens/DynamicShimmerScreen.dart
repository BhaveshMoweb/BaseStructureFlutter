import 'package:base_structure/components/common_text.dart';
import 'package:base_structure/components/custom_network_image.dart';
import 'package:base_structure/screens/base_screen/base_screen.dart';
import 'package:flutter/cupertino.dart';

import '../utils/cm_file.dart';

///    Created By Bhavesh Makwana on 23/01/23

class DynamicShimmerScreen extends StatefulWidget {
  const DynamicShimmerScreen({Key? key}) : super(key: key);

  @override
  State<DynamicShimmerScreen> createState() => _DynamicShimmerScreenState();
}

class _DynamicShimmerScreenState extends State<DynamicShimmerScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "Shimmer Layout",
      body: getBody(),
    );
  }

  Widget getBody() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: const CustomNetworkImage(
                    imageUrl: "https://picsum.photos/id/237/200/300",
                    width: 100,
                    height: 100,
                    shape: BoxShape.circle,
                    enableShimmer: true,
                    isInLoadingState: true),
              ),
              CM.sbw(10),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  children: const [
                    CommonText(
                      text: "John Stuart",
                      isInLoadingState: true,
                      enableShimmer: true,
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
