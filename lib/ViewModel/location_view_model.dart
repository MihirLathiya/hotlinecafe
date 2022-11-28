import 'package:get/get.dart';
import 'package:hotlinecafee/model/repo/location_repo.dart';
import 'package:hotlinecafee/model/response_model/location_res_model.dart';

import '../model/apis/api_response.dart';

class LocationViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> locationViewModel({Map<String, dynamic>? model}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      LocationResponseModel response =
          await LocationRepo().locationRepo(body: model);
      print("LocationResponseModel=response==>$response");

      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("LocationResponseModel=e==>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
