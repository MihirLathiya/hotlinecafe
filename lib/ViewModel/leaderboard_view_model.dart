import 'package:get/get.dart';
import 'package:hotlinecafee/Model/Repo/laedorboard_repo.dart';
import 'package:hotlinecafee/Model/Response_model/leadorboard_res_model.dart';

import '../model/apis/api_response.dart';

class LeaderboardViewModel extends GetxController {
  ApiResponse _leaderboardApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get leaderboardApiResponse => _leaderboardApiResponse;

  Future<void> leaderboardViewModel({Map<String, dynamic>? model}) async {
    _leaderboardApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      LeaderboardResponseModel response =
          await LeaderboardRepo().leaderboardRepo(body: model);
      print("LeaderboardResponseModel=response==>$response");

      _leaderboardApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("LeaderboardResponseModel=e==>$e");
      _leaderboardApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
