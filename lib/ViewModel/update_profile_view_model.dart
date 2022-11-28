import 'package:get/get.dart';
import 'package:hotlinecafee/model/repo/update_profile_repo.dart';
import 'package:hotlinecafee/model/response_model/update_profile_res_model.dart';

import '../model/apis/api_response.dart';

class UpdateProfileViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> updateProfileViewModel({Map<String, dynamic>? model}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      UpdateProfileResponseModel updateProfileResponse =
          await UpdateProfileRepo().updateProfileRepo(body: model);
      print("UpdateProfileResponseModel=response==>$updateProfileResponse");

      _apiResponse = ApiResponse.complete(updateProfileResponse);
    } catch (e) {
      print("UpdateProfileResponseModel=e==>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
