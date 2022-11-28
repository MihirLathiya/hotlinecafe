import 'dart:developer';

import 'package:hotlinecafee/model/response_model/gift_list_res_model.dart';
import 'package:hotlinecafee/model/response_model/my_gift_collection_res_model.dart';
import 'package:hotlinecafee/model/response_model/view_profile_res_model.dart';

import '../services/api_service.dart';
import '../services/base_service.dart';

class ViewProfileRepo extends BaseService {
  Future<ViewProfileResponseModel> viewProfileRepo(
      {Map<String, dynamic>? body}) async {
    var response = await APIService()
        .getResponse(url: viewProfile, body: body, apitype: APIType.aPost);
    ViewProfileResponseModel viewProfileResponseModel =
        ViewProfileResponseModel.fromJson(response);
    log('VIEWPROFILE$response');
    return viewProfileResponseModel;
  }

  ///  GIFT LIST
  Future<GiftListResponseModel> giftListRepo(
      {Map<String, dynamic>? body}) async {
    var response = await APIService()
        .getResponse(url: giftList, body: body, apitype: APIType.aPost);
    GiftListResponseModel giftListResponseModel =
        GiftListResponseModel.fromJson(response);
    log('GIFT LIST $response');
    return giftListResponseModel;
  }

  /// MY GIFT COLLECTION
  Future<MyGiftCollectionResponseModel> myGiftCollectionRepo(
      {Map<String, dynamic>? body}) async {
    var response = await APIService().getResponse(
        url: my_gift_collection, body: body, apitype: APIType.aPost);
    MyGiftCollectionResponseModel myGiftCollectionResponseModel =
        MyGiftCollectionResponseModel.fromJson(response);
    return myGiftCollectionResponseModel;
  }
}
