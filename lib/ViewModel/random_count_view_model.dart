import 'package:get/get.dart';
import 'package:hotlinecafee/Model/Apis/api_response.dart';
import 'package:hotlinecafee/Model/Repo/rendom_count_repo.dart';
import 'package:hotlinecafee/Model/Response_model/random_count_res_model.dart';

class RandomCountViewModel extends GetxController {
  ApiResponse _randomCountApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get randomCountApiResponse => _randomCountApiResponse;

  Future<void> randomCountViewModel({Map<String, dynamic>? model}) async {
    _randomCountApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      RandomCountResponseModel response =
          await RandomCountRepo().randomCountRepo(body: model);
      print("RandomCountResponseModel=response==>$response");

      _randomCountApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("RandomCountResponseModel=e==>$e");
      _randomCountApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
