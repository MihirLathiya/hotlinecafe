import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hotlinecafee/Model/Apis/api_response.dart';
import 'package:hotlinecafee/Model/Response_model/current_blance_res_model.dart';
import 'package:hotlinecafee/Model/Response_model/view_profile_res_model.dart';
import 'package:hotlinecafee/Preference/preference.dart';
import 'package:hotlinecafee/ViewModel/current_blance_view-model.dart';
import 'package:hotlinecafee/ViewModel/view_profile_view_model.dart';
import 'package:hotlinecafee/common/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  late Razorpay _razorpay;
  int? amounts;
  double? paying;
  CurrentBalanceViewModel _currentBalanceViewModel =
      Get.put(CurrentBalanceViewModel());

  void _handlePaymentSuccess(PaymentSuccessResponse response1) async {
    print('Success Response: ${response1.paymentId}');
    print('Success Response: ${response1.orderId}');

    var headers = {'Cookie': 'PHPSESSID=d878b09cce88992368db1af0e2d0ac31'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://irisinformatics.net/dating/wb/buy_coin'));
    request.fields.addAll({
      'user_id': '${PreferenceManager.getUserId()}',
      'amount': '$selectPrice',
      'transaction_id': '${response1.paymentId}'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('===== PAYMENT ===== ${await response.stream.bytesToString()}');
      CommonSnackBar.commonSnackBar(
        message: 'PAYMENT SUCCESS',
      );
      currentBalance();
      if (_currentBalanceViewModel.currentBalanceApiResponse.status
              .toString() ==
          Status.COMPLETE.toString()) {
        CurrentBalanceResponseModel resp =
            _currentBalanceViewModel.currentBalanceApiResponse.data;
      }
      // await _currentBalanceViewModel.currentBalanceViewModel(
      //   model: {'user_id': PreferenceManager.getUserId()},
      // );
      // if (_currentBalanceViewModel.currentBalanceApiResponse.status ==
      //     Status.COMPLETE) {
      //   _currentBalanceViewModel.updateData();
      //   log('CURRENT BLANCE:-${PreferenceManager.getCurrentBalance()}');
      // }
    } else {
      print(response.reasonPhrase);
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("ERROR123: " + response.code.toString() + " - " + response.message!);

    CommonSnackBar.commonSnackBar(message: response.message!);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');

    CommonSnackBar.commonSnackBar(
      message: "EXTERNAL_WALLET: " + response.walletName!,
    );
  }

  void initState() {
    super.initState();
    currentBalance();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  currentBalance() async {
    await _currentBalanceViewModel.currentBalanceViewModel(
      model: {'user_id': PreferenceManager.getUserId()},
    );
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  var selectPrice = '';
  void openCheckout({
    int? price,
  }) async {
    var options = {
      'key': 'rzp_test_GDJF4258qNBzU3',
      'amount': price! * 100,
      'name': 'Hotline Cafe',
      'description': 'Coin',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {
        'contact': '${PreferenceManager.getMobile()}',
        'email': 'test@razorpay.com'
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
      CommonSnackBar.commonSnackBar(
        message: '$e',
      );
    }
  }

  List price = [
    {'coin': '5000', 'price': 100},
    {'coin': '15,000', 'price': 300},
    {'coin': '45,000', 'price': 900},
    {'coin': '135,000', 'price': 2700},
    {'coin': '450,000', 'price': 9000},
  ];
  ViewProfileViewModel viewProfileViewModel = Get.put(ViewProfileViewModel());

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Coin'),
        centerTitle: true,
        leading: IconButton(
          splashRadius: 20,
          onPressed: () async {
            Get.back();
            await viewProfileViewModel.viewProfileViewModel(model: {
              "user_id": PreferenceManager.getUserId(),
              "profile_id": PreferenceManager.getUserId()
            });
            if (viewProfileViewModel.apiResponse.status == Status.COMPLETE) {
              ViewProfileResponseModel viewProfileResponseModel =
                  viewProfileViewModel.apiResponse.data;
            }
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        bottom: PreferredSize(
            child: Divider(color: Colors.white),
            preferredSize: Size.fromHeight(4.h)),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white10,
            ),
            child: Row(
              children: [
                Image.asset(
                  'images/svg/Coin.png',
                  height: 40.h,
                  width: 40.h,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Coin balance',
                      style: TextStyle(
                        color: Colors.white24,
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    GetBuilder<CurrentBalanceViewModel>(
                      builder: (controller) {
                        if (_currentBalanceViewModel
                                .currentBalanceApiResponse.status
                                .toString() ==
                            Status.COMPLETE.toString()) {
                          CurrentBalanceResponseModel resp =
                              _currentBalanceViewModel
                                  .currentBalanceApiResponse.data;
                          return Text(
                            '${resp.data!.balance}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    )
                  ],
                ),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Coin history',
                    style: TextStyle(color: Color(0xffE76944), fontSize: 14.h),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: price.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      openCheckout(price: price[index]['price']);
                      setState(() {
                        selectPrice = price[index]['price'].toString();
                      });
                    },
                    child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.white12),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            'images/svg/Coin.png',
                            height: 30.h,
                            width: 30.h,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${price[index]['coin']}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '₹${price[index]['price']}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
