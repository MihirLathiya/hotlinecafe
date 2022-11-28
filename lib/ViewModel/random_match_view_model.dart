import 'package:get/get.dart';
import 'package:hotlinecafee/model/repo/random_match_repo.dart';
import 'package:hotlinecafee/model/response_model/random_match_on_off_res_model.dart';
import 'package:hotlinecafee/model/response_model/random_match_res_model.dart';
import 'package:hotlinecafee/model/response_model/random_off_res_model.dart';

import '../model/apis/api_response.dart';

class RandomMatchViewModel extends GetxController {
  ApiResponse _randomApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get randomApiResponse => _randomApiResponse;
  // bool isMatch = false;

  Future<void> randomMatchViewModel({Map<String, dynamic>? model}) async {
    _randomApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      RandomMatchResponseModel responseData =
          await RandomMatchRepo().randomMatchRepo(body: model);
      print("RandomMatchResponseModel=response==>$responseData");

      // isMatch = true;
      _randomApiResponse = ApiResponse.complete(responseData);
    } catch (e) {
      // isMatch = false;
      print("RandomMatchResponseModel=e==>$e");
      _randomApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  ApiResponse _randomOnOffApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get randomOnOffApiResponse => _randomOnOffApiResponse;

  Future randomMatchOnOffViewModel({Map<String, dynamic>? model}) async {
    _randomOnOffApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      RandomMatchOnOffResponseModel response =
          await RandomMatchRepo().randomMatchOnOffRepo(body: model);
      print("RandomMatchOnOffResponseModel=response==>$response");

      _randomOnOffApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("RandomMatchOnOffResponseModel=e==>$e");
      _randomOnOffApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  ApiResponse _randomOffApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get randomOffApiResponse => _randomOffApiResponse;

  Future randomMatchOffViewModel({Map<String, dynamic>? model}) async {
    _randomOffApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      RandomMatchOffResponseModel response =
          await RandomMatchRepo().randomMatchOffRepo(body: model);
      print("RandomMatchOnOffResponseModel=response==>$response");

      _randomOffApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("RandomMatchOnOffResponseModel=e==>$e");
      _randomOffApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
