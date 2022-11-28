import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hotlinecafee/ViewModel/view_profile_view_model.dart';
import 'package:hotlinecafee/common/loading.dart';
import 'package:hotlinecafee/model/apis/api_response.dart';
import 'package:hotlinecafee/model/response_model/my_gift_collection_res_model.dart';

class Gift_Collection extends StatefulWidget {
  final userId;
  const Gift_Collection({
    Key? key,
    this.userId,
    // this.userId
  }) : super(key: key);

  @override
  State<Gift_Collection> createState() => _Gift_CollectionState();
}

class _Gift_CollectionState extends State<Gift_Collection> {
  GiftListViewModel giftListResModel = Get.put(GiftListViewModel());
  @override
  void initState() {
    print('INIT ${widget.userId}');
    giftListResModel.myGiftCollectionViewModel(model: {
      "user_id": widget.userId,
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Gift Collection',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          Divider(
            color: Color(0xff242424),
          ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: GetBuilder<GiftListViewModel>(
              builder: (controller) {
                if (controller.giftCollectionApiResponse.status.toString() ==
                    Status.LOADING.toString()) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (controller.giftCollectionApiResponse.status.toString() ==
                    Status.ERROR.toString()) {
                  return Center(
                    child: Text(
                      'Something went wrong',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
                if (controller.giftCollectionApiResponse.status.toString() ==
                    Status.COMPLETE.toString()) {
                  MyGiftCollectionResponseModel giftListResponse =
                      controller.giftCollectionApiResponse.data;
                  log('LEANGHT :- ${giftListResponse.data!.length.runtimeType}');
                  return giftListResponse.data!.length.isEqual(0)
                      ? Center(
                          child: Text(
                            'No Gifts',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : GridView.builder(
                          itemCount: giftListResponse.data!.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 2,
                            crossAxisCount: 4,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            var giftData = giftListResponse.data?[index];
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: ImageLoading(
                                      url: '${giftData!.image}',
                                      width: 48.h,
                                      height: 48.h),
                                ),
                                Text(
                                  '${giftData.title}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'images/Coin.png',
                                      height: 15,
                                      width: 15,
                                    ),
                                    Text(
                                      '${giftData.coins}',
                                      style: TextStyle(
                                        color: Color(0Xff81818A),
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          });
                } else {
                  return SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
