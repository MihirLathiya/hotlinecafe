import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hotlinecafee/screen/setting_screens/add_bank_account_screen.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'earningHistory.dart';

class EarningScreen extends StatefulWidget {
  const EarningScreen({Key? key}) : super(key: key);

  @override
  State<EarningScreen> createState() => _EarningScreenState();
}

class _EarningScreenState extends State<EarningScreen> {
  /// DropDown List
  List year = ['2015', '2016', '2017', '2018', '2019', '2020'];
  bool isCheck = false;
  bool isCheck1 = false;

  dynamic selectedValue = "2020";
  final List<ChartData> chartData = [
    // Bind data source
    ChartData('Jan', 45000),
    ChartData('Feb', 30000),
    ChartData('Mar', 20000),
    ChartData('Apr', 10000),
    ChartData('May', 40000),
    ChartData('Jun', 50000),
    ChartData('Jul', 40000),
    ChartData('Aug', 60000),
    ChartData('Sep', 60000),
    ChartData('Oct', 55000),
    ChartData('Nov', 30000),
    ChartData('Dec', 45000),
  ];
  SelectBankController selectBankController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        bottom: PreferredSize(
            child: Divider(color: Color(0xff242424), thickness: 2),
            preferredSize: Size.fromHeight(4.h)),
        centerTitle: true,
        title: Text(
          'Earning',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(
              height: 20.sp,
            ),
            Container(
              height: 140.h,
              width: Get.width,
              decoration: BoxDecoration(
                  color: Color(0xff242424),
                  borderRadius: BorderRadius.circular(16.sp)),
              child: Padding(
                padding: EdgeInsets.all(16.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/Dimond_fill.png',
                            height: 40.sp,
                            width: 40.sp,
                          ),
                          SizedBox(
                            width: 15.sp,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "My Earnings",
                                style: TextStyle(
                                    color: Color(0xff81818A),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "15500",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                          Spacer(),
                          Text(
                            "\$15.55",
                            style: TextStyle(
                                color: Color(0xff53B175),
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700),
                          )
                        ]),
                    InkWell(
                      borderRadius: BorderRadius.circular(32.sp),
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            backgroundColor: Color(0xfff1A1A27),
                            builder: (context) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: Get.height * 0.02,
                                  ),
                                  Divider(
                                    endIndent: 155,
                                    indent: 155,
                                    thickness: 3,
                                    color: Color(0xfff4F4F5B),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.015,
                                  ),
                                  Text(
                                    "Select Bank Account",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20.sp),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.02,
                                  ),
                                  Divider(
                                    thickness: 1.0,
                                    color: Color(0xfff4F4F5B),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        RichText(
                                            text: TextSpan(
                                                text: "Amount",
                                                children: [
                                                  TextSpan(
                                                      text: " \$15.55 ",
                                                      style: TextStyle(
                                                          color: Colors.green)),
                                                  TextSpan(
                                                      text:
                                                          " will be credited to you bank account within 7 working days")
                                                ]),
                                            textAlign: TextAlign.center),
                                        SizedBox(
                                          height: Get.height * 0.025,
                                        ),
                                        SizedBox(
                                          height: 110.sp,
                                          width: Get.width,
                                          child: Column(
                                            children: [
                                              ...List.generate(
                                                2,
                                                (index) => Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5.sp),
                                                  child: Obx(
                                                    () => GestureDetector(
                                                      onTap: () {
                                                        selectBankController
                                                            .isChecked(index);
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Image.asset(
                                                              "images/4259088 1.png",
                                                              height: 35.sp,
                                                              width: 35.sp,
                                                              fit:
                                                                  BoxFit.cover),
                                                          SizedBox(
                                                            width: Get.width *
                                                                0.05,
                                                          ),
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "HDFC BANK",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Text(
                                                                "2255 2665 *** ***",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                            ],
                                                          ),
                                                          Spacer(),
                                                          Container(
                                                            height: 19.h,
                                                            width: 19.h,
                                                            decoration: BoxDecoration(
                                                                color: selectBankController
                                                                            .isCheck
                                                                            .value ==
                                                                        index
                                                                    ? Color(
                                                                        0xffE76944)
                                                                    : Colors
                                                                        .transparent,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(7
                                                                            .sp),
                                                                border: Border.all(
                                                                    color: selectBankController.isCheck.value ==
                                                                            index
                                                                        ? Color(
                                                                            0xffE76944)
                                                                        : Colors
                                                                            .white)),
                                                            child: Center(
                                                              child: Icon(
                                                                Icons.done,
                                                                color: selectBankController
                                                                            .isCheck
                                                                            .value ==
                                                                        index
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .transparent,
                                                                size: 15.h,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.035,
                                        ),
                                        Container(
                                          height: Get.height * 0.06,
                                          width: Get.width,
                                          // color: Color(0xfffE76944),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                primary: Color(0xfffE76944)),
                                            onPressed: () {
                                              Get.to(
                                                  () => AddBankAccountScreen());
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text("+ Add Bank Account"),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.015,
                                        ),
                                        Container(
                                          height: Get.height * 0.06,
                                          width: Get.width,
                                          // color: Color(0xfffE76944),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                primary: Color(0xfffE76944)),
                                            onPressed: () {},
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text("Withdraw"),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.02,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 48.sp,
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32.sp),
                            border: Border.all(
                                color: Color(0xff53B175), width: 1.5)),
                        child: Text(
                          'Withdraw',
                          style: TextStyle(
                              color: Color(0xff53B175), fontSize: 16.sp),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 24.sp,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(10.sp),
              onTap: () {
                Get.to(() => Earning_history());
              },
              child: Container(
                alignment: Alignment.center,
                height: 52.sp,
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    border: Border.all(color: Color(0xff242424), width: 2)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "View earning history",
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 18.sp,
                            color: Color(0xff4F4F5B),
                          ))
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Monthly Earnings",
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5.sp,
                    ),
                    Row(
                      children: [
                        Text(
                          "Total earnings by year 2020",
                          style: TextStyle(
                              fontSize: 13.5.sp,
                              color: Color(0xff81818A),
                              fontWeight: FontWeight.w400),
                        ),
                        Image.asset(
                          'images/Dimond_fill.png',
                          height: 17.h,
                          width: 17.h,
                          fit: BoxFit.cover,
                        ),
                        Text(
                          "15500",
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                    height: 37.sp,
                    width: 83.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.sp),
                        border:
                            Border.all(color: Color(0xff81818A), width: 1.5)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: DropdownButton(
                        underline: Container(),
                        value: selectedValue,
                        hint: Text("Country"),
                        style: TextStyle(fontSize: 14.sp, color: Colors.white),
                        isExpanded: true,
                        iconSize: 25.sp,
                        dropdownColor: Color(0xff81818A),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: year.map((dynamic items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (dynamic newValue) {
                          setState(() {
                            selectedValue = newValue!;
                          });
                        },
                      ),
                    ))
              ],
            ),
            SizedBox(
              height: 20.sp,
            ),
            Divider(
              thickness: 2.5,
              color: Color(0xff242424),
            ),

            /// Chart
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 22.h),
                child: Container(
                  height: 250.h,
                  width: Get.width,
                  color: Colors.black,
                  //Initialize chart
                  child: SfCartesianChart(
                    borderWidth: 0,
                    plotAreaBorderColor: Colors.black,

                    borderColor: Colors.black,

                    /// X Axis
                    primaryXAxis: CategoryAxis(
                      labelStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                      borderColor: Colors.transparent,
                      majorGridLines:
                          MajorGridLines(width: 0, color: Colors.black),
                      axisLine: AxisLine(width: 0),
                    ),
                    plotAreaBackgroundColor: Colors.black,

                    /// Y Axis
                    primaryYAxis: NumericAxis(
                      numberFormat: NumberFormat.compact(),
                      labelStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                      interval: 10000,
                      maximum: 60000,
                      majorGridLines: MajorGridLines(width: 0),
                      axisLine: AxisLine(width: 0),
                    ),
                    backgroundColor: Colors.black,
                    series: <ChartSeries<ChartData, String>>[
                      ColumnSeries<ChartData, String>(
                        dataSource: chartData,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        width: 0.5,
                        borderColor: Colors.black,
                        color: Color(0xff4B53FF),
                        spacing: 0.022,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}

selectBankAccountBottomSheet(BuildContext context) {}

class SelectBankController extends GetxController {
  var isCheck = 0.obs;

  isChecked(index) {
    isCheck.value = index;
  }
}
