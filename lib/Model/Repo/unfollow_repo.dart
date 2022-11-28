import 'package:hotlinecafee/model/response_model/unfollow_res_model.dart';

import '../services/api_service.dart';
import '../services/base_service.dart';

class UnFollowRepo extends BaseService {
  Future<UnFollowResponseModel> unFollowRepo(
      {Map<String, dynamic>? body}) async {
    var response = await APIService()
        .getResponse(url: unFollow, body: body, apitype: APIType.aPost);

    UnFollowResponseModel unFollowResponseModel =
        await UnFollowResponseModel.fromJson(response);
    print('RESPONSE $response');
    return unFollowResponseModel;
  }
}
