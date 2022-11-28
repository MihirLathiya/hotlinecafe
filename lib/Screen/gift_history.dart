import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hotlinecafee/Model/Response_model/gift_history_res_model.dart';
import 'package:hotlinecafee/Model/apis/api_response.dart';
import 'package:hotlinecafee/Preference/preference.dart';
import 'package:hotlinecafee/ViewModel/gift_history_view_model.dart';
import 'package:hotlinecafee/common/loading.dart';

class GiftHistoryScreen extends StatefulWidget {
  const GiftHistoryScreen({Key? key}) : super(key: key);

  @override
  State<GiftHistoryScreen> createState() => _GiftHistoryScreenState();
}

class _GiftHistoryScreenState extends State<GiftHistoryScreen> {
  GiftHistoryViewModel giftHistoryResModel = Get.put(GiftHistoryViewModel());
  @override
  void initState() {
    print('INIT ${10}');
    giftHistoryResModel.giftHistoryViewModel(model: {
      "user_id": PreferenceManager.getUserId(),
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
          'Gift History',
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
            child: GetBuilder<GiftHistoryViewModel>(
              builder: (controller) {
                if (controller.giftHistoryApiResponse.status.toString() ==
                    Status.LOADING.toString()) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.red,
                    ),
                  );
                }
                if (controller.giftHistoryApiResponse.status.toString() ==
                    Status.ERROR.toString()) {
                  return Center(
                    child: Text(
                      'Something went wrong',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                print(
                    '-controller.giftHistoryApiResponse.status--${controller.giftHistoryApiResponse.status}');

                if (controller.giftHistoryApiResponse.status.toString() ==
                    Status.COMPLETE.toString()) {
                  GiftHistoryResponseModel giftListResponse =
                      controller.giftHistoryApiResponse.data;
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
                          },
                        );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
