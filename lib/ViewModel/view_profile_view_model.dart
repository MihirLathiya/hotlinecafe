import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hotlinecafee/Model/Response_model/daat.dart';
import 'package:hotlinecafee/Preference/preference.dart';
import 'package:hotlinecafee/common/chat_commons.dart';
import 'package:hotlinecafee/model/repo/agora_token_repo.dart';
import 'package:hotlinecafee/model/repo/view_profile_repo.dart';
import 'package:hotlinecafee/model/response_model/gift_list_res_model.dart';
import 'package:hotlinecafee/model/response_model/my_gift_collection_res_model.dart';
import 'package:hotlinecafee/model/response_model/view_profile_res_model.dart';

import '../model/apis/api_response.dart';

class ViewProfileViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');
  ApiResponse get apiResponse => _apiResponse;
  List<ViewProfileResponseModel> x = [];
  Future<void> viewProfileViewModel({Map<String, dynamic>? model}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    // update();
    try {
      ViewProfileResponseModel viewProfileResponseModel =
          await ViewProfileRepo().viewProfileRepo(body: model);
      print("ViewProfileResponseModel=response==>$viewProfileResponseModel");

      _apiResponse = ApiResponse.complete(viewProfileResponseModel);
    } catch (e) {
      print("ViewProfileResponseModel=e==>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  void apiResponseClear() {
    _apiResponse = ApiResponse.initial(message: 'Initialization');
    print('--_apiResponse--${_apiResponse.status}');
  }

  void apiResponseUnClear() {
    _apiResponse = ApiResponse.initial(message: 'Initialization');
    print('--_apiResponse--${_apiResponse.status}');
  }

  /// AGORA TOKEN

  ApiResponse _apiResponse1 = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse1 => _apiResponse1;
  Future<void> agoraTokenViewModel({Map<String, dynamic>? model}) async {
    _apiResponse1 = ApiResponse.loading(message: 'Loading');
    update();
    try {
      AgoraTokenResponseModel response =
          await AgoraTokenRepo().agoraTokenRepo(body: model);
      print("AgoraTokenResponseModel=response==>$response");

      _apiResponse1 = ApiResponse.complete(response);
    } catch (e) {
      print("AgoraTokenResponseModel=e==>$e");
      _apiResponse1 = ApiResponse.error(message: 'error');
    }
    update();
  }

  void setState() {
    update();
  }

  Future<void> getDataFromFirebase() async {
    x.clear();

    QuerySnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore
        .collection('chatroom')
        .where(
          'user${PreferenceManager.getUserId()}',
          isEqualTo: PreferenceManager.getUserId(),
        )
        .get();
    print('--snapshot---${snapshot.docs}');

    if (snapshot.docs.isNotEmpty) {
      snapshot.docs.forEach(
        (element) async {
          if (element['user1'] == PreferenceManager.getUserId()) {
            log('USERIDS ${element['user']}');
            await viewProfileViewModel(
              model: {
                'user_id': "${element['user']}",
                "profile_id": "${element['user']}",
              },
            );
          } else {
            await viewProfileViewModel(
              model: {
                'user_id': "${element['user1']}",
                "profile_id": "${element['user1']}",
              },
            );
          }

          // if (apiResponse.status == Status.COMPLETE) {
          ViewProfileResponseModel viewProfileResponseModel = apiResponse.data;

          x.add(viewProfileResponseModel);
          // } else {
          //   ShimmerLoading(count: 10);
          // }
        },
      );
    } else {
      _apiResponse = ApiResponse.complete();
    }

    update();
  }
}

class FollowController extends GetxController {
  int follow = 0;
  void getFollow(int value) {
    follow = value;
    update();
  }
}

class GiftListViewModel extends GetxController {
  int selectedGift = 0;
  String selectedGiftID = '0';
  int counter = 1;
  String image = '';
  var giftPrice = '100';

  ApiResponse _giftApiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get giftApiResponse => _giftApiResponse;
  Future<void> giftListViewModel({Map<String, dynamic>? model}) async {
    _giftApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      GiftListResponseModel response =
          await ViewProfileRepo().giftListRepo(body: model);
      print("GiftListResponseModel=response==>$response");

      _giftApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("GiftListResponseModel=e==>$e");
      _giftApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  /// MY GIFT COLLECTION
  ApiResponse _giftCollectionApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get giftCollectionApiResponse => _giftCollectionApiResponse;
  Future<void> myGiftCollectionViewModel({Map<String, dynamic>? model}) async {
    _giftCollectionApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      MyGiftCollectionResponseModel response =
          await ViewProfileRepo().myGiftCollectionRepo(body: model);
      print("GiftListResponseModel=response==>$response");

      _giftCollectionApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("GiftListResponseModel=e==>$e");
      _giftCollectionApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  selectGift(index, Id, price, images) {
    selectedGift = index;
    selectedGiftID = Id;
    giftPrice = price;
    counter = 1;
    image = images;
    update();
  }

  increment() {
    counter++;

    update();
  }

  decrement() {
    if (counter > 1) {
      counter--;
    }

    update();
  }
}
