import 'package:get/get.dart';
import 'package:hotlinecafee/Model/Repo/gift_history_repo.dart';
import 'package:hotlinecafee/Model/Response_model/gift_history_res_model.dart';

import '../model/apis/api_response.dart';

class GiftHistoryViewModel extends GetxController {
  ApiResponse _giftHistoryApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get giftHistoryApiResponse => _giftHistoryApiResponse;

  Future<void> giftHistoryViewModel({Map<String, dynamic>? model}) async {
    _giftHistoryApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      GiftHistoryResponseModel response =
          await GiftHistoryRepo().giftHistoryRepo(body: model);
      print("GiftHistoryResponseModel=response==>$response");

      _giftHistoryApiResponse = ApiResponse.complete(response);
      print("_giftHistoryApiResponse==>${_giftHistoryApiResponse.status}");
    } catch (e) {
      print("GiftHistoryResponseModel=e==>$e");
      _giftHistoryApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
