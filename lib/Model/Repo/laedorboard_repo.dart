import 'package:hotlinecafee/Model/Response_model/leadorboard_res_model.dart';
import 'package:hotlinecafee/Model/services/api_service.dart';
import 'package:hotlinecafee/Model/services/base_service.dart';

class LeaderboardRepo extends BaseService {
  Future<LeaderboardResponseModel> leaderboardRepo(
      {Map<String, dynamic>? body}) async {
    var response = await APIService()
        .getResponse(url: leaderboard, body: body, apitype: APIType.aPost);
    LeaderboardResponseModel leaderboardResponseModel =
        LeaderboardResponseModel.fromJson(response);
    return leaderboardResponseModel;
  }
}
