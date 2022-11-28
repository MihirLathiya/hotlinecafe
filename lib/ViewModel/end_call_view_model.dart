import 'package:get/get.dart';
import 'package:hotlinecafee/Model/Apis/api_response.dart';
import 'package:hotlinecafee/Model/Repo/end_call_repo.dart';
import 'package:hotlinecafee/Model/Response_model/end_call_res_model.dart';

class EndCallViewModel extends GetxController {
  ApiResponse _endCallApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get endCallApiResponse => _endCallApiResponse;

  Future<void> endCallViewModel({Map<String, dynamic>? model}) async {
    _endCallApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      EndCallResponseModel response =
          await EndCallRepo().endCallRateRepo(body: model);
      print("EndCallResponseModel=response==>$response");

      _endCallApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("EndCallResponseModel=e==>$e");
      _endCallApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
