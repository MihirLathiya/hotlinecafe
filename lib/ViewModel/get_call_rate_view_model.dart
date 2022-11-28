import 'package:get/get.dart';
import 'package:hotlinecafee/Model/Repo/get_call_rate_repo.dart';
import 'package:hotlinecafee/Model/Response_model/get_call_rate_res_model.dart';

import '../model/apis/api_response.dart';

class GetCallRateViewModel extends GetxController {
  ApiResponse _getCallRateApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getCallRateApiResponse => _getCallRateApiResponse;

  Future<void> getCallRateViewModel({Map<String, dynamic>? model}) async {
    _getCallRateApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      GetCallRateResponseModel response =
          await GetCallRateRepo().getCallRateRepo(body: model);
      print("GetCallRateResponseModel=response==>$response");

      _getCallRateApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("GetCallRateResponseModel=e==>$e");
      _getCallRateApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
