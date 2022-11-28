import 'package:get/get.dart';
import 'package:hotlinecafee/model/apis/api_response.dart';
import 'package:hotlinecafee/model/repo/follow_repo.dart';
import 'package:hotlinecafee/model/repo/unfollow_repo.dart';
import 'package:hotlinecafee/model/response_model/follow_res_model.dart';
import 'package:hotlinecafee/model/response_model/unfollow_res_model.dart';

class FollowViewModel extends GetxController {
  ApiResponse _followApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get followApiResponse => _followApiResponse;

  Future<void> followViewModel({Map<String, dynamic>? model}) async {
    _followApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      FollowResponseModel response = await FollowRepo().followRepo(body: model);
      print("FollowResponseModel=response==>$response");

      _followApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("FollowResponseModel=e==>$e");
      _followApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  /// UNFOLLOW
  ApiResponse _unFollowApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get unFollowApiResponse => _unFollowApiResponse;

  Future<void> unFollowViewModel({Map<String, dynamic>? model}) async {
    _unFollowApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      UnFollowResponseModel response =
          await UnFollowRepo().unFollowRepo(body: model);
      print("UnFollowResponseModel=response==>$response");

      _unFollowApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("UnFollowResponseModel=e==>$e");
      _unFollowApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
