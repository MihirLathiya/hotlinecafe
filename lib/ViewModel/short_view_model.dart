import 'package:get/get.dart';
import 'package:hotlinecafee/model/repo/short_repo.dart';
import 'package:hotlinecafee/model/response_model/short_res_model.dart';

import '../model/apis/api_response.dart';

class ShortViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> shortViewModel({Map<String, dynamic>? model}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      ShortResponseModel response = await ShortRepo().shortRepo(body: model);
      print("ShortResponseModel=response==>$response");

      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("ShortResponseModel=e==>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
