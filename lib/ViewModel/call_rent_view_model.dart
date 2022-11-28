import 'package:get/get.dart';
import 'package:hotlinecafee/model/repo/call_rate_repo.dart';
import 'package:hotlinecafee/model/response_model/call_rate_res_model.dart';

import '../model/apis/api_response.dart';

class CallRentViewModel extends GetxController {
  ApiResponse _callRentApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get callRentApiResponse => _callRentApiResponse;

  Future<void> callRentViewModel({Map<String, dynamic>? model}) async {
    _callRentApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      CallRateResponseModel response =
          await CallRateRepo().callRateRepo(body: model);
      print("CallRateResponseModel=response==>$response");

      _callRentApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("CallRateResponseModel=e==>$e");
      _callRentApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
