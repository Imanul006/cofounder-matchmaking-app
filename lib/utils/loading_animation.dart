import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kiuqi/constants/values.dart';
import 'package:shimmer/shimmer.dart';

class LoadingAnimation {
  static Widget circular() {
    return const SpinKitFadingCircle(color: AppColor.primaryColor, size: 70);
  }

  static Widget spin() {
    Random random = Random();
    int randomNumber = random.nextInt(10);

    List<String> loadingTexts = [
      "Lorem ipsum dolor sit amet",
      "Provident similique accusantiu",
      "Harum nesciunt ipsum debitis",
      "Officiis iure rerum voluptates a cumque",
      "Lorem Ipsum is simply dummy text",
      "It was popularised in the 1960s",
      "PageMaker including versions of Lorem Ipsum",
      "Possimus quis earum veniam quasi",
      "It has survived not only five centuries",
      "Lorem Ipsum has been the industry",
    ];
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Text(
            loadingTexts[randomNumber],
            style: BaseStyles.blackSubtitleTextStyle,
          ),
          const SizedBox(
            height: 15,
          ),
          const SpinKitPouringHourGlassRefined(
            color: Color(0xfffa3900),
            size: 75,
          ),
        ],
      ),
    );
  }

  static Widget shimmerListTile() {
    return Card(
      elevation: 7,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.orange[100],
              radius: 31,
              child: const ShimmerWidget.circular(height: 70, width: 70),
            ),
            const SizedBox(width: 18),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ShimmerWidget.rectangular(height: 22, width: 120),
                SizedBox(height: 5),
                ShimmerWidget.rectangular(height: 12, width: 200),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget shimmer() {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: AppColor.discoverHeaderGradient,
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(80.0),
                bottomRight: Radius.circular(80.0),
              ),
            ),
            height: 300,
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(Sizes.componentSideMargin,
                      15, 15, Sizes.componentSideMargin),
                  child: Text(
                    "Discover",
                    style: BaseStyles.pageHeadingTextStyle,
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                      child: Card(
                        elevation: 7,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          //height: _viewPort.height * 0.666 - 20,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _buildDetailsSection(),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildDetailsSection() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile pic shimmer
          const ShimmerWidget.circular(height: 170, width: 170),
          const SizedBox(height: 18),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              // Name shimmer
              ShimmerWidget.rectangular(height: 26, width: 130),
              SizedBox(
                height: 8,
              ),
              // Category shimmer
              ShimmerWidget.rectangular(height: 12, width: 90),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: const [
              // Exp shimmer
              Expanded(
                child: ShimmerWidget.rectangular(height: 70, width: 60),
              ),
              SizedBox(width: 8),
              // Age shimmer
              Expanded(
                child: ShimmerWidget.rectangular(height: 70, width: 60),
              ),
            ],
          ),
          const SizedBox(height: 18),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 4, 4, 4),
                child: ShimmerWidget.circular(height: 52, width: 52),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    ShimmerWidget.rectangular(height: 12, width: 70),
                    SizedBox(height: 5),
                    ShimmerWidget.rectangular(height: 17, width: 120),
                  ],
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 4, 4, 4),
                child: ShimmerWidget.circular(height: 52, width: 52),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    ShimmerWidget.rectangular(height: 12, width: 70),
                    SizedBox(height: 5),
                    ShimmerWidget.rectangular(height: 17, width: 140),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 14),
          const Divider(),
          const SizedBox(height: 5),
          const Align(
            alignment: Alignment.topLeft,
            child: ShimmerWidget.rectangular(height: 12, width: 60),
          ),
          const SizedBox(height: 6),
          const Align(
              alignment: Alignment.topLeft,
              child: ShimmerWidget.rectangular(
                  height: 12, width: double.infinity)),
          const SizedBox(height: 3),
          const Align(
              alignment: Alignment.topLeft,
              child: ShimmerWidget.rectangular(height: 12, width: 200)),
        ],
      ),
    );
  }
}

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.rectangular({
    Key? key,
    required this.height,
    required this.width,
    this.shapeBorder = const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4))),
  }) : super(key: key);

  const ShimmerWidget.circular({
    Key? key,
    required this.height,
    required this.width,
    this.shapeBorder = const CircleBorder(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[200]!,
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            shape: shapeBorder,
            color: Colors.grey[300]!,
          ),
        ),
      );
}
