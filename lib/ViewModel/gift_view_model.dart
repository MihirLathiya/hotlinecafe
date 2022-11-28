import 'package:get/get.dart';
import 'package:hotlinecafee/model/repo/gift_repo.dart';
import 'package:hotlinecafee/model/response_model/send_gift_res_model.dart';

import '../model/apis/api_response.dart';

class GiftViewModel extends GetxController {
  ApiResponse _sendGiftApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get sendGiftApiResponse => _sendGiftApiResponse;

  Future<void> sendGiftViewModel({Map<String, dynamic>? model}) async {
    _sendGiftApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      SendGiftResponseModel response =
          await GiftRepo().sendGiftRepo(body: model);
      print("SendGiftResponseModel=response==>$response");

      _sendGiftApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("SendGiftResponseModel=e==>$e");
      _sendGiftApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
