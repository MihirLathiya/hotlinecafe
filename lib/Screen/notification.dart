import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hotlinecafee/Preference/preference.dart';
import 'package:hotlinecafee/common/loading.dart';
import 'package:hotlinecafee/model/apis/api_response.dart';
import 'package:hotlinecafee/model/response_model/notification_res_model.dart';

import '../ViewModel/notification_view_model.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _Notification1();
}

class _Notification1 extends State<NotificationScreen> {
  NotificationViewModel notificationViewModel =
      Get.put(NotificationViewModel());
  @override
  void initState() {
    notificationViewModel.notificationViewModel(model: {
      "user_id": PreferenceManager.getUserId(),
    });
    super.initState();
  }

  List? showDate = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
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
          'Notification',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: GetBuilder<NotificationViewModel>(
        builder: (controller) {
          if (controller.notificationApiResponse.status == Status.LOADING) {
            return ShimmerNotificationLoading(count: 10);
          }
          if (controller.notificationApiResponse.status == Status.COMPLETE) {
            NotificationResponseModel notificationData =
                controller.notificationApiResponse.data;
            var notData = notificationData.data;
            notData!.forEach(
              (element) {
                if (showDate!.contains(element.entryDate)) {
                } else {
                  showDate!.add(element.entryDate);
                }
              },
            );

            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: Colors.white24,
                  ),
                  ListView.builder(
                    itemCount: showDate!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    reverse: true,
                    itemBuilder: (context, index1) {
                      var dateData =
                          showDate![index1].toString().split(' ').first;
                      var currentDate =
                          DateTime.now().toString().split(' ').first;
                      var yesterday = DateTime.now()
                          .subtract(Duration(days: 1))
                          .toString()
                          .split(' ')
                          .first;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.0),
                            child: Text(
                              dateData == currentDate
                                  ? 'Today'
                                  : dateData == yesterday
                                      ? 'yesterday'
                                      : '${dateData}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            reverse: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.all(5),
                            itemCount: notificationData.data!.length,
                            itemBuilder: (context, index) {
                              return notificationData.data![index].entryDate ==
                                      showDate![index1]
                                  ? GetNotification(
                                      notificationData,
                                      index,
                                      notificationData.data![index].entryDate ==
                                          showDate![index1],
                                    )
                                  : SizedBox();
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  GetNotification(NotificationResponseModel controller, index, bool isShow) {
    var time1 = controller.data![index].entryDateTime;

    var time2 = DateTime.now();
    var time3 = time2.difference(time1!).inSeconds > 60
        ? time2.difference(time1).inMinutes > 60
            ? time2.difference(time1).inHours > 24
                ? '${time2.difference(time1).inDays} day'
                : '${time2.difference(time1).inHours} hours'
            : '${time2.difference(time1).inMinutes} minutes'
        : '${time2.difference(time1).inSeconds} seconds';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Chat_Person()));
            // if (x!.contains('Following You') == true) {
            //   print('object');
            //   Get.to(
            //     () => View_profile(
            //       profileId: notData[index].id!,
            //     ),
            //   );
            // }
          },
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(1000),
              child: ImageLoading(
                url: '${controller.data![index].profilePic}',
                height: 40.h,
                width: 40.h,
              ),
            ),
            title: Row(
              children: [
                Text(
                  '${controller.data![index].notification}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            subtitle: Text(
              "$time3 ago",
              style: TextStyle(
                fontSize: 14,
                color: Color(0Xff9C9797),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Divider(
          color: Colors.white24,
        ),
      ],
    );
  }
}
