import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

Widget ImageLoading({String? url, double? height, double? width}) {
  return CachedNetworkImage(
    imageUrl: url!,
    height: height!,
    width: width,
    fit: BoxFit.cover,
    placeholder: (context, url) => Shimmer.fromColors(
      baseColor: Colors.grey.shade700,
      highlightColor: Colors.grey.shade800,
      child: Container(
        height: height,
        width: width!,
        color: Colors.grey.shade400,
      ),
    ),
    errorWidget: (context, url, error) => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/noImage.png',
            fit: BoxFit.fill,
          ),
        ],
      ),
    ),
  );
}

Widget ShimmerChatLoading({count}) {
  return SizedBox(
    height: Get.height,
    width: Get.width,
    child: ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade700,
          highlightColor: Colors.grey.shade800,
          child: Column(
            children: [
              ListTile(
                leading: Container(
                  height: 40.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    shape: BoxShape.circle,
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 10.h,
                      width: 120.w,
                      color: Colors.grey.shade200,
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 10.h,
                      width: 150.w,
                      color: Colors.grey.shade200,
                    ),
                  ],
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 10.h,
                      width: 50.w,
                      color: Colors.grey.shade200,
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.white38,
              )
            ],
          ),
        );
      },
    ),
  );
}

Widget ShimmerNotificationLoading({count}) {
  return SizedBox(
    height: Get.height,
    width: Get.width,
    child: ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade700,
          highlightColor: Colors.grey.shade800,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  height: 10.h,
                  width: 120.w,
                  color: Colors.grey.shade200,
                ),
              ),
              ListTile(
                leading: Container(
                  height: 40.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    shape: BoxShape.circle,
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 10.h,
                      width: 150.w,
                      color: Colors.grey.shade200,
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 10.h,
                      width: 70.w,
                      color: Colors.grey.shade200,
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.white38,
              )
            ],
          ),
        );
      },
    ),
  );
}

Widget ShimmerHomeLoad(context) {
  return MediaQuery.removeViewPadding(
    context: context,
    removeTop: true,
    child: GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 0.75,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade700,
          highlightColor: Colors.grey.shade800,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        );
      },
    ),
  );
}
