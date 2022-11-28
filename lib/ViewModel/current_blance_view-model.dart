import 'package:get/get.dart';
import 'package:hotlinecafee/Model/Repo/current_blance_repo.dart';
import 'package:hotlinecafee/model/apis/api_response.dart';

import '../Model/Response_model/current_blance_res_model.dart';

class CurrentBalanceViewModel extends GetxController {
  ApiResponse _currentBalanceApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get currentBalanceApiResponse => _currentBalanceApiResponse;

  Future<void> currentBalanceViewModel({Map<String, dynamic>? model}) async {
    _currentBalanceApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      CurrentBalanceResponseModel response =
          await CurrentBalanceRepo().currentBalanceRepo(body: model);

      print("CurrentBalanceResponseModel=response==>$response");

      _currentBalanceApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("CurrentBalanceResponseModel=e==>$e");
      _currentBalanceApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  void updateData() {
    update();
  }
}
